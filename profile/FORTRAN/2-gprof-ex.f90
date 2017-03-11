program test

  implicit none

! Test gprof
! Disable inline to understand profiler
! export GMON_OUT_PREFIX=gmon.out    --> pid on gmon.out --> profile MPI codes
! 1 -
! ifort test_gprof2.f90 -fno-inline-functions -O3 -pg   
! ./a.out
! gprof a.out gmon.<pid>
!    --> create code profile 
! 2 -
! ifort test_gprof2.f90 -fno-inline-functions -O3 -pg -g
! ./a.out
! gprof -l a.out gmon.<pid>
!    --> create code profile at line level
  
  real, allocatable :: a(:,:), b(:,:), c(:,:)
  real alpha 
  integer i, j, dim, niter, t

  dim = 5000
  niter = 2
  alpha = sqrt(1.)

  allocate(a(dim, dim))
  allocate(b(dim, dim))
  allocate(c(dim, dim))
  
  a = 0.
  b = 1.
  c = 2.

!!!!!!!!!!!!!!!!!!!!!!!!! GOOD START !!!!!!!!!!!!!!!!!!!!!!!
  write(*,*) "good start"

  do t=1, niter

     do j=1, dim
        do i=1, dim
           call good_assign(i, j, dim, a, b, c, alpha)
        enddo
     enddo
     
  enddo

  write(*,*) "good end"
!!!!!!!!!!!!!!!!!!!!!!!!! GOOD END !!!!!!!!!!!!!!!!!!!!!!!

  if(alpha < -1) write(*,*) a, b, c

  a = 0.
  b = 1.
  c = 2.

!!!!!!!!!!!!!!!!!!!!!!!!! BAD START !!!!!!!!!!!!!!!!!!!!!!!
  write(*,*) "bad start"

  do t=1, niter

     do j=1, dim
        do i=1, dim
           call bad_assign(i, j, dim, a, b, c, alpha)
        enddo
     enddo
     
  enddo

  write(*,*) "bad end"
!!!!!!!!!!!!!!!!!!!!!!!!! BAD END !!!!!!!!!!!!!!!!!!!!!!!

  deallocate(a)
  deallocate(b)
  deallocate(c)

end program
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine good_assign(i1, i2, dim, a, b, c, alpha)

  implicit none 

  integer i1, i2, dim
  real a(dim, dim), b(dim, dim), c(dim, dim)
  real alpha
  
  a(i1,i2) = a(i1,i2) + b(i1,i2) + c(i1,i2) + alpha

end subroutine 
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine bad_assign(i1, i2, dim, a, b, c, alpha)

  implicit none 

  integer i1, i2, dim
  real a(dim, dim), b(dim, dim), c(dim, dim)
  real alpha


  a(i2,i1) = a(i2,i1) + b(i2,i1) + c(i2,i1) + alpha

end subroutine 
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
