#include <iostream> 
#include <cstdlib>
using namespace std;

class Dayso {
	private : 
		int n;
		int* a; // n la so phan tu, mang a luu cac phan tu
		
	public:
		Dayso(int n1 = 0) {
		}
		void sinh(int n) { // sinh day gom b so ngau nhien
			this -> n = n;
			a = new int[n];
			for(int i = 0; i < n; i++) 
			a[i] = rand() % 1001;
		}
		
		void in() {
			cout << "\n Noi dung cua mang:  ";
			for(int i = 0 ; i < n ; i++) {
				cout << a[i] << " ";
			}
		}
		
		void thaydoi(int d=2) {
			for(int i = 0; i<n; i++) {
				a[i] = a[i] + d;
			}
		}
		
		friend int gmax(const Dayso& b);
		
		friend istream & operator >>(istream &is, Dayso &b) {
			cout << "\n Nhap so phan tu:"; 
			cin >> b.n;
			b.a = new int [b.n];
			for(int i = 0; i < b.n; i++) {
				cout << "nhap so thu "<< i + 1 << " :";
				cin >> b.a[i];
			}
			
			return is;
		}
		
		friend ostream & operator << (ostream &os, Dayso&b){
			for(int i = 0 ; i < b.n ; i++ ) cout << " " << b.a[i];
			return os;	
			
		} 
};

int gmax(const Dayso& b) {
	int m = b.a[0];
	for(int i = 0; i < b.n; i++) {
		if(b.a[i] > m ) {
			m = b.a[i];
		}
	}
	return m;
}


int main() {
	Dayso a;
	a.sinh(10);
	cout << " \n Day a: "; a.in();
	Dayso b(a); // shallow copy ( Copy mac dinh ) 
	cout << "\n Day b: ";b.in(); 
	a.thaydoi(5); 
	cout << "\n Day b: "; b.in();
	cout << " \n Day a: "; a.in();	
	
	cout << " \n Max cua day a la: " << gmax(a);
	
	cout<<"\nNhap day a: "; 
	cin >> a;
	cout<<"Day a:"<<a;
}
