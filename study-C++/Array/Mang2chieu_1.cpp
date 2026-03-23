#include <iostream>
using namespace std;

int main(){
	int n,m;
	
	cout << "Nhap so hang va so cot: ";
	cin >> n >> m;
	
	int** arr = new int*[n];
	
	for(int i = 0; i < n ; i++){
		arr[i] = new int[m];
	}
	
	
	cout <<"Nhap cac phan tu cua mang: \n";
	//Nhap mang
	for(int i = 0; i < n; i++) {
		for(int j= 0; j < m ; j++) {
			cout<<"arr["<<i<<"]["<<j<<"] = ";
			cin >> arr[i][j];
		}
	}
	
	
	cout << "Tong tung hang :" << endl;
	//tinh tong tung cot
	for(int j= 0; j < m; j++){
		int sum = 0;
		for(int i = 0 ; i < n; i++){
			sum += arr[i][j];
		}
		cout <<"Hang " << j << ": "<< sum << endl;
	}
	
	//giai phong bo nho
	for(int i = 0 ; i < n; i++) {
		delete[] arr[i];
	}
	delete[] arr;
	
	return 0;
} 
