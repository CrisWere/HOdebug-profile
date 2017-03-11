#Cristina Werenitzky - Respuestas

## Varios bugs

En la carpeta `bugs/` hay varios bugs ya hechos y resueltos, pensado
para hacerlo en clase. Aquí tenemos un `Makefile` donde, además,
usamos una nueva variable: `$CFLAGS`. En esa variable pueden poner los
distintos flags de compilación que quieran pasarle a `$CC`. Esta
carpeta ya tiene un `Makefile` hecho, que compila todos los
casos. Algunas cosas que pueden hacer es:

- Correr el programa con un debugger, sin agregar flags de
debug. ¿Tienen toda la información que requerían?

```
    ERRORES ENCONTRADOS:
	add_array_segfault: no se realiza reserva de memoria para los arreglos a y b
	add_array_dynamic y add_array_static: la iteración dentro de la fcion add_array excede 
					      el limite de memoria asignado para el arreglo

    Comandos:	
	gcc add_array_segfault.c  -o add_array_segfault.e 	#Creo el ejecutable sin info de compilacion
	./add_array_segfault.e 		 			#Ejecuto el archivo creado
		Segmentation fault (core dumped)
	
	gdb ./add_array_segfault.e
	gdb run
                Program received signal SIGSEGV, Segmentation fault.
		0x00000000004005f2 in main ()                           
	
	El mensaje indica que existe un error en la fcion main. NO en que instrucción se produce
```

- ¿Qué pasa si ponen el flag de debug? ¿Qué flag de optimización es el
mejor para debuggear?
```
    Comandos:	
	gcc -g add_array_segfault.c  -o add_array_segfault.e 	#Creo el ejecutable CON info de compilacion (flag -g)
	gdb ./add_array_segfault.e
	gdb run
		Program received signal SIGSEGV, Segmentation fault.
		0x00000000004005f2 in main (argc=1, argv=0x7fffffffde68)
		    at add_array_segfault.c:19
		19	    b[i] = i;

	Después de agregar el flag -g para que agregue info de compilacion, la información de debug indica 
	la instrucción dentro de la función que produce el error. En este caso indica que existe un error 
	en la fcion main, en la instrucción nro 19.

        Para debuggear el mejor flag de optimización es -o0 para que no realice ningún tipo de optimizacion


	
    En este caso, la información de debug indica la instrucción dentro de la función que produce el error.

```

- Agreguen algún flag para que informe todos los warnings en la
compilación, como `-Wall`. ¿Alguno les da alguna pista de por qué el
programa se rompe?

```
    Comandos:	
	gcc -g -Wall add_array_segfault.c  -o add_array_segfault.e 	#Creo el ejecutable CON info de compilacion y con todos los warnings

	En todos los ejemplos (static, dymanic y segfault) no detecta ningún warning	
```


## Floating point exception

En la carpeta `fpe/` hay tres códigos de C, independientes, para
compilar.  Cada uno de estos códigos genera un ejecutable. Hay además
una carpeta que define la función `set_fpe_x87_sse_`. Una vez
compilados los tres ejecutables sin la opción `-DTRAPFPE`, responder
las siguientes preguntas:

- ¿Qué función requiere agregar `-DTRAPFPE`? ¿Cómo pueden hacer que el
programa *linkee* adecuadamente?
- Para cada uno de los ejecutables, ¿qué hace agregar la opción
`-DTRAPFPE` al compilar? ¿En qué se diferencian los mensajes de salida
de los programas con y sin esa opción cuando tratan de hacer una
operación matemática prohbida, como dividir por 0 o calcular la raíz
cuadrada de un número negativo?

Nota: Si agregan `-DTRAPFPE`, el programa va a tratar de incluir, en
la compilación, un archivo `.h` que está en la carpeta
`fpe_x87_sse`. Para pedirle al compilador que busque archivos `.h` en
una carpeta, usen el flag `-Icarpeta` (sí, sin espacio en el medio).

Otra nota: Para poder linkear `fpe_x87_sse.c` tienen que agregar la
librería matemática `libm`, con `-lm`.


```

```

## Segmentation Fault

En la carpeta `sigsegv/` hay códigos de C y de FORTRAN con su
`Makefile`.  Compilen y corran `small.e` y `big.e`.  Identifiquen los
errores que devuelven (¡si devuelven alguno!) los ejecutables.  Ahora
ejecuten `ulimit -s unlimited` en la terminal y vuelvan a
correrlo. Luego responder las siguientes preguntas:

- ¿Devuelven el mismo error que antes?
```
    ERROR:  La reserva de l matriz auxiliar float temp[SIZE][SIZE] supera el tamaño por defecto 
	    que se le asigna en el stack a la ejecución 

    SIN ulimit
	Comandos:
	  make all
	           gcc  -g -O0 -D__SMALL matmult.c -o small.e
	  	   gcc  -g -O0 matmult.c -o big.e

	 ./small.e
		   No da error
  	 ./big.e
		   Segmentation fault (core dumped)

    CON ulimit 
	Comandos:
		ulimit -s unlimited
	 
	 ./small.e
		   No da error
  	 ./big.e
	           No da error porque no limito el tamaño del stack que puede utilizar el programa. 


     SOLUCION:
         Declarar dinámicamente la matriz temp
		float *temp;
  		temp = (float *) malloc(SIZE * SIZE * sizeof(float));
```	
		   
- Averigüen qué hicieron al ejecutar la sentencia `ulimit -s
unlimited`. Algunas pistas son: abran otra terminal distinta y fíjense
si vuelve al mismo error, fíjense la diferencia entre `ulimit -a`
antes y después de ejecutar `ulimit -s unlimited`, googleen, etcétera.

```
     Comando:
	ulimit -a
		core file size          (blocks, -c) 0
		data seg size           (kbytes, -d) unlimited
		scheduling priority             (-e) 0
		file size               (blocks, -f) unlimited
		pending signals                 (-i) 15841
		max locked memory       (kbytes, -l) 64
		max memory size         (kbytes, -m) unlimited
		open files                      (-n) 1024
		pipe size            (512 bytes, -p) 8
		POSIX message queues     (bytes, -q) 819200
		real-time priority              (-r) 0
		stack size              (kbytes, -s) 8192
		cpu time               (seconds, -t) unlimited
		max user processes              (-u) 15841
		virtual memory          (kbytes, -v) unlimited
		file locks                      (-x) unlimited

	ulimit -s unlimited
	ulimit -a

		core file size          (blocks, -c) 0
		data seg size           (kbytes, -d) unlimited
		scheduling priority             (-e) 0
		file size               (blocks, -f) unlimited
		pending signals                 (-i) 15841
		max locked memory       (kbytes, -l) 64
		max memory size         (kbytes, -m) unlimited
		open files                      (-n) 1024
		pipe size            (512 bytes, -p) 8
		POSIX message queues     (bytes, -q) 819200
		real-time priority              (-r) 0
		stack size              (kbytes, -s) unlimited
		cpu time               (seconds, -t) unlimited
		max user processes              (-u) 15841
		virtual memory          (kbytes, -v) unlimited
		file locks                      (-x) unlimited
	
	ulimit -s unlimited deja ilimitado la asignación de memoria en el stack
```

- La "solución" anterior, ¿es una solución en el sentido de debugging?

```	
	No sería una solución ya que obligo a que el usuario se encargue de "liberar" la memoria asignada al stack 
 	cada vez quiera utilizar la función
```

- ¿Cómo harían una solución más robusta que la anterior, que no
requiera tocar los `ulimits`?

```
	Una solución sería cambiar la forma de declarar la variable temp, en lugar de hacer una asignación estática,
	realizo una reserva dinámica.
```

## Valgrind

En la carpeta `valgrind/` hay ejemplos en C y FORTRAN que se pueden
ejecutar con valgrind. Describan el error y por qué sucede

```
	ERROR:  El error se produce porque se reserva dinámicamente memoria para la matriz temp dentro de la fcion mat_Tmat_mul
		y NO se libera el puntero con free al terminar la ejecución

	Comandos:
		htop  #Ejecuto este comando (o top) en una terminal para ver el estado de la memoria
		gcc source1.c -O3 -g; ./a.out     #Compilo y ejecuto el archivo source1.c
 
		OBS:    Lazo infinito for(;;). 
  			El consumo de memoria crece con cada invocación a la fcion mat_Tmat_mul. 
			La función no libera memoria reservada dinámicamente

	    Uso de valgrind
		//source1.c
		...
		#define SIZE 100
		...
		int main( int argc, char * argv[] ){
			...
			for(i=0;i < 5; i++) mat_Tmat_mul( A, C );
			...
		}

	      Ejecuto:
		valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all ./a.out

	      Informe de valgrind:	
		==3705== HEAP SUMMARY:
		==3705==     in use at exit: 200,000 bytes in 5 blocks
		==3705==   total heap usage: 7 allocs, 2 frees, 280,000 bytes allocated
		==3705== 
		==3705== 200,000 bytes in 5 blocks are definitely lost in loss record 1 of 1
		==3705==    at 0x4C2AB80: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
		==3705==    by 0x4007E5: mat_Tmat_mul (source1.c:30)
		==3705==    by 0x40068C: main (source1.c:59)
		==3705== 
		==3705== LEAK SUMMARY:
		==3705==    definitely lost: 200,000 bytes in 5 blocks
		==3705==    indirectly lost: 0 bytes in 0 blocks
		==3705==      possibly lost: 0 bytes in 0 blocks
		==3705==    still reachable: 0 bytes in 0 blocks
		==3705==         suppressed: 0 bytes in 0 blocks
		==3705== 
		==3705== For counts of detected and suppressed errors, rerun with: -v
		==3705== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 0 from 0)
```

## Funny

En la carpeta `funny/` hay un código de C. Describan las diferencias
de los ejecutables al compilar con y sin el flag `-DDEBUG`. ¿De dónde
vienen esas diferencias?
```
	ERROR: 	Se produce el error debido a que el valor de  i + 1000 excede los límites del arreglo a[]

	Comandos:
	   Compilo sin flag
		gcc -g test_oob2.c -o test_oob2.e
		./test_oob2.e
			Segmentation fault (core dumped)

	   Compilo CON flag
		gcc -g -DDEBUG test_oob2.c -o test_oob2.e
		./test_oob2.e
			I'm HERE !!!! 
			Segmentation fault (core dumped)

		gdb ./test_oob2.e
			Program received signal SIGSEGV, Segmentation fault.
			0x0000000000400665 in main (argc=1, argv=0x7fffffffde78) at test_oob2.c:29
			29	      a[i+1000] = a[i];

	La diferencia está en el que el flag DDEBUG define un mensaje y lo escribe. 
	Se produce el error debido a que el valor de  i + 1000 excede los límites del arreglo a[]
```
