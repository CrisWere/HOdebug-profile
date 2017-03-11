program test_oob

! Provarlo con ifort e gfortran mettendo ulimit -v 1000000

  implicit none

  real a(10)
  integer i
  integer last
  integer dim
  real, allocatable :: myvett(:)


  dim = 10000000
  write(*,*) "Insert last "
  read(*,*) last

  do i=1, last
     allocate(myvett(dim))

     call set_val(a(1), dim, myvett);
  enddo

  write(*,*) "--> ", a(1)

end program



subroutine set_val(in, dim, myvett)

  implicit none

  real in
  integer dim
  real myvett(dim)
  integer i


  do i=1, dim
     myvett(i) = 7;
  enddo

  in = myvett(dim)

end subroutine
