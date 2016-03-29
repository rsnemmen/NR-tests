.IGNORE:

SHELL = /bin/sh

prefix = /home/fpretori

LIBS       = -lm -lbbhutil -lgfortran 
LDFLAGS    = -L/$(prefix)/lib 

CC       = gcc
CFLAGS   = -I. -I$(prefix)/include  
CPPFLAGS = -I. -I$(prefix)/include 

CC_COMP  = $(CC) $(CPPFLAGS) -c $(CFLAGS)
CC_LOAD  = $(CC) $(CFLAGS) $(LDFLAGS) 

F77      = gfortran
F77FLAGS = -O3 -fno-second-underscore 

F77_COMP   = $(F77) -c $(F77FLAGS) 
F77_LOAD   = $(F77) $(F77FLAGS) $(F77_LDFLAGS) $(LDFLAGS) 

EXECUTABLES     = wave
# Miscellaneous files to clean up
MISCDATAFILES   =

SRC = *.f *.inc

all: $(EXECUTABLES)

.f.o:
	$(F77_COMP) $*.f 

.c.o:
	$(CC_COMP) -c $*.c

install: all
	echo "Made all ... no installation"

all: $(EXECUTABLES)

wave.o: wave.h 

WAVE_OBJS = wave.o sf_evo.o 
wave: $(WAVE_OBJS) 
	$(CC_LOAD) $(WAVE_OBJS) $(LIBS) -o wave

clean: 
	/bin/rm $(WAVE_OBJS)
	/bin/rm $(EXECUTABLES)
