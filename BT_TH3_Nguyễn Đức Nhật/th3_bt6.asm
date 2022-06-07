data segment 
    msg db "Nhap so thu nhat: $"  
    msg1 db 10,13,"Nhap so thu hai: $"
    msg2 db 10,13,"Sum: $"
    num dw 0
    num2 dw 0 
    sum dw 0
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
    mov ax, data
    mov ds, ax 
    
    mov ah, 09
    lea dx, msg
    int 21h
    
    call inputDec
    mov num, ax
    
    mov ah, 09
    lea dx, msg1
    int 21h
    
    call inputDec
    mov num2, ax 
    
    mov ax, num
    add ax, num2
    
    mov sum,ax 
    
    mov ah, 09
    lea dx, msg2
    int 21h
    
    mov ax, sum
    call outputDec
    
    
exit: 
    ; wait for any key....    
    mov ah, 1
    int 21h 
       
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends 


inputDec proc
        ; Vao: nhap vao so
        ; Ra: So luu trong Ax
        push bx
        push cx
        push dx 
         
        batDau:
            mov ah, 2
            xor bx, bx
            xor cx, cx
            mov ah, 1
            int 21h
        
            jmp tiepTuc
             
            tiepTuc:
                cmp al, '0'
                jnge khongPhaiSo    ; khong lop hon hoac bang
                cmp al, '9'
                jnle khongPhaiSo    ; Khong nho hon hoac bang 
                and ax, 000fh       ; doi thanh chu so
                push ax             ; cat vao ngan xep
                mov ax, 10
                 
                mul bx              ; ax = tong*10
                mov bx, ax          
                pop ax
                add bx, ax          ; tong = tong*10 + so
                mov ah, 1
                int 21h
                cmp al, 13          ; da enter chua?
                jne tiepTuc         ; nhap tiep
                 
                mov ax, bx          ; chuyen KQ ra ax
                 
            ra:
                pop dx
                pop cx
                pop bx  
                 
                ret
                 
            khongPhaiSo:
                mov ah, 2
                mov dl, 0dh
                int 21h
                mov dl, 0ah
                int 21h
                jmp batDau
                 
                 
inputDec endp   

outputDec proc
        push bx
        push cx
        push dx
         
        cmp ax, 0   ;   neu ax > 0 tuc la khong phai so am ta doi ra day
        jge doiRaDay
        push ax
        mov dl, '-'
        mov ah, 2
        int 21h
        pop ax
        neg ax  ; ax = -ax
         
        doiRaDay:
            xor cx, cx  ; gan cx = 0
            mov bx, 10  ; so chia la 10
            chia:
                xor dx, dx  ; gan dx = 0
                div bx      ; ax = ax / bx; dx = ax % bx
                push dx
                inc cx
                cmp ax, 0   ; kiem tra xem thuong bang khong chua?
                jne chia    ; neu khong bang thi lai chia
                mov ah, 2
            hien:
                pop dx
                or dl, 30h
                int 21h
                loop hien
                 
                pop dx
                pop cx
                pop bx
                ;pop ax
        ret
         
outputDec endp

            

end start ; set entry point and stop the assembler.
