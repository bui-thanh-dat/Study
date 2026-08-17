#include<bits/stdc++.h>
using namespace std;

class Animal{
protected:
    string name;
    int weigh;
public:
    virtual void nhap(){
        cout << "Ten: "; cin.ignore(); getline(cin, name);
        cout << "Can nang: "; cin >> weigh;
    }
    virtual void in(){
        cout << "\nTen: " << name << "\tCan nang: " << weigh << "kg";
    }
    virtual void chao() = 0;
    virtual ~Animal(){}

    int getWeigh(){ return weigh; }
    string getName(){ return name; }
};

class Cat: public Animal{
private:
    string color;
    bool climb;
public:
    void nhap(){
        cout << "\n--- Nhap thong tin Meo ---\n";
        Animal::nhap();
        cout << "Mau long: "; cin.ignore(); getline(cin, color);
        int t;
        cout << "Co leo cay duoc khong (1: Co, 0: Khong): "; cin >> t;
        climb = (t == 1);
    }
    void in(){
        Animal::in();
        cout << "\tMau long: " << color
             << "\tLeo cay: " << (climb ? "Co" : "Khong");
    }
    void chao(){
        cout << "\nMeo " << name << " noi: Meo meo! Miau~";
    }
};

class Dog: public Animal{
private:
    string bread;
    int loyalty;
public:
    void nhap(){
        cout << "\n--- Nhap thong tin Cho ---\n";
        Animal::nhap();
        cout << "Giong (bread): "; cin.ignore(); getline(cin, bread);
        cout << "Do trung thanh (1-10): "; cin >> loyalty;
    }
    void in(){
        Animal::in();
        cout << "\tGiong: " << bread
             << "\tTrung thanh: " << loyalty << "/10";
    }
    void chao(){
        cout << "\nCho " << name << " noi: Gau gau! Woof!";
    }
};

class Chuong {
private:
    vector<Animal*> a;
public:
    ~Chuong(){
        for(Animal* x : a) delete x;
    }

    void nhap(){
        cout << "Nhap so luong con vat: ";
        int n; cin >> n;
        for(int i = 0; i < n; i++){
            int type;
            cout << "\nCon thu " << i+1 << " - Nhap Cat(1) hay Dog(2): ";
            cin >> type;
            Animal* p;
            if(type == 1) p = new Cat();
            else p = new Dog();
            p->nhap();
            a.push_back(p);
        }
    }

    void in(){
        cout << "\n====== DANH SACH CHUONG THU ======";
        for(int i = 0; i < a.size(); i++){
            cout << "\n--- Con thu " << i+1 << " ---";
            a[i]->in();
        }
    }

    void chao(){
        cout << "\n====== CAC CON THU CHAO ======";
        for(Animal* x : a) x->chao();
    }

    void sapxep(){
        sort(a.begin(), a.end(), [](Animal* x, Animal* y){
            return x->getWeigh() > y->getWeigh();
        });
        cout << "\nDa sap xep theo can nang giam dan.";
    }
};

int main(){
    Chuong c;
    c.nhap();
    c.in();
    c.chao();
    c.sapxep();
    c.in();
    cout << "\nXONG!";
    return 0;
}
