#include <iostream.h>
#include <conio.h>
extern XOATM();
extern SONT();
extern CONGLPT();
extern CNCD();
void main()
{
    char tl;
    int cn;
    clrscr();
    cout << "\n          TRUONG DAI HOC MO HA NOI";
    cout << "\n          KHOA CONG NGHE THONG TIN";
    cout << "\n          -----------o0o----------";
    cout << "\n\n\n           BAI TAP LON MON LTHT";
    cout << "\n\n\n     Cac SV thuc hien:";
    cout << "\n      1. Kieu Hoang Duong     Lop: 1910A03";
    cout << "\n      2. Nguyen Dinh Phuoc    Lop: 1910A02";
    cout << "\n      3. Tran Van Tien        Lop: 1910A05";
    cout << "\n\n\n     Co tiep tuc CT (c/k)? ";
    cin >> tl;
    if (tl == 'c')
    {
        while (1)
        {
            clrscr();
            cout << "\n            CAC CHUC NANG CUA BTL";
            cout << "\n            ---------***----------";
            cout << "\n\n     1. Chuc nang RD";
            cout << "\n     2. Tim cac so nguyen to";
            cout << "\n     3. So luong cong LPT va dia chi";
            cout << "\n     4. Chuc nang CD";
            cout << "\n     5. Thoat khoi chuong trinh";
            cout << "\n\n     Hay chon: ";
            cin >> cn;
            while (cn <= 0 || cn >= 6)
            {
                cout << "\n     Nhap khong hop le!, vui long nhap lai: ";
                cin >> cn;
            }
            switch (cn)
            {
            case 1:
                XOATM();
                break;
            case 2:
                SONT();
                break;
            case 3:
                CONGLPT();
                break;
            case 4:
                CNCD();
                break;    
            case 5:
                cout << "     Cam on da su dung he thong!\n";
                return;
            default:
                cout << "\n     Vui long nhap lai!";
            }
        }
    }
}