#include <bits/stdc++.h> 
using namespace std; 

class TH {
	vector <int> a;
	public: 
	
	// Nhap
	friend istream& operator >> (istream &is, TH &b) {
		int n, x;
		cout << "Nhap so phan tu: ";
		is >> n;
		
		b.a.clear();
		
		for(int i = 0; i < n; i++) {
			is >> x; 
			// tranh trung 
			if(find(b.a.begin(), b.a.end(), x) == b.a.end()) {
				b.a.push_back(x);
			}
		}
		return is;
	}
	
	// Xuat
	friend ostream& operator << (ostream &os, TH &b) { 
		os << "{ ";
		for(int x: b.a) os << x << " ";
		os << "}";
		return os;
	}
	
	// UNION 
	TH operator+(TH b) {
		TH t;
		t.a = a;
		
		for(int x: b.a) {
			if(find(t.a.begin(), t.a.end(), x) == t.a.end()) {
				t.a.push_back(x);
			}
		}
		return t;
	}
	
	//DIFFERENCE ( A - B )
	TH operator-(TH b){
		TH t;
		for(int x: a) {
			if(find(b.a.begin(), b.a.end(), x) == b.a.end()){
				t.a.push_back(x);
			}
		}
		return t;
	}
	
	//INTERSECTION 
	TH operator*(TH b){
		TH t;
		for(int x: a){
			if(find(b.a.begin(), b.a.end(), x) != b.a.end()){
				t.a.push_back(x);
			}
		}
		return t;
	}
}; 
int main(){
	TH a,b,c;
	
	cout << "nhap tap hop a: "; cin >> a;
	cout << "nhap tap hop b: "; cin >> b;
	
	cout << "\n A= "<< a;
	cout << "\n B= "<< b; 
	
	c = a + b; 
	cout << "\n Hop ( A + B ) la: " << c; 
	
	c = a * b;
	cout << "\n Giao ( A * B ) la: " << c;
	
	c = a - b;
	cout << "\n Hieu ( A - B ) la: " << c;
	
	c = b - a;
	cout << "\n Hieu ( B - A ) la:  " << c;
	
	return 0;
}
