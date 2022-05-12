%.o: %.s
	nasm -g -O1 -f elf -o $@ $<

%.o: %.c
	gcc -m32 -g -nostdlib -fno-stack-protector -c -o $@ $<

all: lwca

lwca: lwc.o start.o strlen.o utoa_s.o atou_s.o
	ld -melf_i386 -o $@ $^
	rm -f lwc.o start.o strlen.o utoa_s.o atou_s.o

clean:
	rm -f *.o lwca
