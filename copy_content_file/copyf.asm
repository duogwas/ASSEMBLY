INCLUDE lib1.asm
.MODEL	small	
.STACK	100h
.DATA
    m1	db	13,10,'Hay vao ten tep can copy di: $'
	m2	db	13,10,'Hay vao ten tep can copy den: $'
	Err_O	db	13,10,'Khong mo duoc tep!$'
	Err_R	db	13,10,'Khong doc duoc tep! $'
	Err_W	db	13,10,'Khong ghi duoc tep! $'
	Err_C	db	13,10,'Khong dong duoc tep! $'
	the_teps	dw	?
	the_tepd	dw	?
	buff	db	40
		    db	?
	file_name	db	40 dup(?)
	dem	db	512 dup(?)
	tieptuc	db	13,10,'Co tiep tuc CT (c/k)? $'
.CODE
    PS:
    	mov	AX,@data	; Đưa phần địa chỉ segment của vùng
	    mov	DS,AX	; nhớ cấp phát cho biến vào DS
        
    L0:
   	    clrscr	; Xóa màn hình
    	Hienstring  m1	; Hiện thông báo m1
    	lea	DX,buff	; DS:DX trỏ đến đầu vùng nhớ buff
    	call GET_FILE_NAME; Chương trình con vào tên tệp
    	lea	DX,file_name	; DS:DX trỏ đến đầu xâu chứa tên tệp	
    	mov	AL,0	; Để đọc
    	mov	AH,3DH	; Chức năng mở tệp đã có
	    int	21H
    	jnc	L1	; CF=0 (mở tệp thành công) thì nhảy,
	    HienString  Err_O	; còn CF=1 thì hiện thông báo lỗi
    	jmp	Exit

    L1:	
        mov	the_teps,AX	; Cất thẻ tệp của tệp cần copy đi vào biến the_teps
    	HienString m2	; Hiện thông báo m2
    	lea	DX,buff	; DS:DX trỏ đến đầu vùng nhớ buff
    	call	GET_FILE_NAME; Chương trình con vào tên tệp
    	lea	DX,file_name	; DS:DX trỏ đến đầu xâu chứa tên tệp	
    	mov	CX,0	; Không đặt thuộc tính nào cho tệp cần copy đến
    	mov	AH,3CH	; Chức năng tạo tệp mới và mở
	    int	21H
    	jnc	L2	; CF=0 (mở tệp thành công) thì nhảy,
	    HienString  Err_O	; còn CF=1 thì hiện thông báo lỗi
    	jmp	DONG_TEPS
  
    L2:	
        mov	the_tepd,AX	; Cất thẻ tệp của tệp cần copy đến vào biến the_tepd

    L3: 
        mov	BX,the_teps	; BX=the_teps
        lea	DX,dem	; DS:DX trỏ đến vùng nhớ chứa dữ liệu sẽ đọc từ tệp
    	mov	CX,512	; CX=số lượng byte cần đọc
    	mov	AH,3FH	; Chức năng đọc tệp
	    int	21H 
    	jnc	L4	; CF=0 (đọc tệp thành công) thì nhảy,
	    HienString  Err_R	; còn CF=1 thì hiện thông báo lỗi
    	jmp	DONG_TEPD
    
    L4:	
        and	AX,AX	; Đã hết tệp chưa?
    	jz	L5	; Hết tệp thì nhảy,
    	mov	BX,the_tepd	; còn chưa hết tệp thì ghi vào tệp cần copy đến
    	lea	DX,dem	; DS:DX trỏ đến vùng nhớ chứa dữ liệu sẽ ghi
    	mov	CX,AX	; CX=số lượng byte thực tế đã đọc
    	mov	AH,40H	; Chức năng ghi tệp
	    int	21H 
    	jnc	L5	; CF=0 (ghi tệp thành công) thì nhảy,
    	HienString  Err_W	; còn CF=1 thì hiện thông báo lỗi
    	jmp	DONG_TEPD

    L5:	
        jmp	L3	; Nhảy về đọc /ghi sector tiếp theo

    DONG_TEPD:
        mov	BX,the_tepd	; Đóng tệp cần copy đến (đích)
    	mov	AH,3EH	; Chức năng đóng tệp
	    int	21H
    	jnc	DONG_TEPS	; Nếu CF=0 thì nhảy
	    HienString  Err_C	; còn CF=1 thì hiện thông báo lỗi

    DONG_TEPS: 
    	mov	BX,the_teps	; Đóng tệp cần copy đi (nguồn)
    	mov	AH,3EH	; Chức năng đóng tệp
	    int	21H
    	jnc	Exit	; Nếu CF=0 thì nhảy
	    HienString  Err_C	; còn CF=1 thì hiện thông báo lỗi

    Exit:	
        HienString tieptuc	; Hiện thông báo tieptuc	
    	mov	AH,1	; Chờ 1 ký tự từ bàn phím
	    int	21h
    	cmp	AL,'c'	; Liệu ký tự vào là ‘c’ (có tiếp tục chương trình)
    	jne	Thoat	; Không tiếp tục chương trình thì nhảy về Thoat,
    	jmp	L0	; còn tiếp tục chương trình thì trở về L0
    
    Thoat: 	
    	mov	AH,4CH	; Về DOS
	    int	21H
        INCLUDE lib3.asm	; lib3.asm chứa CT con GET_FILE_NAME
    END	PS