include lib1.asm
.model small
.stack 100h
.data
    m1	db	13,10,'Hay vao so luong thanh phan: $'
	m2	db	13,10,'    a[$'
	m3	db 	' ]= $'
	m4	db 13,10,'    Day so vua vao la: $'
	space  db '   $'
	m5	db	13,10,'   Tong day la: $'
	m6	db 	13,10,'Co tiep tuc CT (c/k)?$'
    sltp   dw    ?
	i	   dw    ?	
	a	  dw     100 dup(?)	; Khai báo trường số
.code
PS:
    mov AX,@data
    mov DS,AX
    clrscr
    HienString m1
    call VAO_SO_N
    mov sltp,AX
    mov CX,AX
    lea BX,a
    mov i,0

    L1: 
        HienString m2
        mov AX,i
        call HIEN_SO_N
        HienString m3
        call VAO_SO_N
        mov [BX],AX
        inc i
        add BX,2
        loop L1
        HienString m4
        mov CX,sltp
        lea BX,a

    L2:
        mov AX,[BX]
        call HIEN_SO_N
        HienString space
        add BX,2
        loop L2
        HienString m5
        mov CX,sltp
        lea BX,a
        xor AX,AX

    L3:
        add AX,[BX]
        add BX,2
        loop L3
        call HIEN_SO_N
        HienString m6
        mov AH,1
        int 21h
        cmp AL,'c'
        jne Exit
        jmp PS

    Exit:
        mov AH,4CH
        int 21h

    include lib2.asm
    end PS