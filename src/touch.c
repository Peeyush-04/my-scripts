#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

// ANSI version (easy to understand)
#define RED   "\x1b[31m"
#define GREEN "\x1b[32m"
#define WHITE "\x1b[0m"

int main(int argc, char *argv[]) {
  // creating files
  printf(WHITE "\n=> " GREEN "Executing...\n" WHITE);
  for(int i = 1; i < argc; i++) {
    int fd = open(argv[i], O_CREAT | O_WRONLY, 0644);
    
    // file descriptor error
    if(fd == -1) {
      printf(RED "Error creating:" WHITE " %s\n", argv[i]);
      continue; // forward
    }

    close(fd);
    printf(WHITE "=> " GREEN "Created:" WHITE " %s\n", argv[i]);
  }
  printf("\n");

  printf("Program Executed successfully!\n");
  return 0; // no issues
}