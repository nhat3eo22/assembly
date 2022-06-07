DSEG segment
    msg1 db "Hay go 1 phim: $" 
    newline db 10,13,"$"
    msg2 db "Ki tu nhan duoc la: $"  
    char db ?
DSEG ends

CSEG segment
    ASSUME CS: CSEG
start: 
    mov ax, DSEG
    mov ds, ax
    
    mov ah, 09h
    lea dx, msg1
    int 21h
                             
    mov ah, 01h
    int 21h
            
    mov char, al
    
    mov ah, 09h
    lea dx, newline
    int 21h
    
     
    mov ah, 09h
    lea dx, msg2
    int 21h
    
    mov ah, 02h 
    mov dl, char 
    int 21h
     
    ;Dung chuong trinh doi nhap tu ban phim
    mov ah, 08h 
    int 21h 
    
    ;Thoat chuong trinh
    mov ah, 4Ch 
    int 21h
CSEG ends

END start
