data segment
    msg  db "Nhap: $"
    msg1 db 10,13,"Ky tu HOA $"
    msg2 db 10,13,"Ky tu thuong $"
    msg3 db 10,13,"Ky tu khac $"
    char db ?
    status db 0
    
ends

code segment
start:
    mov ax, data
    mov ds, ax

          
    lea dx, msg
    mov ah, 9
    int 21h  
    
    mov ah, 1
    int 21h
    
    mov char, al 
    
    mov al, char
    cmp al, 'A'
    jb @kitu_KHAC
     
    cmp al, 'Z'  
    jb @kitu_HOA
    
    cmp al, 'a'
    jb @kitu_KHAC
    
    cmp al, 'z'  
    jb @kitu_THUONG
         
    jmp exit
    
@kitu_KHAC:      
    lea dx, msg3
    mov ah, 9
    int 21h 
    jmp exit  
    
@kitu_HOA: 
    lea dx, msg1
    mov ah, 9
    int 21h 
    jmp exit


@kitu_THUONG:
    lea dx, msg2
    mov ah, 9
    int 21h 
    jmp exit
    
exit:
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
