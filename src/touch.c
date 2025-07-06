#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include "../include/ansi_color.h"

int main(int argc, char *argv[]) {
  // creating files
  printf(WHITE "\n=> " BOLD_GREEN "Executing...\n" WHITE);
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

  printf(BOLD_WHITE "Program Executed successfully!\n" WHITE);
  return 0; // no issues
}