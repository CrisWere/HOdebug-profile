program test

  implicit none

! Show how mixing different type (e.g. integer - float) could
! affect performance
! bad - integer - real
! good - all real
! ifort test_gprof3.f90 -O3      --> best performance of good version
! ifort test_gprof3.f90 -O3 -xW  --> performance are the same in vector version


  real, allocatable :: a(:,:), b(:,:), c(:,:)
  real alpha 
  integer i, j, dim, niter, t
  integer itmp1, itmp2
  real rtmp1, rtmp2
  real ri, rj
  integer t1, t2, tr

  dim = 5000
  niter = 100
  alpha = sqrt(1.)

  allocate(a(dim, dim))
  allocate(b(dim, dim))
  allocate(c(dim, dim))

  a = 0.
  b = 1.
  c = 2.
!!!!!!!!!!!!!!!!!!!!!!!!! BAD START !!!!!!!!!!!!!!!!!!!!!!!
  write(*,*) "bad start"

  call system_clock(t1, tr)

  do t=1, niter

     do j=1, dim
        do i=1, dim
           itmp1 = 2 * i
           itmp2 = 3 * i + j
           a(i,j) = (a(i,j) + itmp1) + itmp2
        enddo
     enddo

  enddo

  call system_clock(t2)

  write(*,*) "bad end - time ", real(t2-t1)/real(tr)
!!!!!!!!!!!!!!!!!!!!!!!!! BAD END !!!!!!!!!!!!!!!!!!!!!!!

  a = 0.
  b = 1.
  c = 2.

!!!!!!!!!!!!!!!!!!!!!!!!! GOOD START !!!!!!!!!!!!!!!!!!!!!!!
  write(*,*) "good start"

  call system_clock(t1, tr)

  do t=1, niter

     rj = 0.

     do j=1, dim

        rj = rj + 1.                    ! rj = real(j)
        ri = 0.

        do i=1, dim
           ri = ri + 1.                 ! ri = real(i)
           rtmp1 = 2. * ri              ! rtmp1 = real(2*i)
           rtmp2 = 3. * ri + rj         ! rtmp2 = real(3*i+j)
           a(i,j) = (a(i,j) + rtmp1) + rtmp2
        enddo
     enddo

  enddo

  call system_clock(t2)

  write(*,*) "good end - time ", real(t2-t1)/real(tr)
!!!!!!!!!!!!!!!!!!!!!!!!! GOOD END !!!!!!!!!!!!!!!!!!!!!!!
  if(alpha < -1) write(*,*) a, b, c

  deallocate(a)
  deallocate(b)
  deallocate(c)

end program test
