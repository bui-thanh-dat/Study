#include <iostream>
using namespace std;

class Employee
{
	protected:
		string name;
		float wage;
	public:
		Employee (string n1="", float w1=0) {name =n1; wage = w1;}
		string getName() const;
		float getWage() const;
		float pay (float hoursWorked=0) {return hoursWorked * wage;}
		void in() const { cout << "Name: " << name << ", Wage: " << wage << endl; }
};

class Manager:public Employee
{
	protected:
		float bonus;
		string dept;
	public:
		Manager() {}
		Manager (string n1, float w1, float b1, string d1);
		float pay (float hoursWorked) {
			return Employee::pay(hoursWorked) + bonus;
		}
};

string Employee::getName() const {return name;}
float Employee::getWage() const {return wage;}

Manager::Manager(string n1, float w1, float b1, string d1): Employee(n1, w1)
{
	bonus = b1; 
	dept = d1;
}

int main () {
	Employee a, b("Ha", 2000), c; 
	b.in();
	
	Manager d, e("Minh", 7000, 5600,"To chuc"); 
	e.in();
}
