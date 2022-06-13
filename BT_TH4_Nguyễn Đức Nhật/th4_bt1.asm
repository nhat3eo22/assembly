.model small
.data
    A dw ?
    B dw ?
    tb1 db 'So A 16bit: $'
    tb2 db 10, 13, 'So B 16bit: $'
    tb3 db 10, 13, 'A + B =    $'
    tb4 db 10, 13, 'A - B =     $'
    tb5 db 10, 13, 'A OR B =    $'
    tb6 db 10, 13, 'A AND B =   $'
MAIN PROC
    mov ax, @data
    mov ds,ax
    
    mov bx, 0
    mov cx, 16
    mov ah,9
    lea dx,tb1
    int 21h
;---------- NHAP ------------    
@loop1:
    mov ah,1
    int 21h
    sub al,30h
    shl bx,1
    add bl,al
    loop @loop1
    mov A, bx
    
    mov bx,0
    mov cx, 16
    lea dx, tb2
    mov ah,9
    int 21h
     
@loop2:
    mov ah,1
    int 21h
    sub al,30h
    shl bx,1
    add bl, al
    Loop @loop2
    mov B,bx

;---------- TONG ------------      
    mov ah, 09
    lea dx, tb3
    int 21h
    
    mov bx,B
    add bx,A 
    
    mov cx,16
    mov dx, 30h
    adc dx,0
    mov ah,2
    int 21h 
    
@loop3:
    mov dl,30h
    shl bx,1
    adc dl,0
    mov ah,2
    int 21h
    loop @loop3 

;---------- HIEU ------------ 
    
    mov ah,9
    lea dx,tb4
    int 21h
    
    mov bx,A
    sub bx,B
    mov cx,16
@loop4:
    mov dl,30h
    shl bx,1
    adc dl,0
    mov ah,2
    int 21h
    loop @loop4 

;---------- OR ------------
    
    mov ah,9
    lea dx,tb5
    int 21h  
    
    mov bx,A
    or bx,B
    mov cx,16
@loop5:
    mov dl,30h
    shl bx,1
    adc dl,0
    mov ah,2
    int 21h
    loop @loop5
    
;---------- AND ------------
    
    mov ah,9
    lea dx,tb6
    int 21h
    mov bx,A
    and bx,B
    mov cx,16
@loop6:
    mov dl,30h
    shl bx,1
    adc dl,0
    mov ah,2
    int 21h
    loop @loop6
    mov ah,4ch
    int 21h
main endp
end main