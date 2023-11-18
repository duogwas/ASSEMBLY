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
          int        11h
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


; INCLUDE lib1.asm
; .MODEL small
; .STACK 100h
; .DATA
;      M1     db 13, 10, '           CONG LPT'
;             db 13, 10, '           --------'
;             db 13, 10, 'May tinh dang dung co cong LPT khong? $'
;      co     db 'Co $'
;      khong  db 'Khong'
;      M2     db 13, 10,'So luong cong LPT ma may tinh co la: $'
;      M3     db 13, 10,'Dia chi cac cong LPT la: $'
;      space  db '   $'
;      prompt db 13, 10, 'An phim bat ky de ve Main Menu$'
; .CODE
; PUBLIC     @CONGLPT$qv
; @CONGLPT$qv PROC
;      PS:  
;           mov        ax,@data
;           mov        ds,ax
;           CLRSCR
;           HienString M1              ; Hiện thông báo ‘May tinh dang dung co cong LPT khong ?’
;           int        11h             ; Ngắt hệ thống thực hiện việc đưa nội dung ô nhớ 0:411h -> ah
;           mov        al,ah           ; Đưa nội dung 0:411h -> al
;           mov        cl,6
;           shr        al,cl           ; al = số lượng cổng LPT
;           jnz        L1              ; Nếu al # 0 (có cổng LPT thì nhảy)
;           HienString khong           ; còn không thì hiện thông báo ‘Khong’
;           jmp        EXIT            ; Nhảy đến nhãn Exit
     
;      L1:  
;           HienString co              ; Hiện thông báo ‘Co’
;           mov        cl,al
;           xor        ch,ch           ; cx = số lượng cổng LPT (chỉ số vòng lặp hiện địa chỉ)
;           HienString M2              ; Hiện thông báo ‘So luong cong LPT ma may tinh co la : ‘
;           add        al,30h          ; al là mã ASCII số lượng cổng LPT
;           mov        ah,0eh          ; Chức năng hiện 1 ký tự ASCII lên màn hình
;           int        10h
;           HienString M3              ; Hiện thông báo ‘Dia chi cac cong LPT la : ‘
;           xor        ax,ax
;           mov        es,ax
;           mov        bx,408h         ; es:bx = 0:408h (nơi chứa địa chỉ cổng LPT1)
     
;      L2:  
;           mov        ax,es:[bx]      ; ax = địa chỉ LPT
;           call       HIEN_HEXA       ; Hiện địa chỉ dạng HEXA lên màn hình
;           HienString space           ; Hiên một số dấu cách
;           add        bx,2            ; bx trỏ đến các byte chứa địa chỉ cổng COM tiếp theo
;           loop       L2
     
;      EXIT:
;           HienString prompt
;           mov        ah,1            ; Chờ 1 ký tự từ bàn phím
;           int        21h
;           ret
; @CONGLPT$qv ENDP
;           INCLUDE    lib2.asm        ; lib2.asm chứa chương trình con HIEN_HEXA
;      END PS
