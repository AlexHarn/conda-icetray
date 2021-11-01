icetray_env=$(_ENV_SHELL_PATH_ env)
## PATH
icetray_path=$(echo "$icetray_env" | grep ^PATH= | cut -f2- -d=)
PATH="$PATH:$icetray_path"
export PATH

## PYTHONPATH
_OLD_VIRTUAL_PYTHONPATH="$PYTHONPATH"
icetray_pythonpath=$(echo "$icetray_env" | grep ^PYTHONPATH= | cut -f2- -d=)
PYTHONPATH="$PYTHONPATH:$icetray_pythonpath"
export PYTHONPATH

## LD_LIBRARY_PATH
_OLD_VIRTUAL_LD_LIBRARY_PATH="$LD_LIBRARY_PATH"
icetray_ld_library_path=$(echo "$icetray_env" | grep ^LD_LIBRARY_PATH= | cut -f2- -d=)
export LD_LIBRARY_PATH

## DYLD_LIBRARY_PATH
_OLD_VIRTUAL_DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH"
icetray_dyd_library_path=$(echo "$icetray_env" | grep ^DYLD_LIBRARY_PATH= | cut -f2- -d=)
export DYLD_LIBRARY_PATH

## ROOTSYS
_OLD_VIRTUAL_ROOTSYS="$ROOTSYS"
icetray_rootsys=$(echo "$icetray_env" | grep ^ROOTSYS= | cut -f2- -d=)
export ROOTSYS

## other
export I3_SHELL=$SHELL
export I3_SRC=$(echo "$icetray_env" | grep ^I3_SRC= | cut -f2- -d=)
export I3_BUILD=$(echo "$icetray_env" | grep ^I3_BUILD= | cut -f2- -d=)
export I3_TESTDATA=$(echo "$icetray_env" | grep ^I3_TESTDATA= | cut -f2- -d=)
