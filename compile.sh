#!/bin/sh

###This compile script is shamelessly stolen from COMP 40

clear

set -e    # halt on first error

link=all  # link all binaries by default
linked=no # track whether we linked

case $1 in  
  -nolink) link=none ; shift ;;  # don't link
  -link)   link="$2" ; shift ; shift ;;  # link only one binary
esac

# these flags max out warnings and debug info
FLAGS="-g -O2 -Wall -Wextra -Werror -Wfatal-errors -std=c99 -pedantic"

rm -f *.o  # make sure no object files are left hanging around

case $# in
  0) set *.c ;; # if no args are given, compile all .c files
esac

# compile each argument to a .o file
for cfile 
do
  gcc $FLAGS $CFLAGS -O3 -ansi -Wall -c $cfile
done

########### the middle part is different for each assignment
# link together .o files + libraries to make executable binaries
# using one case statement per executable binary
case $link in
  all) gcc $FLAGS -o run *.o
              linked=yes ;;
esac

# error if asked to link something we didn't recognize
if [ $linked = no ]; then
  case $link in  # if the -link option makes no sense, complain 
    none) ;; # OK, do nothing
    *) echo "`basename $0`: don't know how to link $link" 1>&2 ; exit 1 ;;
  esac
fi