#include <stdlib.h>
#include <stdio.h>
#ifdef TRAPFPE
#include "fpe_x87_sse/fpe_x87_sse.h"
#endif

int main(int argc, char *argv[])
{
  float a, b, c, tmp;

#ifdef TRAPFPE
  set_fpe_x87_sse();
#endif

  printf("Division and comparison\n");
  printf("Insert a\n");
  scanf("%f",&a);
  printf("Insert b\n");
  scanf("%f",&b);

  printf("Calculating a/b...");
  tmp = a / b;
  printf("Done!\n");
  
  printf("Comparing with 2...");

  if (tmp > 2.) {
    c = +1.;
  } else {
    c = -1.;
  }

  printf("Done!");
  printf("c = %f \n", c);
  
  return(EXIT_SUCCESS);
}
