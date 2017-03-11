! 
! This source code was implemented as example for a debugging session of the 
! Workshop on Advanced Techniques for Scientific Programming and Management of Open Source Software Packages. 
! The code impements an inefficient version of a matrix multiplication such as C = A! AT.
! Where A, AT and C are square matrix of dimension SIZE x SIZE.
! A is the input matrix while C is te output matrix. With in the function mat_Tmat_mul a temporary AT matrix is defined.
! The program contains an infite loop calling the function mat_Tmat_mul
! Run the program compiling the proposed version on your workstation as reported:
!
!     1) gfortran source1.f90 -O3 -g; ./a.out
!
! Open an other shell and check the memory consumption. 
! Run the debug using valgrind (possibly at reduced SIZE). 
! Please, use the valgrind on-line manual or publicly available documentation on web for details on valgrind sintax.
!
! 


PROGRAM DEBUG

  IMPLICIT NONE

  INTEGER, PARAMETER :: SIZE = 500

  INTEGER :: i, j
  REAL*8, ALLOCATABLE, DIMENSION ( :, : ) :: A, C

  ALLOCATE ( A( SIZE, SIZE ) )
  ALLOCATE ( C( SIZE, SIZE ) )

  DO j = 1, SIZE 
     DO i = 1, SIZE 
        A( i, j ) = REAL(i) / j
     END DO
  END DO

  C = 0.0
  
  DO WHILE(1.eq.1)
     CALL mat_Tmat_mul( A, C )
  END DO

  DEALLOCATE( A );
  DEALLOCATE( C );

  STOP

CONTAINS

  SUBROUTINE mat_Tmat_mul( A , C )

    IMPLICIT NONE
    
    INTEGER :: i, j, k
    REAL*8, ALLOCATABLE, DIMENSION ( :, : ) :: A, C
    REAL*8, ALLOCATABLE, DIMENSION ( :, : ) :: temp
    
    ALLOCATE( temp( SIZE, SIZE ) )
    
    DO i = 1, SIZE 
       DO j = 1, SIZE 
          temp( j, i ) = A( i, j )
       END DO
    END DO
    
    DO i = 1, SIZE 
       DO j = 1, SIZE 
          DO k = 1, SIZE 
             C( i, j ) = C( i, j ) + A( i, k ) * temp( k, j )
          END DO
       END DO
    END DO
    
  END SUBROUTINE mat_Tmat_mul
  
END PROGRAM DEBUG
  
