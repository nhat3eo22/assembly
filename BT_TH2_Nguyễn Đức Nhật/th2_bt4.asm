DSEG SEGMENT
    msg1 db "Nhap: $" 
    msg2 db "Xin chao: $"
    newline db 10,13,"$" 
    max db 255
    len db 0
    string db 255 dup('$')   
DSEG ENDS 

CSEG SEGMENT
    ASSUME CS: CSEG, DS: DSEG
start:
    mov ax, DSEG
    mov ds, ax 
    
    ; Hien thi nhap
    mov ah, 09h 
    lea dx, msg1
    int 21h
    
    mov ah, 0Ah ; Ham 0Ah
    lea dx, max ; dx chua dia chi vung dem ban phim
    int 21h ; goi ngat thuc hien ham  
    
    mov ah, 09h 
    lea dx, newline
    int 21h
     
    ; Hien thi msg2              
    mov ah, 09h 
    lea dx, msg2
    int 21h
    
    ; Hien thi string
    mov ah, 09h 
    lea dx, string
    int 21h  
    
    mov ah, 08h
    int 21h
    
    mov ah, 4Ch ; tro ve he dieu hanh
    int 21h
CSEG ENDS
END start
