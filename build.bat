
goto %1

:watcom
rem ############# WATCOM ########################
set PATH=C:\bin;C:\watcom\binw;%PATH%
rem # -we treat all warnings as errors
rem # -wx set warning level to max
rem # -zq operate quietly
rem # -fm[=map_file]  generate map file
rem # -fe=executable  name executable file
rem # -m{t,s,m,c,l,h}  memory model

set WATCOM=C:\WATCOM
set INCLUDE=C:\WATCOM\h
set CC=wcl
set COMFLAGS=-mt -lt
set EXEFLAGS=-mc
set CFLAGS=-oas -bt=DOS -zp1 -s -0 -wx -we -zq -fm %EXEFLAGS% -fe=
goto doit

:tcc
rem ############# TURBO_C ########################
set PATH=C:\bin;C:\tc\bin;%PATH%
rem # -w warn -M create map -f- no floating point -Z register optimize
rem # -O jump optimize -k- no standard stack frome -K unsigned char
rem # -exxx executable name (must be last) -mt tiny (default is small)
rem # -N stack checking -a- byte alignment  -ln no default libs
rem # -lt create .com file -lx no map file ...
rem # *** changed 7/2004: tiny has near qsort / malloc pointers, very limited!
rem # compact large: large has far function pointers, compact only far heap.
rem # makes no real difference here, but compact saves a few bytes in size.

set CC=tcc
set COMFLAGS=-mt -lt -Z -O -k-
set EXEFLAGS=-mc -N -Z -O -k-
set CFLAGS=-w -M -f- -a- -K -ln %EXEFLAGS% -e
rem tcc looks for includes from the current directory, not the location of the
rem file that's trying to include them, so add parent so it can find kitten.h
set CFLAGS=-I.. %CFLAGS%
goto doit


:doit
rem We use GNU make for all targets
make -C test
