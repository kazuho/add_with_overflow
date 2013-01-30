#include <stdio.h>
#include <stdlib.h>
#include "add_with_overflow.hpp"

int main(int argc, char** argv)
{
  int x, y, ret;
  if (argc != 3
      || sscanf(argv[1], "%d", &x) != 1
      || sscanf(argv[2], "%d", &y) != 1) {
    fprintf(stderr, "usage: $0 <x> <y>\n");
    exit(1);
  }
  if (! add_with_overflow(&ret, x, y)) {
    printf("result: %d\n", ret);
  } else {
    printf("overflow\n");
  }
  return 0;
}
