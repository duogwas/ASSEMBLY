;viet chuong trinh tinh giai thua cua n
INCLUDE LIB1.ASM
.MODEL small
.STACK 100h
.DATA
    mesg1   db 13,10,'Hay vao n : $'
    mesg2   db 13,10,'Giai thua cua $'
    mesg3   db ' la : $'
    mesg4   db 13,10,'Co tiep tuc CT (c/k)? $'
.CODE
MAIN:
    mov ax, @data
    mov ds, ax
    clrscr
    HienString mesg1
    call VAO_SO_N
    mov cx, ax
    HienString mesg2
    call HIEN_SO_N
    HienString mesg3

    mov ax, 1
    cmp cx, 2
    jb HIEN

LAP:
    mul cx
    loop LAP

HIEN:
    call HIEN_SO_N
    HienString mesg4
    mov ah, 1
    int 21h
    cmp al, 'c'
    jne Exit
    jmp MAIN

Exit:
    mov ah, 4ch
    int 21h
    INCLUDE lib2.asm
END MAIN
