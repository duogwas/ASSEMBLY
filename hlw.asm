.model small
.stack 100h
.data
    mesg db 13,10, "hello world$"
.code
    beg: 
         mov ax, @data
         mov ds,ax
         lea dx, mesg
         mov ah,09h
         int 21h
         mov ah,4ch
         int 21h
end beg