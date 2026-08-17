#include <bits/stdc++.h> 
using namespace std;

int main(){
	ifstream fi("D:\\a.txt");
	ofstream fo("D:\\kq.txt");
	
	vector<int> a;
	int x;
	while(fi >> x){
		a.push_back(x);
	}
	
	if(a.empty()){
		fo << "FILE RONG!!!"; 
		fi.close();
		fo.close();
		return 0;
	}
	//Khai bao ngoai vong for
	int sum = 0;
	int maxVal = a[0];
	int minVal = a[0];

	for(int i = 0; i < a.size(); i++ ){
		sum += a[i];
		if(a[i] > maxVal) {
			maxVal = a[i];
		}
		if(a[i] < minVal) {
			minVal = a[i];
		}
	}
	float TB = (float)sum / a.size(); // ep kieu chia thuc 
	fo << "Tong = "<< sum << endl;
	fo << "Max = "<< maxVal << endl;
	fo << "Min = "<< minVal << endl;
	fo << "TB = "<< fixed << setprecision(2) << TB;
	
	fi.close();
	fo.close();
	return 0;
}
