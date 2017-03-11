#include <stdlib.h>
#include <stdio.h>
#ifdef TRAPFPE
#include "fpe_x87_sse/fpe_x87_sse.h"
#include <fenv.h>
#pragma STDC FENV_ACCESS on
#endif

int set_fpe_x87_sse(void)
{
  int retcode;
  
  retcode = feenableexcept(FE_OVERFLOW|FE_DIVBYZERO|FE_INVALID);

  return(retcode);
}

int main(int argc, char *argv[])
{
  float a, b, c;

#ifdef TRAPFPE
  set_fpe_x87_sse();
#endif

  printf("Division\n");
  printf("Insert a\n");
  scanf("%f",&a);
  printf("Insert b\n");
  scanf("%f",&b);

  printf("Calculating a/b...");
  c = a / b;
  printf("Done!\n");

  printf("c = a/b = %f\n", c);
  return(EXIT_SUCCESS);
}
