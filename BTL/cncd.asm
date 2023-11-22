INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
     dt1        db 13,10,'Hay vao ten thu muc: $'
     dt2        db 13,10,'Thu muc khong ton tai, vui long nhap lai$'
     suc_msg    db 13,10, 'Vao thu muc thanh cong$'
     buff      db 30
                db ?
     file_name db 30 dup(?)
     parentFile db "..", 0
.CODE
PUBLIC @CNCD$qv
@CNCD$qv PROC
     PS:  
          mov        ax,@data
          mov        ds,ax
          CLRSCR
    
     L0:  
          HienString dt1
          lea        dx, buff
          call       GET_FILE_NAME
          lea        dx, file_name

     L1:  
          mov        ah,3bh
          int        21h
          jnc        L2
          HienString dt2
          jmp        L0
              
     L2:  
          HienString suc_msg

     Exit:
          mov        ah,4ch
          int        21h

     @CNCD$qv ENDP         
          INCLUDE    lib3.asm
     END PS
