#!/bin/bash

# Check if conda is installed
if ! command -v conda &> /dev/null
then
    echo "The 'conda' command could not be found. Exiting..."
    exit
fi

# Check if the template files are here
if [[ ! -f ./templates/activate.sh ]] || [[ ! -f ./templates/deactivate.sh ]]; then
    echo "Could not find template files in activate.sh and deactivate.sh in templates/"
    echo "Please make sure to execute this script with the templaes present in this relative path"
    echo "Exiting."
    exit 1
fi

# Create new or link existing?
echo "Do you want to create a new Conda environment or import IceTray into an existing environment?"
select response in "Create" "Import"; do
    case $response in
        Create ) create_new=true;;
        Import ) create_new=false;;
    esac
    if [[ -v create_new ]]; then
        break
    else
        echo "Please choose one of the options."
    fi
done

# Configure Conda env
while true; do
    read -p "Enter conda environment name: " env_name
        # Check if the environment exists
        if { conda env list | grep $env_name; } >/dev/null 2>&1; then
            if $create_new; then
                echo "A Conda environment named $env_name already exists."
            else
                break
            fi
        else
            if $create_new; then
                break
            else
                echo "Could not find a Conda environment named $env_name."
            fi
        fi
        echo "Please try again."
done

# Get path to icetray env
message="Enter the full absolute path to the IceTray environment (build folder)"
message="$message which you want to use in this conda environment:"

# Check icetray env and get Python version
while true; do
    read -rep "$message"$'\n' icetray_path
    icetray_env=$icetray_path"env-shell.sh"
    if ! [ -f "$icetray_env" ]; then
        icetray_env="$icetray_path/env-shell.sh"
        if ! [ -f "$icetray_env" ]; then
            echo "Could not find env-shell.sh in $icetray_path!"
            continue
        fi
    fi
    python_version=$(cat $icetray_env | grep Python | awk '{print $NF}')
    read -p "The Python version is $python_version, is that correct? [y/n]" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) echo "Please start over";;
        * ) echo "Please answer yes or no.";;
    esac
done


# Create/check env
if $create_new; then
    echo "Creating your $env_name environment now..."
    conda create -y -n "$env_name" python="$python_version"
else
    conda_python_version=$(conda run -n $env_name python --version | awk '{print $2}')
    echo "The Python version in $env_name is $conda_python_version".
    if ! [ "$python_version" = "$conda_python_version" ]; then
        echo "This does not match the IceTray Python version, which is $python_version."
        echo "Importing this IceTray build will not work, please start over."
        exit
    fi
fi


# Install requirements
echo "Installing some requirements into $env_name environment..."
conda install -n "$env_name" -y numpy scipy pandas pytables pyaml

## Add activate and deactivate scripts to load icetray env
# Start by grabbing the environment path
conda_env_path=$(conda run -n $env_name conda info | grep "active env location" | cut -f2- -d:)
# remove first character which is a space
conda_env_path="${conda_env_path:1}"

echo "The einvornment is located in $conda_env_path"
echo "Creating activate and deactivate scripts for icetray environment now..."
# Create directories
mkdir -p $conda_env_path/etc/conda/activate.d
mkdir -p $conda_env_path/etc/conda/deactivate.d
# Edit template
sed "s|_ENV_SHELL_PATH_|$icetray_env|g" ./templates/activate.sh > env_vars.sh
# Move the scripts over
mv ./env_vars.sh $conda_env_path/etc/conda/activate.d
cp ./templates/deactivate.sh $conda_env_path/etc/conda/deactivate.d/env_vars.sh
echo "Setup complete."

# Final message
echo "======================================="
echo "To activate this environment use:"
echo "conda activate $env_name"
echo "Warning: You might find missing Python packages."
echo "Simply install packages with conda install <package> or"
echo "pip install <package>"
echo "after activating the enviornment."
echo "======================================="
echo -e "\a"