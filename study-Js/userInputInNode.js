//Bước 2: Nạp thư viện
const prompt = require("prompt-sync")()

//Bước 3: Hỏi và nhận input
const name = prompt("Tên bạn là gì? ");
console.log("Xin chào, " + name + "!");

// Bước 4: Input luôn là string
const input = prompt("Enter age: ");
console.log(input + 1); // 251
console.log(Number(input) + 1); 26

//Bước 5: Giá trị mặc định
const city=  prompt("City: ", "Da Nang");
console.log(city);

//Bước 6: Kiểm tra input hợp lệ

const ageInput = prompt("Nhập tuổi: ");
const age = Number(ageInput);

if (ageInput.trim() === "" || Number.isNaN(age)) {
  console.log("please enter proper age!");
} else {
  console.log(`Next year you are ${age + 1} years old`);
}

//Bước 7: Hỏi lặp đến khi đúng
let myAge;
while(true){
    const inputMyAge = prompt("Enter age:");
    age = Number(inputMyAge);
    if(input.trim() !== "" && !Number.isNaN(age) && age > 0) break;
    console.log("Không hợp lệ, nhập lại!");
}
console.log(`Bạn ${age} tuổi`);