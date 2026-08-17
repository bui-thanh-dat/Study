#include <iostream>
#include <algorithm>
#include <string>

using namespace std;

///=====================LOP CO SO=======================
class Object {
	protected:
		string name;
		float weight;
	public:
		Object(string n = " ", float w = 0) : name (n), weight(w) {	}
			
			virtual void nhap(){
				cout << "Ten: "; cin.ignore(); getline(cin, name);
				cout << "Can nang(kg): "; cin >> weight;
			}
			virtual void in(){
				cout << "\n [Object] Ten: " << name << "| Can nang: "<< weight << "kg"; 
			}
			
			string getname() { return name; }
			string getwight() { return weight; }
			
			virtual ~Object(){}
};

//===============LOP CON: SACH================ 

class Book : public Object {
	string type; // the loai
	int nop; // so trang
	
	public:
		Book(): Object() {}
		
		void nhap() override {
		Object::nhap();
		cout << "The Loai: "; cin.ignore(); getline(cin, type);
		cout << "So trang: "; cin >> nop;
		}
		
		void in() override {
			Object :: nhap();
			cout << "The Loai: "; cin.ignore(); getline(cin, type);
			cout << "So trang: ", cin >> nop;
		} 
		
		void in() override {
			cout << "\n [Sach] Ten: " << name 
				<< "| Can nang: " << weight << "kg"
				<< "| The loai: " << type 
				<< "| So trang: " << nop; 
		}
};

// ======================LOP CON: CHO =====================
class Dog: public Object {
	string color; // mau long
	public: 
	Dog() : Object() {} 
	
	void nhap() override {
	Object::nhap();
	cout << "Mau long: "; cin.ignore(); getline(cin, color);
	}
	
	void in() override {
		cout << "\n [Cho] Ten: " << name
			<<" | Can nang: " << weight << "kg"
			<<" | Mau long: " << color;
	}
};

//==========================LOP CON: NGUOI ================
class Human : public Object {
	int age; 
	string job;
	public: 
	Human() : Object() {
		Object :: nhap();
		cout << "Tuoi: "; cin >> age;
		cout << "Nghe Nghiep: "; cin.ignore(); getline(cin,job);
	}
	
	void in() override {
	cout << "\n [Nguoi}] Ten: " << name 
		<< " |Can nang: " << weigt << "kg"
		<< " |Tuoi: "<< age;
		<< " |Nghe Nghiep: " << job;
	}
};

//=======================LOP TUI THAN KY==============
class MagicBag {
	int n;
	Object **a;
public:
	MagicBag() : a(0), a(nullptr) {} 
	
	void nhap() {
		cout << "\Nhap so vat trong tui: "; cin >> n;
		a = new Object*[n];
		
		for(int i = 0; i < n; i++ ){
			cout << "\n ---- Vat thu " << i + 1 << " --- ";
			cout << "\n Loai vat (1-Sach/ 2-Cho/ 3-Nguoi): ";
			int tl; cin >> tl;
			
			if(tl = 1 ){
				Book *p = new Book();
				p->nhap()
			}
			
		}
	}
};

