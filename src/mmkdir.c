#include <stdio.h>
#include <direct.h>
#include <string.h>
#include <io.h>
#include <errno.h>
#include "../include/ansi_color.h"

int main(int argc, char *argv[]) {
  /* 
    for loop for number of directories
    create directories
    error handling
  */

  if(argc < 2) {
    printf("\nFolders not passed.\n");
    fprintf(stderr, RED "Usage: mkdir <folder1>...\n" WHITE);
    return 1;
  }

  printf("=> " BOLD_GREEN "Executing...\n" WHITE);

  for(int i = 1; i < argc; i++) {
    char *folder = argv[i];
    
    if(_access(folder, 0) == 0) {
      printf("=> " YELLOW "Folder already exists:" WHITE " %s\n", folder);
      continue;
    }

    if(_mkdir(folder) == -1) {
      fprintf(stderr, "=> " RED "Failed to create" WHITE " %s: %s\n", folder, strerror(errno));
      continue;
    }

    printf("=> " GREEN "Created:" WHITE " %s\n", folder);
  }
  printf("\n");

  printf(BOLD_WHITE "Program Executed successfully!\n" WHITE);
  return 0;
}