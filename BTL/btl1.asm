INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
     tm       db 13, 10, '          CHUC NANG RD'
              db 13, 10, '          ------------'
              db 13, 10, '   Hay vao ten thu muc can xoa: $'
     Err_MD   db 13, 10, '   Khong xoa duoc thu muc!$'
     Suc_MD   db 13, 10, '   Thu muc da duoc xoa!$'
     prompt   db 13, 10, '   An phim bat ky de ve Main Menu$'
     buff     db 30
              db ?
     dir_name db 30 dup(?)
.CODE
PUBLIC @XOATM$qv
@XOATM$qv PROC
     PS:  
          mov        ax, @data
          mov        ds, ax
     L0:  
          CLRSCR
          HienString tm
          lea        dx, buff
          call       GET_FILE_NAME
          lea        dx, dir_name
          mov        ah, 3Ah
          int        21h
          jnc        L1
          HienString Err_MD
          jmp        EXIT
     L1:  
          HienString Suc_MD
     EXIT:
          HienString prompt
          mov        ah, 1
          int        21h
          ret
@XOATM$qv ENDP
          INCLUDE    lib3.asm
    END PS


; INCLUDE lib1.asm
; .MODEL small
; .STACK 100h
; .DATA
;      tm       db 13, 10, '      CHUC NANG RD'
;               db 13, 10, '      ------------'
;               db 13, 10,'Hay vao ten thu muc can xoa: $'
;      Err_MD   db 13, 10,'Khong xoa duoc thu muc!$'
;      Suc_MD   db 13, 10,'Thu muc da duoc xoa!$'
;      prompt   db 13, 10, 'An phim bat ky de ve Main Menu$'
;      buff     db 30
;               db ?
;      dir_name db 30 dup(?)
; .CODE
; PUBLIC @XOATM$qv
; @XOATM$qv PROC
;      PS:  
;           mov        ax, @data
;           mov        ds, ax
;      L0:  
;           CLRSCR
;           HienString tm                ; Hiện thông báo tm
;           lea        dx, buff          ; Vào tên thư mục cần tạo
;           call       GET_FILE_NAME
;           lea        dx, dir_name      ; Chức năng tạo thư mục
;           mov        ah, 3Ah
;           int        21h
;           jnc        L1                ; Nếu bit cờ CF=0 thì nhảy đến L_TM1,
;           HienString Err_MD            ; còn CF=1 thì hiện thông báo lỗi
;           jmp        EXIT

;      L1:  
;           HienString Suc_MD            ; Hiện thông báo thành công

;      EXIT:
;           HienString prompt            ; Hiện thông báo tieptuc
;           mov        ah, 1             ; Chò 1 ký tự từ bàn phím
;           int        21h
;           ret

; @XOATM$qv ENDP
;           INCLUDE    lib3.asm          ; lib4.asm chứa CT con GET_DIR_NAME
;     END PS    
