#include <iostream>
using namespace std;

class A {
    protected:
        int a; 
    public: 
        A (int a1 = 0) {
            a = a1; 
        }
        void in() {
            cout << "a = " << a;
        }
};

class B:A {
    private:
    int b;
    public:
    B(int a1 = 15, int b1 = 9) : A(a1) {
        b = b1;
    }
    void in() {
        cout <<"b = "<< b;
        cout << "a trong lop a = "<< A::a;  
    }
};

int main() {
     A a(5); 
     cout <<"Doi tuong a: "; a.in();
     B b;
     cout <<"\nDoi tuong b: "; b.in();
}
