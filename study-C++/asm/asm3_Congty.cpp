#include <bits/stdc++.h>
using namespace std;

class Nguoi {
protected:
    string ten;
    int ns;
public:
    Nguoi(string ten1 = "", int ns1 = 0) { ten = ten1; ns = ns1; }
    virtual ~Nguoi() {}
    virtual void nhap() {
        cout << " Nhap ten: "; cin.ignore(); getline(cin, ten);
        cout << " Nhap nam sinh: "; cin >> ns;
    }
    virtual void in() {
        cout << "\n Ten: " << ten << "\t Nam sinh: " << ns;
    }
    virtual float luong() { return 0; }
    int getTuoi() { return 2026 - ns; }
    string getTen() { return ten; }
};

class NhanVien : public Nguoi {
    float hsl;
public:
    NhanVien(string ten1 = "", int ns1 = 0, float hsl1 = 0) : Nguoi(ten1, ns1) { hsl = hsl1; }
    void nhap() {
        Nguoi::nhap();
        cout << " Nhap he so luong: "; cin >> hsl;
    }
    void in() {
        Nguoi::in();
        cout << "\t HSL: " << hsl << "\t Luong: " << luong();
    }
    float luong() { return hsl * 1600; }
};

class CauThu : public Nguoi {
    int sbt;
public:
    CauThu(string ten1 = "", int ns1 = 0, int sbt1 = 0) : Nguoi(ten1, ns1) { sbt = sbt1; }
    void nhap() {
        Nguoi::nhap();
        cout << " Nhap so ban thang: "; cin >> sbt;
    }
    void in() {
        Nguoi::in();
        cout << "\t SBT: " << sbt << "\t Luong: " << luong();
    }
    float luong() { return sbt * 1000; }
};

class CongTy {
    string tencty;
    int n;
    Nguoi **a;
public:
    CongTy() { n = 0; a = NULL; }
    ~CongTy() {
        for (int i = 0; i < n; i++) delete a[i];
        if (a != NULL) delete[] a;
    }
    void nhap() {
        cout << "\n Nhap ten cong ty: "; cin.ignore(); getline(cin, tencty);
        cout << " Nhap so thanh vien: "; cin >> n;
        a = new Nguoi*[n];
        int tl;
        for (int i = 0; i < n; i++) {
            cout << "\n Thanh vien thu " << i + 1 << ":";
            cout << "\n Nhan vien (1) hay Cau thu (<>1): "; cin >> tl;
            if (tl == 1) a[i] = new NhanVien();
            else a[i] = new CauThu();
            a[i]->nhap();
        }
    }
    void in() {
        cout << "\n=== Cong ty: " << tencty << " - So thanh vien: " << n << " ===";
        for (int i = 0; i < n; i++) a[i]->in();
    }
    void sapxep() {
        for (int i = 0; i < n - 1; i++)
            for (int j = i + 1; j < n; j++)
                if (a[i]->luong() > a[j]->luong()) {
                    Nguoi *t = a[i]; a[i] = a[j]; a[j] = t;
                }
    }
    float tongthuong() {
        float t = 0;
        for (int i = 0; i < n; i++) t = t + a[i]->getTuoi() * 500;
        return t;
    }
};

int main() {
    CongTy c;
    c.nhap();
    cout << "\n----- DANH SACH BAN DAU -----";
    c.in();
    c.sapxep();
    cout << "\n\n----- SAU KHI SAP XEP THEO LUONG TANG DAN -----";
    c.in();
    cout << "\n\n Tong tien thuong cho cac thanh vien = " << c.tongthuong();
    return 0;
}
