#include <iostream>
using namespace std;

int main(){
	int n,m;
	
	cout<< "Nhap so hang va so cot: ";
	cin >> n >> m;
	
	//khai bao con tro cap 2 arr
	int** arr = new int*[n];
	
	//cap phat vung nho dong co mang 1 chieu cac con tro kieu int*
	//co the hieu arr la mang n phan tu, moi phan tu la 1 con tro kieu int* 
	for(int i = 0;i < n; i++) {
		//cap phat dong cho cac n mang 1 chieu
		arr[i] = new int[m];
	}
	
	cout << "Nhap cac phan tu cua mang: \n";
	
	//import array
	for(int i = 0; i < n; i ++){
		for(int j = 0; j < m; j++){
			cout <<"arr["<< i <<"]["<< j <<"] = ";
			cin >> arr[i][j];
		}
	}
	
	cout <<"Tong tung hang" <<endl;
	
	//caculate the sum of each row
	for(int i =0; i< n; i++){
	 	int sum = 0;
	 	for(int j = 0; j < m; j ++){
	 		sum += arr[i][j];
		}
		cout << "Hang "<< i << ": " << sum << endl;
	}
	
	//free up memory
	for(int i = 0 ; i < n; i++){
		//Giai phong bo nho con cac mang mot chieu
		delete[] arr[i];
	}
	//Giai phong bo nho cho mang cac con tro
	delete[] arr;
	
	return 0;
}
