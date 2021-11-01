## PYTHONPATH
if ! [ -z "${_OLD_VIRTUAL_PYTHONPATH+_}"  ] ; then
    export PYTHONPATH="$_OLD_VIRTUAL_PYTHONPATH"
fi

## LD_LIBRARY_PATH
if ! [ -z "${_OLD_VIRTUAL_LD_LIBRARY_PATH+_}"  ] ; then
    export LD_LIBRARY_PATH="$_OLD_VIRTUAL_LD_LIBRARY_PATH"
fi

## DYLD_LIBRARY_PATH
if ! [ -z "${DYLD_LIBRARY_PATH+_}"  ] ; then
    export DYLD_LIBRARY_PATH="$_OLD_DYLD_LIBRARY_PATH"
fi

## ROOTSYS
if ! [ -z "${_OLD_VIRTUAL_ROOTSYS+_}"  ] ; then
    export ROOTSYS="$_OLD_VIRTUAL_ROOTSYS"
fi

## I3_BUILD
if ! [ -z "${I3_BUILD+_}"  ] ; then
    unset I3_BUILD
fi

## I3_SRC
if ! [ -z "${I3_SRC+_}"  ] ; then
    unset I3_SRC
fi

## I3_SHELL
if ! [ -z "${I3_SHELL+_}"  ] ; then
    unset I3_SHELL
fi

## I3_TESTDATA
if ! [ -z "${I3_TESTDATA+_}"  ] ; then
    unset I3_TESTDATA
fi
