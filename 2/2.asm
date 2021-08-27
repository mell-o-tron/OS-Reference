mov ah, 0x0e
mov al, 65
int 0x10

loop:
    inc al
    cmp al, 'Z' + 1
    je exit
    int 0x10
    jmp loop
exit:
    jmp $
    
times 510-($-$$) db 0
db 0x055, 0x0aa
