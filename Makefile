# HiredisOnRamFile
#
# @author cybermilitia
# $Id$
#

OBJS = ./Ramfile.o 
#OBJS2 = 

CC      = $(CROSS)gcc
LD      = $(CROSS)gcc
DEBUG   = -g

CFLAGS  = -O3 -Wall -finline-functions
#CFLAGS += -Werror
CFLAGS += -DMALLOC_TRACE

INCLUDE += -I/usr/include/hiredis

LIBS += -lrt -lpq -lhiredis
#INCLUDE += `pkg-config --cflags glib-2.0`
#INCLUDE += `pkg-config --cflags libxml-2.0`

#LDFLAGS += `pkg-config --libs  glib-2.0`
#LDFLAGS += `pkg-config --libs libxml-2.0`

RM      = rm -f
PROG    = Ramfile


all: $(PROG)  

$(PROG): $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS) $(OBJS2) -o $(PROG) $(LIBS)

strip:
	@echo
	@echo "Before strip:"
	@file $(PROG)
	@ls -l $(PROG)
	@$(CROSS)objcopy --strip-all $(PROG)
	@echo
	@echo "Before strip:"
	@file $(PROG)
	@ls -l $(PROG)
	@echo

%.o: %.c
	$(CC) $(CFLAGS) $(DEBUG) $(INCLUDE) -c $<
	
doxy:
	[ -d ../../doxy/html ]  || mkdir ../../doxy/html
	[ -d ../../doxy/latex ] || mkdir ../../doxy/latex
	[ -d ../../doxy/man ]   || mkdir ../../doxy/man
	doxygen doxy.conf

dep: 
	gcc -MM $(INCLUDE) -c *.c > depend

clean:
	$(RM) $(PROG) *.o *.~ depend
	touch depend

install: #$(PROG)
	cp $(PROG)     /opt/ramfile/bin

execution:
	
help:
	@echo
	@echo === Hiredis ===
	@echo
	@echo "all    : compile&build all system."
	@echo "help   : now you are reading."
	@echo "clean  : clean all binary file, objects and temprory files."
	@echo "package: package the project."
	@echo "install: local install, install Hiredis under /opt/local/ directory."
	@echo
	@echo "# Cross compiling"
	@echo "$$ make clean"
	@echo "$$ CROSS=arm-linux-gnueabihf- make"
	@echo
#	@echo "# Remote install"
#	@echo "$$ REMOTE_IP=47.168.250.34 make rinstall"
	@echo

package:


	#ssh root@47.168.250.34
	#$(CC) -Wall -c -fPIC f2sql.c -o ../bin/arm/f2sql.o -lrt
	#$(CC) -shared -Wl,-soname,libf2sql.so -o ../bin/arm/f2sql.o
	#$(CC) -Wall -shared -fPIC -Wl,-soname,libf2sql.so  -o ../bin/arm/libf2sql.so.1.0 f2sql.c -DMALLOC_TRACE
	#gcc -Wall -c -fPIC f2sql.c -o ../bin/x86/f2sql.o -lrt
	#gcc -shared -Wl,-soname,libf2sql.so -o ../bin/x86/f2sql.o
	#gcc -Wall -shared -fPIC -Wl,-soname,libf2sql.so  -o ../bin/x86/libf2sql.so.1.0 f2sql.c -DMALLOC_TRACE
	
	include depend
