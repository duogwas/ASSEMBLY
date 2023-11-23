INCLUDE LIB1.ASM
.MODEL small
.STACK 100h
.DATA
     snt1 db 13, 10, 'Tim cac so nguyen to'
          db 13,10, '------***-----------'
          db 13,10,13,10,'Hay vao so gioi han: $'
     snt2 db 13,10, 'Cac so nguyen to tu 2 den $'
     snt3 db ' la: $'
     snt4 db 13,10, 'Tong: $'
     space db ' $'
     tieptuc db 13,10, 'Co tiep tuc CT (c/k)? $'
     so dw ?
     tong   dw ?
.CODE
PS:
    mov ax,@data
    mov ds,ax

    L0: 
         clrscr
         HienString snt1
         call VAO_SO_N    ;Nhan so gioi han
         HienString snt2
         call HIEN_SO_N   ;Hien so gioi han
         HienString snt3
         mov bx,ax
         mov so,1
         mov tong, 0
    L1:
         inc so           ; Lieu so dang xet co phai snt k?
         mov ax,so      
         cmp ax,bx        ; So sanh so dang xet voi so gioi han
         jg L4          ; Neu so dang xet lon hon so gioi han thi ket thuc (dich > nguon => 2>1)
         mov cx,ax        ; Trai lai thi xet lieu co phai snt
         shr cx,1         ; Phan nguyen duong cua so
    L2:
         cmp cx,1         ; So chia da nho hon 1 hay chua
         jle L3           ; Neu <=1 thi so dang xet la so nguyen to nhay L3
         xor dx,dx        ; con khong thi chia so dang xet dx:ax cho cx (so hang chia se chay tu so 2 den2)
         div cx
         and dx,dx        ; dx chua phan du (dung co Z)
         jz L1
         mov ax,so
         loop L2
    L3:
        call HIEN_SO_N    ; Hien snt len man hinh
        HienString space  ; Hien 2 dau cach
        add        tong, ax
        jmp L1
     L4:
        HienString snt4
        mov        ax, tong
        call       HIEN_SO_N
    Exit:
        HienString tieptuc
        mov ah,1
        int 21h
        cmp al,'c'
        jne Thoat
        jmp L0
    Thoat:
        mov ah, 4Ch
        int 21h
INCLUDE LIB2.ASM
END