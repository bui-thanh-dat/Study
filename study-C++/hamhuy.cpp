#include <iostream>
using namespace std;

class MyTest{
    int size ,*a;
    public:
    void sinh(int n){
        size = n;
        a = new int[n];
        for(int i = 0; i < n ; i++ ) {
            a[i] = i;
        }
    }
    ~MyTest() {
    	if(a!= NULL) {
    		delete []a; 
    		cout << "\nGoi ham huy"; 
		}
	} 
    void ss(MyTest &b){
        if(size != b.size) {
            cout <<"\n Hai dt khac nhau";
        } else cout <<"Hai dt giong size nhau";
    }
	MyTest(const MyTest &b) {
	cout<<"\n ------ Goi ham tao sao chep-----";
	size=b.size; a= new int [size]; for(int i=0; i<size; i++) a[i]=b.a[i];
	}
	MyTest &operator=(const MyTest &b) {
	cout<<"\n ------ Goi toan tu gan-----"; MyTest c; c.size=b.size;
	c.a= new int [size]; for(int i=0; i<size; i++) c.a[i]=b.a[i]; return c;
	}
	};
int main(){
    MyTest a;
    a.sinh(5);
    MyTest c(a);
    a.ss(c); 
    return 0;
}

