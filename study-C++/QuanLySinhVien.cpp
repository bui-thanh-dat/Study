/*
 * CHUONG TRINH QUAN LY SINH VIEN
 * Kien thuc bao gom:
 *  1. Bien, kieu du lieu, nhap/xuat
 *  2. Dieu kien (if/else, switch)
 *  3. Vong lap (for, while)
 *  4. Ham (co tham so, tra ve gia tri, tham chieu)
 *  5. Mang dong (new/delete)
 *  6. Class, constructor, destructor
 *  7. Copy constructor (deep copy)
 *  8. Overload operator (<<, >>)
 *  9. Friend function
 * 10. Ke thua (inheritance)
 */

#include <iostream>
#include <string>
using namespace std;

// ============================================================
// 1. Ham tinh xep loai (ham thuong)
// ============================================================
string xepLoai(float dtb) {
    if (dtb >= 9.0)       return "Xuat sac";
    else if (dtb >= 8.0)  return "Gioi";
    else if (dtb >= 7.0)  return "Kha";
    else if (dtb >= 5.0)  return "Trung binh";
    else                  return "Yeu";
}

// ============================================================
// 2. Class SinhVien
// ============================================================
class SinhVien {
protected:
    string mssv;
    string hoten;
    float dtb;

public:
    // --- Constructor ---
    SinhVien() : mssv(""), hoten(""), dtb(0) {}

    SinhVien(string ms, string ht, float d) {
        mssv  = ms;
        hoten = ht;
        dtb   = d;
    }

    // --- Copy constructor (deep copy - an toan hon) ---
    SinhVien(const SinhVien& sv) {
        mssv  = sv.mssv;
        hoten = sv.hoten;
        dtb   = sv.dtb;
    }

    // --- Destructor ---
    ~SinhVien() {}

    // --- Getter ---
    string getMSSV()  const { return mssv; }
    string getHoTen() const { return hoten; }
    float  getDTB()   const { return dtb; }

    // --- Overload >> de nhap ---
    friend istream& operator>>(istream& is, SinhVien& sv) {
        cout << "  MSSV  : "; is >> sv.mssv;
        cout << "  Ho ten: "; is.ignore(); getline(is, sv.hoten);
        cout << "  DTB   : "; is >> sv.dtb;
        return is;
    }

    // --- Overload << de xuat ---
    friend ostream& operator<<(ostream& os, const SinhVien& sv) {
        os << "  [" << sv.mssv << "] " << sv.hoten
           << " - DTB: " << sv.dtb
           << " (" << xepLoai(sv.dtb) << ")";
        return os;
    }

    // --- Friend function: so sanh 2 sinh vien ---
    friend bool gioiHon(const SinhVien& a, const SinhVien& b) {
        return a.dtb > b.dtb;
    }
};

// ============================================================
// 3. Ke thua: SinhVienCLC (Lop chat luong cao)
// ============================================================
class SinhVienCLC : public SinhVien {
private:
    string hocBong;

public:
    SinhVienCLC() : SinhVien(), hocBong("Khong") {}

    SinhVienCLC(string ms, string ht, float d, string hb)
        : SinhVien(ms, ht, d), hocBong(hb) {}

    friend ostream& operator<<(ostream& os, const SinhVienCLC& sv) {
        os << "  [CLC][" << sv.mssv << "] " << sv.hoten
           << " - DTB: " << sv.dtb
           << " (" << xepLoai(sv.dtb) << ")"
           << " | Hoc bong: " << sv.hocBong;
        return os;
    }
};

// ============================================================
// 4. Class Lop (mang dong cac SinhVien)
// ============================================================
class Lop {
private:
    SinhVien* dsv;  // mang dong
    int soLuong;
    int maxSize;
    string tenLop;

public:
    Lop(string ten, int max = 50) {
        tenLop  = ten;
        maxSize = max;
        soLuong = 0;
        dsv = new SinhVien[maxSize];
    }

    // Deep copy constructor
    Lop(const Lop& lop) {
        tenLop  = lop.tenLop;
        maxSize = lop.maxSize;
        soLuong = lop.soLuong;
        dsv = new SinhVien[maxSize];
        for (int i = 0; i < soLuong; i++)
            dsv[i] = lop.dsv[i];
    }

    ~Lop() {
        delete[] dsv;
    }

    void themSV(const SinhVien& sv) {
        if (soLuong < maxSize)
            dsv[soLuong++] = sv;
        else
            cout << "  Lop da day!\n";
    }

    // Hien thi danh sach
    void hienThi() const {
        cout << "\n=== Danh sach lop: " << tenLop << " ===\n";
        if (soLuong == 0) { cout << "  (Chua co sinh vien)\n"; return; }
        for (int i = 0; i < soLuong; i++)
            cout << dsv[i] << "\n";
    }

    // Tim sinh vien gioi nhat (friend function)
    void svGioiNhat() const {
        if (soLuong == 0) return;
        int idx = 0;
        for (int i = 1; i < soLuong; i++)
            if (gioiHon(dsv[i], dsv[idx]))
                idx = i;
        cout << "\n>> Sinh vien gioi nhat:\n" << dsv[idx] << "\n";
    }

    // Sap xep giam dan theo DTB (bubble sort)
    void sapXep() {
        for (int i = 0; i < soLuong - 1; i++)
            for (int j = 0; j < soLuong - i - 1; j++)
                if (dsv[j].getDTB() < dsv[j+1].getDTB())
                    swap(dsv[j], dsv[j+1]);
        cout << "  Da sap xep theo DTB giam dan.\n";
    }

    // Thong ke xep loai
    void thongKe() const {
        int xuatSac=0, gioi=0, kha=0, tb=0, yeu=0;
        for (int i = 0; i < soLuong; i++) {
            float d = dsv[i].getDTB();
            if      (d >= 9.0) xuatSac++;
            else if (d >= 8.0) gioi++;
            else if (d >= 7.0) kha++;
            else if (d >= 5.0) tb++;
            else               yeu++;
        }
        cout << "\n--- Thong ke lop " << tenLop << " ---\n";
        cout << "  Xuat sac : " << xuatSac << "\n";
        cout << "  Gioi     : " << gioi    << "\n";
        cout << "  Kha      : " << kha     << "\n";
        cout << "  Trung binh: " << tb     << "\n";
        cout << "  Yeu      : " << yeu     << "\n";
        cout << "  Tong     : " << soLuong << "\n";
    }

    int getSoLuong() const { return soLuong; }
};

// ============================================================
// 5. Menu chinh
// ============================================================
void menu() {
    cout << "\n+------------------------------+\n";
    cout << "|    QUAN LY SINH VIEN         |\n";
    cout << "+------------------------------+\n";
    cout << "|  1. Them sinh vien           |\n";
    cout << "|  2. Hien thi danh sach       |\n";
    cout << "|  3. Sap xep theo DTB         |\n";
    cout << "|  4. Sinh vien gioi nhat      |\n";
    cout << "|  5. Thong ke xep loai        |\n";
    cout << "|  6. Demo ke thua (SV CLC)    |\n";
    cout << "|  0. Thoat                    |\n";
    cout << "+------------------------------+\n";
    cout << "Chon: ";
}

int main() {
    Lop lop("CNTT01");
    int chon;

    // Them san 3 sinh vien de demo
    lop.themSV(SinhVien("SV001", "Nguyen Van An",  8.5));
    lop.themSV(SinhVien("SV002", "Tran Thi Bich",  7.2));
    lop.themSV(SinhVien("SV003", "Le Hoang Nam",   9.1));

    do {
        menu();
        cin >> chon;

        switch (chon) {
            case 1: {
                SinhVien sv;
                cout << "\n-- Nhap thong tin sinh vien --\n";
                cin >> sv;
                lop.themSV(sv);
                cout << "  Da them thanh cong!\n";
                break;
            }
            case 2:
                lop.hienThi();
                break;
            case 3:
                lop.sapXep();
                lop.hienThi();
                break;
            case 4:
                lop.svGioiNhat();
                break;
            case 5:
                lop.thongKe();
                break;
            case 6: {
                // Demo ke thua
                SinhVienCLC sv("SV999", "Pham Thi Mai", 8.8, "50%");
                cout << "\n-- Demo SinhVienCLC (ke thua) --\n";
                cout << sv << "\n";

                // Demo copy constructor
                SinhVien sv2(sv);  // copy tu SinhVienCLC sang SinhVien
                cout << "\n-- Ban sao (copy constructor) --\n";
                cout << sv2 << "\n";
                break;
            }
            case 0:
                cout << "\n  Tam biet!\n";
                break;
            default:
                cout << "\n  Lua chon khong hop le!\n";
        }
    } while (chon != 0);

    return 0;
}
