#include<bits/stdc++.h>
using namespace std;
class NV{
	private:
		string ten, que;
		double hsl;
	public: 
	void nhap();
	void in() {
		cout<<" \n Ten: "<< ten << " \t Que: "<< que<< "\t HSL: "<< hsl; 
	}
	
	friend void ssluong(NV x, NV y); // cap quyen
};

//void NV:: nhap() {
//		cout << "nhap ho ten: "; fflush(stdin); getline(cin, ten);
//		cout << "nhap que quan: "; fflush(stdin); getline(cin,que);
//		cout << "nhap he so luong: "; cin >> hsl;
//	}
	void NV :: nhap() {
		cout << "Nhap ho ten: "; getline(cin, ten);
		cout << "Nhap que quan: "; getline(cin, que);
		cout << "Nhap he so luong: "; cin >> hsl;
	}
	void ssluong(NV x, NV y){
		if(x.hsl > y.hsl) {
			cout << "\n Nguoi thu nhat luong cao hon!";
		} else if(x.hsl < y.hsl) {
		 cout << "\n Nguoi thu hai luong cao hon! "; 
		} else {
			cout <<"\n Hai nguoi luong bang nhau";
		}
	}
int main(){
	NV a, b;
	a.nhap();
	cin.ignore(numeric_limits<streamsize> :: max(), '\n' ); // thay fflush 
	b.nhap();
	cin.ignore(numeric_limits<streamsize> :: max(), '\n' ); // thay fflush 
	a.in();
	b.in();
	ssluong(a,b);
}
