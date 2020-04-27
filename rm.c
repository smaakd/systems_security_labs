#include <stdio.h>
#include <stdlib.h>

void main() {
   char *name[3];

   name[0] = "/bin/rm";
   name[1] = "/home/httpd/grades.txt";
   name[2] = NULL;
   execve(name[0], name, NULL);
   exit(0);
}
