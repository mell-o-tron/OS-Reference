[org 0x7c00] 
mov [BOOT_DISK], dl                 

; setting up the stack

xor ax, ax                          
mov es, ax
mov ds, ax
mov bp, 0x8000
mov sp, bp

mov bx, 0x7e00

; reading the disk

mov ah, 2
mov al, 1
mov ch, 0
mov dh, 0
mov cl, 2
mov dl, [BOOT_DISK]
int 0x13

; printing what is in the next sector

mov ah, 0x0e
mov al, [0x7e00]
int 0x10
jmp $
BOOT_DISK: db 0

; magic padding

times 510-($-$$) db 0              
dw 0xaa55

; filling the second sector ( the one that will be readed ) with 'A's

times 512 db 'A'
