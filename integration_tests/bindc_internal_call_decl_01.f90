program bindc_internal_call_decl_01
    use, intrinsic :: iso_c_binding, only: c_char, c_int, c_null_char
    implicit none

    interface
        integer(c_int) function c_chdir(path) bind(C, name="chdir")
            import :: c_int, c_char
            character(kind=c_char), intent(in) :: path(*)
        end function c_chdir
    end interface

    call set_cwd("/tmp")

contains

    subroutine set_cwd(path)
        character(len=*), intent(in) :: path
        integer(c_int) :: code

        code = c_chdir(to_c_char(trim(path)))
        if (code /= 0) error stop "chdir failed"
    end subroutine set_cwd

    function to_c_char(value) result(cstr)
        character(len=*), intent(in) :: value
        character(kind=c_char) :: cstr(len(value) + 1)
        integer :: i, lv

        lv = len(value)
        do i = 1, lv
            cstr(i) = value(i:i)
        end do
        cstr(lv + 1) = c_null_char
    end function to_c_char

end program bindc_internal_call_decl_01