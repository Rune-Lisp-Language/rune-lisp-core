.section .rodata

    sys_read:         .quad 0
    sys_write:        .quad 1
    sys_open:         .quad 2
    sys_close:        .quad 3
    sys_exit:         .quad 60

    stdin:            .quad 0
    stdout:           .quad 1
    stderr:           .quad 2

    read_mode:        .quad 0
    write_mode:       .quad 1
    read_write_mode:  .quad 2

    return_normal:    .quad 0
    return_error:     .quad 1


.section .text

    .global sys_read
    .global sys_write
    .global sys_open
    .global sys_close
    .global sys_exit

    .global stdin
    .global stdout
    .global stderr

    .global read_mode
    .global write_mode
    .global read_write_mode

    .global return_normal
    .global return_error
