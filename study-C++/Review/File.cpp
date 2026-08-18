#include <iostream>
#include <fstream>
using namespace std;

int main(){
	ifstream fi("D:/a.txt"); // open a.txt to read
	ofstream fo("D:/kq.txt"); // open kq.txt to write
	
	int x;
	fi >> x; // doc mot so tu file vao x
	
	fo << x << " "; //ghi x ra file 
	
	fi.close();
	fo.close(); 
	return 0;
}

