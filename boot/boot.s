[org 0x7c00]
BITS 16

start:
    mov ax, 0x07C0
    mov ds, ax
    mov es, ax

    cli
    mov ax, 0x0000
    mov ss, ax
    mov sp, 0x7C00
    sti

    call load_kernel

    jmp $

load_kernel:
    mov si, welcome_msg
    call print_string
    ret

print_string:
    mov ah, 0x0E
.loop:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .loop
.done:
    ret

welcome_msg db 'Welcome to MyOS! Bootloader running...', 0

times 510-($-$$) db 0
dw 0xAA55
