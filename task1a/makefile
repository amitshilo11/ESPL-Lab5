%.o: %.asm
	nasm -g -O1 -f elf -o $@ $<

%.o: %.c
	gcc -m32 -g -nostdlib -fno-stack-protector -c -o $@ $<

all: lwca

lwca: lwc.o start.o strlen.o
	ld -melf_i386 -o $@ $^
	rm -f lwc.o start.o strlen.o

clean:
	rm -f *.o lwca
