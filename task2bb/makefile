%.o: %.s
	nasm -g -O1 -f elf -o $@ $<

%.o: %.c
	gcc -m32 -g -nostdlib -fno-stack-protector -c -o $@ $<

all: lwca

lwca: start.o atou_s.o strlen.o wsflag.o cmpstr.o
	ld  -melf_i386 -o $@ $^
	rm -f lwc.o start.o atou_s.o strlen.o wsflag.o cmpstr.o


clean:
	rm -f *.o lwca
