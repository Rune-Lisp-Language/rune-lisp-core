.section .text

    .global len

    len:
	mov $0x00, %al
	mov $255, %rcx

	cld
	repne scasb

	mov $255, %rdx
	sub %rcx, %rdx

	cmp $0, %rsi
	jz return
	jmp write

    write:
	mov %rdx, (%rsi)
	ret

    return:
	mov %rdx, %rax
	ret
