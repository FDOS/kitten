#!/bin/sh

if [ x"${COMPILER}" = "xgcc" ] ; then
  export CC="ia16-elf-gcc"
  export CFLAGS="-Wall -mcmodel=small -o"

elif [ x"${COMPILER}" = "xwatcom" ] ; then
  if [ -z "${WATCOM}" ]; then
    # Make sure this is set correctly for your system before running this script
    export WATCOM="/opt/watcom"
  fi
  export PATH=${PATH}:${WATCOM}/binl64
  export CC="wcl"
  export INCLUDE=${WATCOM}/h
  export CFLAGS="-bt=DOS -bcl=DOS -ms -lr -fe="

elif [ x"${COMPILER}" = "xwatcom-emu" ] ; then
  dosemu -q -td -K . -E "build.bat watcom"
  exit $?

elif [ x"${COMPILER}" = "xtcc-emu" ] ; then
  dosemu -q -td -K . -E "build.bat tcc"
  exit $?

else
  echo "Please set the COMPILER env var to one of"
  echo "Cross compile           : 'watcom' or 'gcc'"
  echo "Native compile (Dosemu) : 'watcom-emu' or 'tcc-emu'"
  exit 1
fi

make -C test
