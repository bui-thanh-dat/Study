#include <iostream> 
using namespace std; 

class Person {
	public: 
	string name;
	int age;
	
	Person(string n, int a) {
		name = n;
		age = a;
	}
	
	void show() {
		cout << name << " - " << age << endl; 
	}
}; 

int main() {
	Person p("Dat", 20);
	p.show();
}
