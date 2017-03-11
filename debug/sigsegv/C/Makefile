.PHONY: default help all small big clean
CC = gcc 
CFLAGS = -g -O0

LD = $(CC)

SOURCE_C = $(wildcard *.c)
EXECUTABLES = small.e big.e

default: all

help:
	@echo "\
Options:\n\n\
  make all:           make every executable (default)\n\
  make small:         compile the small matrix version\n\
  make big:           compile the big matrix version\n\
  make clean:         delete output files\n\
  make help:          display this help"


all: small big

small: small.e

big: big.e

clean:
	rm -rfv $(EXECUTABLES)

small.e: $(SOURCE_C)
	$(CC) $(CFLAGS) -D__SMALL $^ -o $@

big.e: $(SOURCE_C)
	$(CC) $(CFLAGS) $^ -o $@
