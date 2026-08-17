#include <bits/stdc++.h>
using namespace std;

class Diem {
    int x, y;
public:
    // getter / setter — bắt buộc có để lớp bao dùng
    int getx()       { return x; }
    int gety()       { return y; }
    void setx(int k) { x = k; }
    void sety(int k) { y = k; }

    void nhap() {
        cout << " x: "; cin >> x;
        cout << " y: "; cin >> y;
    }
    void in() {
        cout << "(" << x << ", " << y << ")";
    }
    float kc(Diem b) {
        return sqrt(pow(x - b.x, 2) + pow(y - b.y, 2));
    }
};

class Tamgiac {
    Diem d1, d2, d3;   // 3 đối tượng thành phần
public:
    void nhap() {
        cout << "\n Nhap diem 1: "; d1.nhap();
        cout << "\n Nhap diem 2: "; d2.nhap();
        cout << "\n Nhap diem 3: "; d3.nhap();
    }
    void in() {
        cout << "\n D1="; d1.in();
        cout << "  D2="; d2.in();
        cout << "  D3="; d3.in();
    }
    float dt() {
        float a = d1.kc(d2);
        float b = d2.kc(d3);
        float c = d3.kc(d1);
        float p = (a + b + c) / 2;
        return sqrt(p*(p-a)*(p-b)*(p-c));
    }
    // Tịnh tiến theo trục x — phải qua getter/setter
    void tinhtienx(int k) {
        d1.setx(d1.getx() + k);
        d2.setx(d2.getx() + k);
        d3.setx(d3.getx() + k);
    }
};

int main() {
    Tamgiac m;
    m.nhap();
    m.in();
    cout << "\n Dien tich = " << m.dt();
    m.tinhtienx(3);
    cout << "\n Sau tinh tien: "; m.in();
}