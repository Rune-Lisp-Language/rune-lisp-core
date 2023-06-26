.section .rodata

    title:
	.ascii " \n"
	.ascii " ╔════════════════════════════════╗\n"
	.ascii " ║                                ║\n"
	.ascii " ║       Rune Lisp compiler       ║\n"
	.ascii " ║       version: 0.0.1           ║\n"
	.ascii " ║                                ║\n"
	.ascii " ╚════════════════════════════════╝\n"
	.ascii " \n"
	len_title = . - title

    prefix_src_path:
	.ascii "    ■ source: "
	len_prefix_src_path = . - prefix_src_path

    prefix_out_path:
	.ascii "    ■ output: "
	len_prefix_out_path = . - prefix_out_path

    new_line:
	.ascii "\n"


.section .text

    .global print_title
    .global print_parameters
    .global print_new_line

    print_title:
	mov sys_write, %rax
	mov stdout, %rdi

	mov $title, %rsi
	mov $len_title, %rdx

	syscall
	ret

    print_parameters:
	mov sys_write, %rax
	mov stdout, %rdi
	mov $prefix_src_path, %rsi
	mov $len_prefix_src_path, %rdx
	syscall

	mov sys_write, %rax
	mov stdout, %rdi
	mov $src_path, %rsi
	mov len_src_path, %rdx
	syscall

	call print_new_line

	mov sys_write, %rax
	mov stdout, %rdi
	mov $prefix_out_path, %rsi
	mov $len_prefix_out_path, %rdx
	syscall

	mov sys_write, %rax
	mov stdout, %rdi
	mov $out_path, %rsi
	mov len_out_path, %rdx
	syscall

	call print_new_line
	call print_new_line

	ret

    print_new_line:
	mov sys_write, %rax
	mov stdout, %rdi

	mov $new_line, %rsi
	mov $1, %rdx

	syscall
	ret
