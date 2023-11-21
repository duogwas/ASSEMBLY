INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
snt1    db 13,10,'        TIM CAC SO NGUYEN TO'
         db 13,10,'       -------------***---------------'
         db 13,10,13,10,'     Hay vao so gioi han : $'
snt2    db 13,10,'   Cac so nguyen to tu 2 den $'
snt3    db ' la : $'
snt4    db 13,10, '     Tong: $'
space   db '  $'
tieptuc db 13,10,'   Bam phim bat ky de ve menu $'
so dw ?
tong dw ?
dem dw ?
dem2 dw ?
M3      db 13,10,'Trung binh cong 2 so nguyen la : $'
dautru db '-$'
M4      db '.5$'
 .CODE
; PUBLIC @soNT$qv
; @soNT$qv PROC
 PS:
      mov ax,@data
      mov ds,ax
   L0:
      clrscr
      HienString snt1
      call VAO_SO_N           ; Nhận số giới hạn
      HienString snt2
      call HIEN_SO_N          ; Hiện số giới hạn
      HienString snt3
      mov bx,ax                      ; BX chứa số giới hạn
      mov so,1
      mov tong, 0
      mov dem,0
  
   L1:
      inc so                             ; Liệu số đang xét có phải là
      mov ax,so                       ; số nguyên tố hay không?
      cmp ax,bx                      ; So sánh số đang xét với số giới hạn
      jg L4
      mov cx,ax                       ; trái lại thì xét liệu có phải là số nguyên tố
      shr cx,1                          ; Phần nguyên dương của so/2
  
   L2:
      cmp cx,1                        ; Số chia đã nhỏ hơn 1 hay chưa?
      jle L3                             ; Nếu <=1 thì số đang xét là số nguyên tố (nhảy đến L3)
      xor dx,dx                       ; còn không thì chia số đang xét (DX:AX) cho cx (số hạng
      div cx                            ; chia sẽ chạy từ so/2 đến 2)
      and dx,dx                      ; dx chứa phần dư (dựng cờ ZF)
      jz  L1                            ;  Nếu ZF=0 (số đang xét không phải là số nguyên tố, bỏ qua
                                          ;  số đó,nhảy về xét số tiếp)          
      mov ax,so
      loop L2

   L3:
      call HIEN_SO_N         ; Hiện số nguyên tố lên màn hình
      HienString space          ; Hiện 2 dấu cách
      add tong, ax
      inc dem
      inc dem2
      jmp L1
      
   L4: 
      HienString snt4
      mov         ax, tong
      call        HIEN_SO_N
      ; xor ax,ax
      HienString M3	; Hiện thông báo M3 (‘Trung binh cong 2 so nguyen la :’)
      div dem
      mov ax, dem
      call  HIEN_SO_N

   L5:
      mov cx, dem2   
      mov ax, dx
      mov bx, ax ; *1   // 2
      shl ax, 1  ; *2   // 4
      shl ax, 1  ; *4   // 6
      add ax, bx ; *5   // 8
      shl ax, 1  ; *10  // 10
      div cx

   L6:
      CBW
      ; mov ax,cx
      call HIEN_SO_N ; Hiển thị phần thập phân
      and dx,dx
      jz Exit
      JMP L5
      
  Exit:
      HienString tieptuc
      mov ah,1
      int 21h
      ret

INCLUDE lib2.asm
; @soNT$qv ENDP	
END
