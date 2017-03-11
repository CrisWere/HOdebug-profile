program test_oob

  implicit none

  real a(10), b(10)
  COMMON /mycomm/ a, b
  integer i
  integer last


  write(*,*) "Insert last "
  read(*,*) last

  do i=1, 10
     call set_val(b(i), 200.);
  enddo

  do i=1, last
     call set_val(a(i), 100.);
  enddo

  write(*,*) "--> ", a(1), b(1)

end program



subroutine set_val(in, out)

  implicit none

  real in, out

  in = out

end subroutine
