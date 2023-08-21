#!/bin/bash

#George Carvellas

aarch64-linux-gnu-as $1.s -o $1.o
aarch64-linux-gnu-ld $1.o -lc
qemu-aarch64 -L /usr/aarch64-linux-gnu/ a.out
rm a.out
rm $1.o
