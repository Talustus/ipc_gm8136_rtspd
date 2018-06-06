GMLIB=../../../gm_lib

ifeq ($(shell find $(GMLIB)/../ -name gmlib.mak),)
    sinclude /usr/src/arm-linux-3.3/linux-3.3-fa/cross_compiler_def
else
    sinclude $(GMLIB)/gmlib.mak
endif

uclibc=$(shell echo $(CROSS_COMPILE)|grep uclib)
ifeq ($(uclibc),)
    LIBRTSP=librtsp_glibc.a
else
    LIBRTSP=librtsp.a
endif


CC=$(CROSS_COMPILE)gcc
CPP=$(CC) -E
LD=$(CROSS_COMPILE)ld
AS=$(CROSS_COMPILE)as
MAKE=make
PROGS=rtspd

LDFLAGS += -static -L$(GMLIB)/lib -L/usr/src/arm-linux-3.3/toolchain_gnueabi-4.4.0_ARMv5TE/usr/arm-unknown-linux-uclibcgnueabi/sysroot/lib -lpthread -lm -lrt -lgm
#CFLAGS += -I$(GMLIB)/inc
CFLAGS += -g -s -static -Wall -I$(GMLIB)/inc

TARGETS := $(PROGS)

.PHONY: $(TARGETS)

all: $(TARGETS)

$(TARGETS): %: %.c Makefile $(GMLIB)/inc/gmlib.h
	$(CC) $(CFLAGS) $< $(LIBRTSP) $(LDFLAGS) -o $@

clean:
	rm -f $(TARGETS)



