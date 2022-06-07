data segment 
    msg db "Nhap: $"
    msg2 db 10,13,"String: $"  
    str db 255,0,255 dup('$') 
    str2 db 255 dup('$')
ends

code segment
start:
    mov ax, data
    mov ds, ax

    mov ah, 09h
    lea dx, msg
    int 21h
    
    mov ah, 0Ah
    lea dx, str
    int 21h
    
    lea di, str2
    lea si, str
    add si, 2
@rev:    
    mov al, [si]
    cmp al, 0Dh  ; Enter
    je @display
    cmp al, 'Z'
    ja  @thuong2hoa
    add al, 20h
    mov [di], al
    inc si
    inc di
    jmp @rev
    
@thuong2hoa:
    sub al, 20h
    mov [di], al
    inc si
    inc di
    jmp @rev
       
@display: 
    mov ah, 09
    lea dx, msg2
    int 21h

    mov ah, 09
    lea dx, str2
    int 21h
    
exit: 
    ; wait for any key....    
    mov ah, 1
    int 21h 
       
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
