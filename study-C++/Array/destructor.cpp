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
    void ss(MyTest b){
        if(size != b.size) {
            cout <<"\n Hai dt khac nhau";
        } else cout <<"Hai dt giong size nhau";
    }
};
int main(){
    MyTest a;
    a.sinh(5);
    MyTest c(a);
    a.ss(c); 
    return 0;
}
