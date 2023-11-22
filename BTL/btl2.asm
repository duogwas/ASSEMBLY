INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
     snt1   db 13, 10, '      TIM CAC SO NGUYEN TO'
            db 13, 10, '      --------------------'
            db 13, 10, '   Hay vao so gioi han: $'
     msg db 13, 10, ' So gioi han phai lon hon hoac bang 2$'       
     snt2   db '   Cac so nguyen to tu 2 den $'
     snt3   db ' la: $'
     space  db ' $'
     prompt db 13, 10, '   An phim bat ky de ve Main Menu$'
     so     dw ?
.CODE
PUBLIC @SONT$qv
@SONT$qv PROC
     PS:  
          mov        ax,@data
          mov        ds,ax
          CLRSCR
     L0:        
          HienString snt1
          call       VAO_SO_N

     LCheck:
          cmp ax,2
	     jb   LMSG		; Đúng là ≤ 2 thì nhảy ;nhay khi dich<nguon
          jmp  LAC

     LMSG:
          HienString msg
          jmp L0;
     
     LAC:
          HienString snt2
          call       HIEN_SO_N
          HienString snt3
          mov        bx,ax
          mov        so,1
      
     L1:  
          inc        so
          mov        ax,so
          cmp        ax,bx
          jg         EXIT
          mov        cx,ax
          shr        cx,1  
     L2:  
          cmp        cx,1
          jle        L3
          xor        dx,dx
          div        cx
          and        dx,dx
          jz         L1
          mov        ax,so
          loop       L2
     L3:  
          call       HIEN_SO_N
          HienString space
          jmp        L1
     EXIT:
          HienString prompt
          mov        ah,1
          int        21h
          ret
@SONT$qv ENDP         
          INCLUDE    lib2.asm
     END PS