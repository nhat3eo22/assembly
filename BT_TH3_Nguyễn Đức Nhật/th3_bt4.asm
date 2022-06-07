data segment 
    msg db "Nhap: $" 
    msg2 db 13,10,"So ki tu: $"
    msg3 db 13,10,"String: $" 
    str db 100 dup('$')
    char db ?
ends

code segment
start:
    mov ax, data
    mov ds, ax

    mov ah, 09h
    lea dx, msg
    int 21h  
    
    lea si, str
    
@input:    
    mov ah, 01h
    int 21h
    
    cmp al, 0Dh
    je @next
    
    mov [si], al
    inc si
    jmp @input
    
@next: 
    lea si, str
    mov cl, 0
    
@calc:
    mov al, [si]
    cmp al, '$'
    je @display
    inc si
    inc cl
    jmp @calc
       
    
@display: 
    mov ah, 09h
    lea dx, msg2
    int 21h 
        
    mov dl, cl
    add dl, 30h
    mov ah, 02 
    int 21h
         
    mov ah, 09h
    lea dx, msg3
    int 21h
    
    mov ah, 09h
    lea dx, str
    int 21h
       
    
exit: 
    ; wait for any key....    
    mov ah, 1
    int 21h 
       
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
