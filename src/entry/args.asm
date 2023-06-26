.section .data

    src_path:
	.space 255, 0

    len_src_path:
	.quad 0

    out_path:
	.space 255, 0

    len_out_path:
	.quad 0


.section .rodata

    key_src:
	.byte 0x2D
	.byte 0x2D
	.byte 0x73
	.byte 0x72
	.byte 0x63

    key_out:
	.byte 0x2D
	.byte 0x2D
	.byte 0x6F
	.byte 0x75
	.byte 0x74

    len_key = . - key_out


.section .text

    .global arg_handler

    .global src_path
    .global len_src_path

    .global out_path
    .global len_out_path

    arg_handler:
	pop %rbp

	call check_args_number
	add $16, %rsp

	call check_arg_keys
	add $8, %rsp

	call save_parameters
	add $24, %rsp

	push %rbp
	ret

    check_args_number:
	cmpb $5, 8(%rsp)
	jnz err_args

	ret

    check_arg_keys:
	mov 8(%rsp), %rdi
	mov $key_src, %rsi
	mov $len_key, %rcx

	cld
	repe cmpsb
	jnz err_key_src

	mov 24(%rsp), %rdi
	mov $key_out, %rsi
	mov $len_key, %rcx

	cld
	repe cmpsb
	jnz err_key_out

	ret

    save_parameters:
	mov 8(%rsp), %rdi
	mov $len_src_path, %rsi
	call len

	mov 8(%rsp), %rsi
	mov $src_path, %rdi
	mov len_src_path, %rcx

	cld
	repe movsb

	mov 24(%rsp), %rdi
	mov $len_out_path, %rsi
	call len

	mov 24(%rsp), %rsi
	mov $out_path, %rdi
	mov len_out_path, %rcx

	cld
	repe movsb

	ret
