#include <iostream> 
#include <fstream> // them thu vien doc file
#include <string>
#include <algorithm>
using namespace std;

class Person {
    protected:
    string name;
    int age;
    public: 
    void nhap() {
//        cout << "Nhap ten: ";
//        cin.ignore(1000,'\n');
//        getline(cin,name);
//        cout << "Nhap tuoi: ";
//        cin >> age;
    }
    // new function: read from file
    void nhapFile(ifstream &in) {
    	getline(in,name);
    	in >> name;
    	in.ignore();
	}

void in(){
    cout <<"Ten: "<< name << ", Tuoi:" << age;
    }
};
class Student : public Person {
    private: 
        float diem;
        string diachi;   
    public: 
        void nhap(){
//            Person :: nhap();
//            cout << "Nhap diem: ";
//            cin >> diem;
        }
        //read from file
void nhapFile(ifstream &in){
    getline(in, name);

    in >> age;
    in.ignore(1000, '\n');   // important 

    getline(in, diachi);

    in >> diem;
    in.ignore(1000, '\n');   // important
}

        void in(){
            Person :: in(); 
            cout << ", Diem: " << diem << endl; 
        }

        float getDiem() {
            return diem;
        }
        void setDiem(float d) {
            diem = d;
        }
};
class Lop {
    private: 
        string tenlop;
        int n;
        Student *a;
    public: 
    void nhap(){
//        cout << "Nhap ten lop: ";
//        cin.ignore(1000,'\n');
//        getline(cin, tenlop);
//        
//        cout << "Nhap so sinh vien: ";
//        cin >> n;
//
//        a = new Student[n];
//
//        for(int i = 0; i < n; i++ ){
//            cout << "\nNhap sinh vien thu "<< i + 1 <<":\n";
//            a[i].nhap();
//        }
    }
    //read file
    void nhapFile(){
    	ifstream in("D:\\new\\LOPHOC.txt");
    	
    	if(!in) {
    		cout << " Open file unsuccessfully! \n";
    		return;
		}
		
		getline(in, tenlop);
		in >> n;
		in.ignore();
		
		a = new Student[n];
		
		for(int i = 0; i < n; i++) {
			a[i].nhapFile(in);
		}
		
		in.close();
	}
    void in(){
        cout << "\nNhap sach lop: " << tenlop << endl; 
        for(int i = 0; i < n; i++){
            a[i].in();
        }
    }
    void sapxep(){
        //Sap xep giam dan theo diem
        for(int i = 0; i < n - 1; i++ ){
            for(int j = i + 1; j < n; j++){
                if(a[i].getDiem() < a[j].getDiem()) {
                    swap(a[i], a[j]);
                }
            }
        }
    }
    void xulydiem(){
        //Cong them 1 diem cho ai < 5 
        for(int i = 0; i < n ; i++) {
            if(a[i].getDiem() < 5 ){
                a[i].setDiem(a[i].getDiem() + 1);
            }
        }
    }
    void dem(){
        int cnt = 0;
        for(int i = 0; i < n; i++ ){
            if(a[i].getDiem() >= 8 ){
                cnt++;
            }
        }
        cout << "\n So sinh vien >= 8 diem: " << cnt << endl;
    }

    ~Lop(){
        delete[] a;
    }
};

int main(){
    Lop a;
   // a.nhap(); 
    a.nhapFile(); // doc file
	a.in();
    
    a.xulydiem(); a.in();
    a.dem();
    a.sapxep(); a.in();

    return 0;
}
