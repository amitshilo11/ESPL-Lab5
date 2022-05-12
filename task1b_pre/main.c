#include <stdio.h>
#include <stdlib.h>

extern char* utoa_s(unsigned int number, char* buf);
extern int atou_s(char *str);
char *utoa(int);

char *buffer;

int main(int argc, char **argv) {

	unsigned int num = (unsigned int)12345;
	fprintf(stderr, "%s%d\n", "num is: ", num);

/*
	char* num_s = "1234";
	fprintf(stderr, "%s%s\n", "num_s is: ", num_s);

	int num_new = atou_s(num_s);
	fprintf(stderr, "%s%d\n", "num_new is: ", num_new);
*/



  	char* str = utoa(num);
  	fprintf(stderr, "%s%s\n", "AFTER utoa: ", str);

	unsigned int s_to_num = 0;
	s_to_num = atou_s(str);
	fprintf(stderr, "%s%d\n", "AFTER atou_s: ", s_to_num);

	return 0;
}

#define UTOA_BUFLEN 10
char *utoa(int num) {
	static char buf[UTOA_BUFLEN], *p_str;

	p_str = buf;
	utoa_s(num, p_str);
	return buf;
}