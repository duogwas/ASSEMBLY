;viet chuong trinh tinh tong cua 2 so nhap tu ban phim (tong 2 so < 10)
.MODEL small
.STACK 100H
.DATA
num1 db ?
num2 db ?
result db ?
msg1 db 13,10, 'Nhap so thu nhat: $'
msg2 db 13,10, 'Nhap so thu hai: $'
msgResult db 13,10, 'Tong hai so: $'
crlf db '$'
.CODE
ADD2NUM:
    MOV AX, @DATA
    MOV DS, AX

;THONG BAO NHAP SO THU NHAT
    MOV AH, 09H
    LEA DX, msg1
    INT 21H

;NHAP SO THU NHAT
    MOV AH, 01H
    INT 21H
    SUB AL,'0' ;CONVERT ASCII CHARACTER TO DECIMAL
    MOV num1, AL ;STORE NUMBER TO VARIABLE NUM1

;THONG BAO NHAP SO THU HAI
    MOV AH, 09H
    LEA DX, msg2
    INT 21H

;NHAP SO THU HAI
    MOV AH, 01H
    INT 21H
    SUB AL,'0'
    MOV num2, AL

; TINH TONG
    ADD AL, num1
    MOV result, AL

; IN TONG RA MAN HINH
    MOV AH, 09H
    LEA DX, msgResult
    INT 21H

    MOV AH, 09H
    LEA DX, crlf
    INT 21H

    ADD result, '0'
    MOV DL, result
    MOV AH, 02H 
    INT 21H

; RETURN TO DOS
    MOV AH, 4CH
    INT 21H

END ADD2NUM
