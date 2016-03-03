arch := $(shell uname -m)

SRCS = $(wildcard *.c)

PROGS = $(patsubst %.c,%_nativ,$(SRCS))

ifeq ($(arch), x86_64)
	CFLAGS_COMPAT := -m32
	COMPAT_MODE := 1
	CC_COMPAT := $(CC)
else ifeq ($(arch), aarch64)
	COMPAT_MODE := 1
	CC_COMPAT := arm-linux-gnueabihf-gcc
else ifeq ($(arch), ppc64)
	COMPAT_MODE := 1
	CC_COMPAT := powerpc-linux-gnu-gcc
endif

ifeq ($(COMPAT_MODE),1)
	PROGS_COMPAT := $(patsubst %.c,%_compat,$(SRCS))
else
	PROGS_COMPAT :=
endif


all: $(PROGS) $(PROGS_COMPAT)

%_nativ: %.c
	$(CC) $(CFLAGS)  -o $@ $<

%_compat: %.c
	$(CC_COMPAT) $(CFLAGS) $(CFLAGS_COMPAT)  -o $@ $<
clean:
	rm -rf $(PROGS) $(PROGS_COMPAT)
	rm -rf *.txt
