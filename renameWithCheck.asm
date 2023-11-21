INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
     dt1        db 13,10,'Hay vao ten thu muc cu: $'
     dt2        db 13,10,'Hay vao ten thu muc moi: $'
     dt3        db 13,10,'Thu muc khong ton tai, vui long nhap lai$'
     err_msg    db 13,10,'Khong doi duoc ten thu muc$'
     suc_msg    db 13,10, 'Thu muc da duoc doi ten$'
     buffc      db 30
                db ?
     file_namec db 30 dup(?)
     buffm      db 30
                db ?
     file_namem db 30 dup(?)
     parentFile db "..", 0
.CODE
     PS:  
          mov        ax,@data
          mov        ds,ax
          CLRSCR
    
     L0:  
          HienString dt1                ; Hiện thông báo dt1
          lea        dx, buffc
          call       GET_FILE_NAME      ; Vào tên tệp cần đổi tên
          lea        dx, file_namec     ; ds:dx <- seg:offset xâu chứa tên tệp cũ

     L1:  
          mov        ah,3bh
          int        21h
          jnc        L2
          HienString dt3
          jmp        L0
              
     L2:  
          mov        ah, 3bh
          lea        dx, parentFile
          int        21h
          jmp        L3
 
     L3:  
          HienString dt2                ; Hiện thông báo dt2
          lea        dx, buffm
          call       GET_FILE_NAME      ; Vào tên tệp mới
          lea        dx, file_namec     ; ds:dx <- seg:offset xâu chứa tên thu muc cũ
          lea        di, file_namem     ; di <- offset xâu chứa tên thu muc mới
          push       ds
          pop        es                 ; es=ds
          mov        ah,56h             ; Chức năng đổi tên tệp
          int        21h
          jnc        L4                 ;cf=0 thông báo thành công
          HienString err_msg            ; Hiện thông báo err_msg khi CF=1
          jmp        Exit
    
     L4:  
          HienString suc_msg            ; Hiện thông báo suc_msg khi CF=0

     Exit:
          mov        ah,4ch             ; Về DOS
          int        21h
          INCLUDE    lib3.asm           ; lib3.asm chứa CT con GET_FILE_NAME
	END  PS
