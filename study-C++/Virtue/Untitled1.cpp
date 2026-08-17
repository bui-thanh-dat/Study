#include <iostream>
#include <string>
using namespace std;

class Employee {
	string name; int age; float c_salary;
	public:
		Employee (string n1="", int t1=0, float s1=0) {
			name=n1; age=t1; c_salary=s1;
		}
		void nhap () {
			cout << "\nNhap ten: "; cin.ignore(); getline(cin, name);
			cout << "Nhap tuoi: "; cin >> age; 
			cout << "Nhap HSL: "; cin >> c_salary;
		}
		virtual void in () {
			cout << "\nTen: " << name << "\tTuoi: " << age << "\tHSL: " << c_salary;
		}
};

class Manager: public Employee {
	string dept;
	float bonus;
	public:
		void nhap () {
			Employee::nhap();
			cin.ignore();
			cout << "\nPhong ban phu trach: "; getline(cin, dept);
			cout << "\nPhu cap chuc vu: "; cin >> bonus;
		}
		virtual void in () {
			Employee::in();
			cout << "\tPhu trach: " << dept << "\tPhu cap chuc vu: " << bonus;
		}
};

int main () {
	/*
	Employee e1 ("Le Van Hai", 37, 4.33), e2;
	Manager m1, m2;
	m1.nhap(); e1.in(); m1.in();
	e2=m1; cout << "\nGOI IN TU e2:\n"; e2.in();
	*/
	{
		Employee e1 ("Le Van Hai", 37, 4.33), r;
		Manager m1; cout << "Nhap quan ly: "; m1.nhap();
		e1.in(); m1.in();
		cout << "\nXem lai nhan vien hay quan ly (1/<>1)";
		int tl; cin >> tl;
		Employee *p; if(tl==1) p=&e1; else p=&m1;
		p->in();
	}
	return 0;
}
