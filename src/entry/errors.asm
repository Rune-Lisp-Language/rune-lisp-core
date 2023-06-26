.section .rodata

    msg_err_args:
	.ascii " [ Error ]: Invalid or missing parameters\n"
	.ascii "            Use:"
	.ascii " runec-core --src 'path/to/source'"
	.ascii " --out 'path/to/executable'\n"
	len_msg_err_args = . - msg_err_args

    msg_err_key_src:
	.ascii " [ Error ]: Missing '--src' parameter\n"
        len_msg_err_key_src = . - msg_err_key_src

    msg_err_key_out:
	.ascii " [ Error ]: Missing '--out' parameter\n"
        len_msg_err_key_out = . - msg_err_key_out

    msg_err_val_src:
	.ascii " [ Error ]: Invalid '--src' value\n"
        len_msg_err_val_src = . - msg_err_val_src

    msg_err_val_out:
	.ascii " [ Error ]: Invalid '--out' value\n"
        len_msg_err_val_out = . - msg_err_val_out


.section .text

    .global err_args

    .global err_key_src
    .global err_key_out
    .global err_val_src
    .global err_val_out

    err_args:
	mov $msg_err_args, %rsi
	mov $len_msg_err_args, %rdx

	call _exit_error

    err_key_src:
	mov $msg_err_key_src, %rsi
	mov $len_msg_err_key_src, %rdx

	call _exit_error

    err_key_out:
	mov $msg_err_key_out, %rsi
	mov $len_msg_err_key_out, %rdx

	call _exit_error

    err_val_src:
	mov $msg_err_val_src, %rsi
	mov $len_msg_err_val_src, %rdx

	call _exit_error

    err_val_out:
	mov $msg_err_val_out, %rsi
	mov $len_msg_err_val_out, %rdx

	call _exit_error
