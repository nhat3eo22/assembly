.model small
.stack 100h
.data 
    n_line db 0dh,0ah,"$"   ;for printing new line 
    a dw ?
    b dw ?
    tb1 db 'So Hex A: $'
    tb2 db 10, 13, 'So Hex B: $'
    tb3 db 10, 13, 'a + b =    $'
    tb4 db 10, 13, 'a - b =     $'
    tb5 db 10, 13, 'a or b =    $'
    tb6 db 10, 13, 'a and b =   $'

.code
   main proc
      mov ax,@data        ;for moving data to data segment
      mov ds,ax
      
      mov ah,9
      lea dx,tb1
      int 21h
      xor bx,bx        ;initially bx value is equal to 0
      mov cl,4      
      
      
      mov ah,1         ;for taking input
      int 21h
      
      
      input1:
          cmp al,0dh   ;compare whether the pressed key is 'enter' or not
          je line1     ;if it is equal to 'enter' then stop taking first value
         
      
          cmp al,39h   ;compare the input whether it is letter or digit.39h is the ascii value of 9
          jg letter1
          
          and al,0fh   ;if it is digit then convert it's ascii value to real value by masking
          jmp shift1
          
      letter1:          ;if it is letter then subtract 37h from it to find it's real value
          sub al,37h
       
      shift1:
          shl bx,cl    ;shift bx 4 digit left for taking next value
          or  bl,al    ;making 'or' will add the current value with previous value
          
          int 21h
          jmp input1
      line1:
          lea dx,tb2
          mov ah,9
          int 21h
          
          xor dx,dx   ;set dx value zero
          
          mov ah,1
          int 21h
          
      input2:    ;level for taking second value as the same way talking before
          cmp al,0dh
          je line2
         
      
          cmp al,39h
          jg letter2
          
          and al,0fh
          jmp shift2
          
      letter2:
          sub al,37h
       
      shift2:
          shl dx,cl
          or  dl,al
          
          int 21h
          jmp input2
      line2:
          mov cx,dx
              
          lea dx,n_line
          mov ah,9
          int 21h
          
          mov dh,16
          
          
          mov a, bx
          mov b, cx
      
;---------- tong ------------      
    mov ah, 09
    lea dx, tb3
    int 21h
    
    mov bx,b
    add bx,a 
    
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

;---------- hieu ------------ 
    
    mov ah,9
    lea dx,tb4
    int 21h
    
    mov bx,a
    sub bx,b
    mov cx,16
@loop4:
    mov dl,30h
    shl bx,1
    adc dl,0
    mov ah,2
    int 21h
    loop @loop4 

;---------- or ------------
    
    mov ah,9
    lea dx,tb5
    int 21h  
    
    mov bx,a
    or bx,b
    mov cx,16
@loop5:
    mov dl,30h
    shl bx,1
    adc dl,0
    mov ah,2
    int 21h
    loop @loop5
    
;---------- and ------------
    
    mov ah,9
    lea dx,tb6
    int 21h
    mov bx,a
    and bx,b
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
        