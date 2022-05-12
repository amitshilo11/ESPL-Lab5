all: exe

asm-libs: open.s close.s utoa_s.s atou_s.s
	nasm -f elf32 open.s -o open.o
	nasm -f elf32 close.s -o close.o
	nasm -f elf32 utoa_s.s -o utoa_s.o
	nasm -f elf32 atou_s.s -o atou_s.o

c-libs: main.c
	gcc -g -m32 -c main.c -o main.o

exe: asm-libs c-libs
	gcc -g -m32 -o start main.o open.o close.o utoa_s.o atou_s.o
	rm -f main.o open.o close.o utoa_s.o atou_s.o
	
clean:
	rm -f *.o task0