#include <iostream>
#include <cstring> // Truoc: thieu thu vien nay -> loi strlen/strcpy. Sau: them <cstring>
using namespace std;

class Person{
    protected:
    char* name;
    int year;
    public:
    // Truoc: Person(char* n1= NULL, int t1=0) -> thieu const, warning khi truyen chuoi hang
    // Sau: them const cho tham so con tro
    Person(const char* n1= NULL, int t1=0){
        // Truoc: if(n1 != Null) -> sai ten, C++ phan biet hoa thuong, phai la NULL
        if(n1 != NULL){
            // Truoc: new char[strlen(n1)] -> thieu 1 o cho ky tu ket thuc '\0'
            // Sau: strlen(n1)+1 de du cho cho '\0'
            name = new char[strlen(n1)+1];
            strcpy(name,n1);
        } else {
            // Truoc: khong co nhanh else -> name khong duoc gan gia tri khi n1 la NULL -> loi truy cap vung nho
            // Sau: gan name = NULL de tranh loi
            name = NULL;
        }
        year =t1;
    }
    void input(){
        char t[100];
        cout<<"nhap ten: ";
        // Truoc: fflush(stdin) -> hanh vi khong xac dinh trong C++ chuan
        // Truoc: gets(t) -> ham nay da bi xoa khoi C++14, khong an toan vi khong gioi han ky tu
        // Sau: dung cin.ignore() chi khi buffer con '\n', va cin.getline() co gioi han ky tu
        if(cin.peek() == '\n') cin.ignore();
        cin.getline(t,100);
        // Truoc: new char[strlen(t)] -> thieu 1 o cho '\0'
        // Sau: strlen(t)+1
        name = new char[strlen(t)+1]; strcpy(name,t);
        cout<<"nhap nam sinh:"; cin >> year;
    }
    void output() {
        cout <<"name: " << name << " , year : " << year;
    }
    void setYear(int y) {
        year = y;
    }

};
int main(){
    Person p1;
    p1.input();
    p1.output();
}
