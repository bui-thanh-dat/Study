#include <bits/stdc++.h>
using namespace std;

class Nguoi {
	protected: 
	string ten;
	int ns;
	public: 
	virtual ~Nguoi() {}
	virtual void nhap(){
		cout << "Ho va Ten  : "; cin >> ws; getline(cin, ten);
		cout << "Nam sinh: "; cin >> ns;
	}
	virtual void in() {
		cout << "Ten: "<< ten << ", NS: " << ns << endl;
	}
	virtual float luong(){
		return 0;
	}
	virtual float tienthuong() {
		return (2026 - ns) * 500;
	}
}; 
class NhanVien : public Nguoi {
	float hsl;
	public:
		void nhap(){
			Nguoi :: nhap();
			cout << "He so luong: "; cin >> hsl;
		}
		void in() {
			Nguoi :: in();
			cout << "HSL: " << hsl << ", Luong: " << luong() << endl;
		}
		float luong() {
			return hsl * 1600;
		}
		
};

class CauThu :public Nguoi{
	int sbt;
	public:
		void nhap(){
			Nguoi ::nhap();
			cout << "So ban thang: "; cin >> sbt;
		}
		void in(){
			Nguoi :: in();
			cout << "SBT: "<< sbt << ", Luong: " << luong() << endl;
		}
		float luong(){
			return sbt * 1000;
		}
};

class CongTy {
	string tencty;
	int n;
	Nguoi** a;
	public:
		CongTy(){
			n = 0; 
			a = NULL;
		}
		~CongTy(){
			for(int i = 0; i < n; i++){
				delete a[i];
			}
			if(a!= NULL) delete[] a;
		}
		
		void nhap(){
			cout << "Ten cong ty: "; cin >> ws ; getline(cin,tencty);
			cout << "So thanh vien: "; cin >> n;
			a = new Nguoi*[n];
			for(int i = 0; i < n; i++){
				int tl;
				cout << "TV" << i + 1 << "- NV(1)/CT(2): "; cin >> tl;
				if(tl == 1){
					a[i] = new NhanVien();
				}else {
					a[i] = new CauThu();
				}
				a[i] -> nhap();
			}
		}
		void in(){
			cout << "\n===" << tencty << "===" << endl;
			for (int i = 0; i < n; i++){
				a[i] -> in();
			}
		}
		void sapxep(){
			for(int i = 0;i < n - 1; i++){
				for(int j = 0; j < n; j++){
					if(a[i]->luong() > a[j]->luong()){
					Nguoi* t = a[i];
					a[i] = a[j];
					a[j] = t;
					}
				}
			}
		}
		float tongthuong(){
			float s = 0; 
			for(int i = 0; i < n; i++){
				s+= a[i] -> tienthuong();
			}
			return s;
		}
}; 
int main() {
	CongTy c;
	c.nhap();
	c.in();
	c.sapxep();
	cout << "\n Sau khi sap xep luong: ";
	c.in();
	cout << "\nTong tien thuong = " << c.tongthuong() << endl;
	return 0;
}
