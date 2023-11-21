INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
  tm         db 13, 10, '      CHUC NANG RD'
             db 13, 10, '      ------------'
             db 13, 10,'   Hay vao ten thu muc can xoa: $'
  tm1        db 13,10,'   Thu muc khong ton tai, vui long nhap lai$'
  tm2        db 13, 10, '   Thu muc co tep o trong, khong xoa duoc.$'
  err_msg    db 13, 10,'   Khong xoa duoc thu muc!$'
  suc_msg    db 13, 10,'   Thu muc da duoc xoa!$'
  prompt     db 13, 10, '   An phim bat ky de ve Main Menu$'
  buff       db 30
             db ?
  dir_name   db 30 dup(?)
  DTA        db 128h dup(0)
  file_spec  db "*.*", 0
  parentFile db "..", 0
  
.CODE
       PUBLIC     @XOATM$qv
@XOATM$qv PROC
  PS:  
       mov        ax,@data
       mov        ds,ax
       CLRSCR
    
  L0:  
       HienString tm                   ; Hiện thông báo tm
       lea        dx, buff             ; Vào tên thư mục cần tạo
       call       GET_FILE_NAME
       lea        dx, dir_name         ; Chức năng tạo thư mục

  L1:  
       mov        ah,3bh
       int        21h
       jnc        L2
       HienString tm1
       jmp        L0

  L2:  
       mov        dx,offset DTA
       mov        ah,1Ah
       int        21h

       mov        dx,offset file_spec
       xor        cx, cx
       mov        ah,4Eh
       mov        al, 1
       int        21h
       cmp        ax, 0                ; Nếu ax = 0, có nghĩa là tìm thấy tệp đầu tiên
       je         L3                   ; Nếu tệp đầu tiên được tìm thấy, nhảy L3
       mov        ah, 3bh              ; Nếu không có tệp nào được tìm thấy, trở về thư mục gốc
       lea        dx, parentFile
       int        21h
       jmp        L4
                
  L3:  
       Hienstring tm2
       jmp        Exit

  L4:  
       lea        dx, dir_name         ; Chức năng xóa thư mục
       mov        ah, 3Ah
       int        21h
       jnc        L5                   ; Nếu bit cờ CF=0 thì nhảy đến L5,
       HienString err_msg              ; còn CF=1 thì hiện thông báo lỗi
       jmp        EXIT

  L5:  
       HienString suc_msg              ; Hiện thông báo thành công
     
  Exit:
       HienString prompt               ; Hiện thông báo tieptuc
       mov        ah, 1                ; Chò 1 ký tự từ bàn phím
       int        21h
       ret
@XOATM$qv ENDP
       INCLUDE    lib3.asm             ; lib4.asm chứa CT con GET_DIR_NAME
    END PS 