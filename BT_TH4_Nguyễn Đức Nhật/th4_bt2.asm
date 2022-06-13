;Nhap vao ban phim 1 ky tu
;hien thi ma ascii cua no o dang Hex, Dec, Bin
.model small
.stack 100
.data 
     msg1 db "Nhap ki tu: $"
	 msg2 db 10,13,"Hex: $"
	 msg3 db 10,13,"Dec: $"
	 msg4 db 10,13,"Bin: $"
	 val_16 db 16
	 val_10 db 10
     newline db 10,13,'$'
     char db ?  
.code
main proc
    mov ax,@data
    mov ds,ax
    
	mov ah, 9
	lea dx, msg1
	int 21h
	
    mov ah,1
    int 21h
    mov char,al
    lea dx, msg2
    mov ah,9
    int 21h
    
    mov ax,0
    mov al,char
    xor cx,cx
Lap1:
    xor dx,dx
    div val_16
    cmp ah,9
    ja chucai
    add ah,30h  
    jmp so
    chucai:  
    add ah,55   
    so:
    mov dl, ah
    push dx
    inc cx
    xor ah,ah
    cmp ax,0
    jne Lap1
    Hienthi:
        pop dx
        mov ah,2
        int 21h
        loop hienthi  
    mov dx,'h'
    mov ah,2 
    int 21h
    
    lea dx,msg3
    mov ah,9
    int 21h 
    
    xor ah,ah
    mov al,char
    xor cx,cx       ;gan cx = 0 de dem so ky tu so
Lapchia:                                
        xor dx,dx       ;dua dx =0
        div val_10       ;chia cho ax cho 10 o dang 8 bit ah chua so du al chua thuong
        
        add ah,30h      ;bien so trong ah thanh ky tu so
        mov dl,ah       ; dua ah vao dx
        push dx         ;dua dx vao ngang xep
        inc cx          ;them mot chu so la cong them
        xor ah,ah       ;xoa ah
        cmp ax,0        ;neu thuong bang 0 thi dung lai
        jne Lapchia
        
Dochienthi:             ;luc nay cx co gia tri la so ky tu
        pop dx          ;lay tung ky tu so in ra
        mov ah,2
        int 21h
        loop Dochienthi  
        
        lea dx,msg4
        mov ah,9
        int 21h 
        xor bx,bx
        mov bl,char
        mov cx,8
Lap4:
    mov dl,30h
    shl bl,1
    adc dl,0
    mov ah,2
    int 21h
    loop Lap4
    mov dl,'b'
    mov ah,2
    int 21h
    
    mov ah,4Ch
    int 21h
    main endp
end main