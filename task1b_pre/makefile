all: exe

asm-libs: utoa_s.s atou_s.s strlen.s
	nasm -f elf32 utoa_s.s -o utoa_s.o
	nasm -f elf32 atou_s.s -o atou_s.o
	nasm -f elf32 strlen.s -o strlen.o

c-libs: main.c
	gcc -g -m32 -c main.c -o main.o

exe: asm-libs c-libs
	gcc -g -m32 -o start main.o utoa_s.o atou_s.o strlen.o
	rm -f main.o utoa_s.o atou_s.o strlen.o
	
clean:
	rm -f *.o start