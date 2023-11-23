


INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
    dt1         db 13,10, 'Hay vao ten thu muc cu : $'
    dt2         db 13,10, 'Hay vao ten thu muc moi : $'
    dt3         db 13,10, 'Thu muc khong ton tai, vui long nhap lai$'
    Err_REN     db 13,10, 'Khong doi duoc ten thu muc$'
    Suc_REN     db 13,10, 'Thu muc da duoc doi ten$'
    buffc       db 30
                db ?
    file_namec  db 30 dup(?)
    buffm       db 30
                db ?
    file_namem  db 30 dup(?)
    tieptuc     db 13, 10, 'Co tiep tuc CT (c/k) ? $'
    temp        db ?
    parentDir db "..", 0     

.CODE
PS:
    mov  ax,@data
    mov  ds,ax
L_REN0:
    CLRSCR
    HienString dt1
    lea dx, buffc
    call GET_FILE_NAME

    lea dx, file_namec
L0:
    mov ah, 3Bh
    int 21h
    jnc L1
    HienString dt3
    
    jmp L_REN0
L1:
    ; Thực hiện lệnh cd .. (chuyển đến thư mục cha)
     mov ah, 3Bh
    lea dx, parentDir
    int 21h
    
    jmp L2

L2:
  

    HienString dt2
    lea dx, buffm
    call GET_FILE_NAME

    lea dx, file_namec
    lea di, file_namem

    push ds
    pop es
    mov ah, 56h
    int 21h
    jnc L_REN1
    HienString Err_REN
    jmp Exit_REN

L_REN1:
    HienString Suc_REN
Exit_REN:
    HienString tieptuc
    mov ah, 1
    int 21h
    cmp al, 'c'
    jne Thoat_REN
    jmp L_REN0

Thoat_REN:
    mov ah, 4Ch
    int 21h
INCLUDE lib3.asm
END
