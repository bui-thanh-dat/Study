#include <iostream>
#include <cstring>
using namespace std;

class Person{
    protected:
    char* name;
    int year;
    public:
    Person(const char* n1= NULL, int t1=0){
        if(n1 != NULL){
            name = new char[strlen(n1)+1];
            strcpy(name,n1);
        } else {
            name = NULL;
        }
        year = t1;
    }
    void input(){
        char t[100];
        cout<<"Nhap ten: ";
        if(cin.peek() == '\n') cin.ignore();
        cin.getline(t,100);
        name = new char[strlen(t)+1]; strcpy(name,t);
        cout<<"Nhap nam sinh: "; cin >> year;
    }
    void output(){
        cout<<"Ten: "<<name<<", Nam sinh: "<<year;
    }
};

class Student : public Person{
    char* queQuan;
    float* diem;
    int soDiem;
    public:
    Student() : Person(){
        queQuan = NULL;
        diem = NULL;
        soDiem = 0;
    }

    // Operator= deep copy: copy toan bo du lieu thay vi chi copy con tro
    // Neu khong co ham nay, s2 = s1 se lam 2 doi tuong dung chung vung nho
    // -> doi 1 cai se anh huong cai kia, va khi giai phong se loi double-free
    Student& operator=(const Student& other){
        if(this == &other) return *this; // tranh tu gan chinh minh

        // Giai phong vung nho cu
        if(name) delete[] name;
        if(queQuan) delete[] queQuan;
        if(diem) delete[] diem;

        // Copy name (thuoc tinh cua Person)
        if(other.name){
            name = new char[strlen(other.name)+1];
            strcpy(name, other.name);
        } else name = NULL;

        // Copy year
        year = other.year;

        // Copy queQuan
        if(other.queQuan){
            queQuan = new char[strlen(other.queQuan)+1];
            strcpy(queQuan, other.queQuan);
        } else queQuan = NULL;

        // Copy mang diem
        soDiem = other.soDiem;
        if(other.diem && soDiem > 0){
            diem = new float[soDiem];
            for(int i = 0; i < soDiem; i++)
                diem[i] = other.diem[i];
        } else diem = NULL;

        return *this;
    }

    void input(){
        Person::input();
        char t[100];
        cout<<"Nhap que quan: ";
        if(cin.peek() == '\n') cin.ignore();
        cin.getline(t,100);
        queQuan = new char[strlen(t)+1];
        strcpy(queQuan, t);

        cout<<"Nhap so mon hoc: "; cin >> soDiem;
        diem = new float[soDiem];
        for(int i = 0; i < soDiem; i++){
            cout<<"Diem mon "<<i+1<<": ";
            cin >> diem[i];
        }
    }

    float diemTrungBinh(){
        if(soDiem == 0) return 0;
        float tong = 0;
        for(int i = 0; i < soDiem; i++)
            tong += diem[i];
        return tong / soDiem;
    }

    // in() - in thong tin sinh vien
    void in(){
        Person::output();
        if(queQuan) cout<<", Que quan: "<<queQuan;
        cout<<", DTB: "<<diemTrungBinh()<<endl;
    }

    // doiQue() - thay doi que quan
    void doiQue(const char* que){
        if(queQuan) delete[] queQuan;
        queQuan = new char[strlen(que)+1];
        strcpy(queQuan, que);
    }

    // cms() - giam nam sinh xuong 1
    void cms(){
        year--;
    }

    // cnten() - cap nhat (doi) ten moi
    void cnten(const char* tenMoi){
        if(name) delete[] name;
        name = new char[strlen(tenMoi)+1];
        strcpy(name, tenMoi);
    }

    ~Student(){
        if(queQuan) delete[] queQuan;
        if(diem) delete[] diem;
    }
};

int main(){
    Student s1, s2;
    s1.input();  s1.in();
    s2 = s1;  cout<<"\n Sau khi s2 = s1: "; s2.in();
    s2.doiQue("Ha Noi");
    cout << "\n Sau khi cap nhat que quan: ";
    s1.in(); s2.in(); s2.cms();
    cout << "\n Sau khi cap nhat nam sinh: ";
    s1.in(); s2.in();
    s2.cnten("Nguyen Van An");
    cout << "\n Sau khi cap nhat ho ten: ";
    s1.in(); s2.in();
}
