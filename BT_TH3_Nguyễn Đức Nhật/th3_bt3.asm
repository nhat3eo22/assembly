data segment 
    msg db "Nhap: $"
    space db " $"
    char db ?
ends

code segment
start:
    mov ax, data
    mov ds, ax

    mov ah, 09h
    lea dx, msg
    int 21h
    
    mov ah, 01h
    int 21h 
    
    mov char,al
    
    mov cl, 'z'
    sub cl,al
    
    mov bl, char 
    inc bl
    mov ah, 02h 
    
@display:
    mov dl, 20h
    int 21h
    
    mov dl, bl 
    int 21h
    inc bl    
    
     
    
    
loop @display
       
    
exit: 
    ; wait for any key....    
    mov ah, 1
    int 21h 
       
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
