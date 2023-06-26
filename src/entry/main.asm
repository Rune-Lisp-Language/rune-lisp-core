.section .text

    .global _start
    .global _exit
    .global _exit_error

    _start:
	call print_title
	call arg_handler
	call print_parameters
	call parser

    _exit:
	mov sys_exit, %rax
	mov return_normal, %rdi
	syscall

    _exit_error:
	mov sys_write, %rax
	mov stdout, %rdi
	syscall

	mov sys_exit, %rax
	mov return_error, %rdi
	syscall
