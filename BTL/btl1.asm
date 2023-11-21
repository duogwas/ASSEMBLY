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
