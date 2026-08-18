#include <iostream>
#include <algorithm>
#include <string>
using namespace std;

class Object {
protected:
    string name;
    float weight;
public:
    Object(string n = "", float w = 0) : name(n), weight(w) {}

    virtual void nhap() {
        cout << "  Ten: "; cin.ignore(); getline(cin, name);
        cout << "  Can nang (kg): "; cin >> weight;
    }

    virtual void in() {
        cout << "\n  [Object] Ten: " << name << " | Can nang: " << weight << "kg";
    }

    string getname() { return name; }
    float getweight() { return weight; }

    virtual ~Object() {}
};

class Book : public Object {
    string type;   
    int nop;       
public:
    Book() : Object() {}

    void nhap() override {
        Object::nhap();
        cout << "  The loai: "; cin.ignore(); getline(cin, type);
        cout << "  So trang: "; cin >> nop;
    }

    void in() override {
        cout << "\n  [Sach] Ten: " << name
             << " | Can nang: " << weight << "kg"
             << " | The loai: " << type
             << " | So trang: " << nop;
    }
};

class Dog : public Object {
    string color; // màu lông
public:
    Dog() : Object() {}

    void nhap() override {
        Object::nhap();
        cout << "  Mau long: "; cin.ignore(); getline(cin, color);
    }

    void in() override {
        cout << "\n  [Cho] Ten: " << name
             << " | Can nang: " << weight << "kg"
             << " | Mau long: " << color;
    }
};

class Human : public Object {
    int age;
    string job;
public:
    Human() : Object() {}

    void nhap() override {
        Object::nhap();
        cout << "  Tuoi: "; cin >> age;
        cout << "  Nghe nghiep: "; cin.ignore(); getline(cin, job);
    }

    void in() override {
        cout << "\n  [Nguoi] Ten: " << name
             << " | Can nang: " << weight << "kg"
             << " | Tuoi: " << age
             << " | Nghe nghiep: " << job;
    }
};

class MagicBag {
    int n;
    Object **a;
public:
    MagicBag() : n(0), a(nullptr) {}

    void nhap() {
        cout << "\nNhap so vat trong tui: "; cin >> n;
        a = new Object*[n];

        for (int i = 0; i < n; i++) {
            cout << "\n--- Vat thu " << i + 1 << " ---";
            cout << "\nLoai vat (1-Sach / 2-Cho / 3-Nguoi): ";
            int tl; cin >> tl;

            if (tl == 1) {
                Book *p = new Book();
                p->nhap();
                a[i] = p;
            } else if (tl == 2) {
                Dog *p = new Dog();
                p->nhap();
                a[i] = p;
            } else {
                Human *p = new Human();
                p->nhap();
                a[i] = p;
            }
        }
    }

    void in() {
        cout << "\n========== DANH SACH VAT TRONG TUI ==========";
        for (int i = 0; i < n; i++) {
            cout << "\n" << i + 1 << ".";
            a[i]->in();
        }
    }

    void sapxepTen() {
        for (int i = 0; i < n - 1; i++)
            for (int j = i + 1; j < n; j++)
                if (a[i]->getname() > a[j]->getname())
                    swap(a[i], a[j]);

        cout << "\n>> Da sap xep theo ten.";
    }

    void sapxepCanNang() {
        for (int i = 0; i < n - 1; i++)
            for (int j = i + 1; j < n; j++)
                if (a[i]->getweight() < a[j]->getweight())
                    swap(a[i], a[j]);

        cout << "\n>> Da sap xep theo can nang giam dan.";
    }

    void timKiem(string key) {
        cout << "\n========== KET QUA TIM KIEM: \"" << key << "\" ==========";
        bool found = false;
        for (int i = 0; i < n; i++) {
            if (a[i]->getname() == key) {
                a[i]->in();
                found = true;
            }
        }
        if (!found) cout << "\nKhong tim thay vat co ten: " << key;
    }

    ~MagicBag() {
        for (int i = 0; i < n; i++) delete a[i];
        delete[] a;
    }
};

// ==================== MAIN ====================
int main() {
    MagicBag bag;
    bag.nhap();

    int choice;
    do {
        cout << "\n\n========== MENU ==========";
        cout << "\n1. In danh sach";
        cout << "\n2. Sap xep theo ten";
        cout << "\n3. Sap xep theo can nang giam dan";
        cout << "\n4. Tim vat theo ten";
        cout << "\n0. Thoat";
        cout << "\nChon: "; cin >> choice;

        switch (choice) {
            case 1: bag.in(); break;
            case 2: bag.sapxepTen(); bag.in(); break;
            case 3: bag.sapxepCanNang(); bag.in(); break;
            case 4: {
                string key;
                cout << "Nhap ten can tim: "; cin.ignore(); getline(cin, key);
                bag.timKiem(key);
                break;
            }
        }
    } while (choice != 0);

    return 0;
}
