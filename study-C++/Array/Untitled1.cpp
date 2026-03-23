#include <iostream> 
using namespace std;

int main(){
	int n =5;
	int a[n];
	
	for(int i = 0; i < n ; i++) {
		cin >> a[i];
	}
	
	for(int i =0; i < n; i++) {
		cout << a[i] << " ";
	}
	
	cout<<" \n DUYET BANG CON TRO: ";
	int* p = &a[0];
	for(int i = 0; i < 5; i++){
		cout << p[i] << " ";
	}
	
	cout << "\n a " << a;
	cout << "\n &a[0]" << &a[0];
	
	return 0;
} 
