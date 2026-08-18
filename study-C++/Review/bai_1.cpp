#include <bits/stdc++.h>
using namespace std;

int main(){
	ifstream fi("D:\\a.txt");
	ofstream fo("D:\\kq.txt");
	
	vector<int> a;
	int x;
	while (fi >> x) a.push_back(x);
	
	sort(a.begin(), a.end());
	
	for(int i = 0; i < a.size(); i++) {
		fo << a[i] << " ";
	}
	
	fi.close();
	fo.close();
	return 0;
} 
