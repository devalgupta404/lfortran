program test
  use iso_c_binding
  integer, pointer :: fptr
  logical :: res

  res = c_associated(fptr)
end program