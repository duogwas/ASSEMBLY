INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
     M1     db 13, 10, '                  CONG LPT'
            db 13, 10, '                  --------'
            db 13, 10, '   May tinh dang dung co cong LPT khong? $'
     co     db 'Co $'
     khong  db 'Khong'
     M2     db 13, 10, '   So luong cong LPT ma may tinh co la: $'
     M3     db 13, 10, '   Dia chi cac cong LPT la: $'
     space  db '   $'
     prompt db 13, 10, '   An phim bat ky de ve Main Menu$'
.CODE
PUBLIC     @CONGLPT$qv
@CONGLPT$qv PROC
     PS:  
          mov        ax,@data
          mov        ds,ax
          CLRSCR
          HienString M1
          int        11h; 411h chua thong tin cong lpt dduwa vao ah
          mov        al,ah
          mov        cl,6
          shr        al,cl
          jnz        L1
          HienString khong
          jmp        EXIT
     
     L1:  
          HienString co
          mov        cl,al
          xor        ch,ch
          HienString M2
          add        al,30h
          mov        ah,0eh
          int        10h
          HienString M3
          xor        ax,ax
          mov        es,ax
          mov        bx,408h
     
     L2:  
          mov        ax,es:[bx]
          call       HIEN_HEXA
          HienString space
          add        bx,2
          loop       L2
     
     EXIT:
          HienString prompt
          mov        ah,1
          int        21h
          ret
@CONGLPT$qv ENDP
          INCLUDE    lib2.asm
     END PS
