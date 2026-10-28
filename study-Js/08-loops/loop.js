const arr = [1,2,3,4];

// for(let value of arr){
//     console.log(value);
// }

for(let [i,value] of arr.entries()) {
    console.log(i,value);
}

// ===== for cơ bản =====
// Dùng khi biết trước số lần lặp hoặc cần chỉ số (index)
for (let i = 0; i < 5; i++) {
  console.log("for:", i);
}

// ===== while =====
// Dùng khi KHÔNG biết trước số lần lặp, chỉ biết điều kiện dừng
let count = 0;
while (count < 3) {
  console.log("while:", count);
  count++;
}

// ===== do...while =====
// Giống while nhưng luôn chạy ít nhất 1 lần trước khi kiểm tra điều kiện
let n = 10;
do {
  console.log("do...while chạy ít nhất 1 lần:", n);
  n++;
} while (n < 5); // điều kiện sai ngay từ đầu nhưng vẫn chạy 1 lần

// ===== for...of =====
// Lặp qua GIÁ TRỊ của các cấu trúc iterable: string, array, Map, Set...
for (const ch of "abc") {
  console.log("for...of string:", ch);
}

// ===== for...in =====
// Lặp qua KEY (thuộc tính) của object, hoặc index (dạng string) của array
const obj = { x: 1, y: 2, z: 3 };
for (const key in obj) {
  console.log("for...in:", key, obj[key]);
}

// ===== break và continue =====
// break: thoát hẳn khỏi loop
// continue: bỏ qua lần lặp hiện tại, nhảy sang lần lặp kế tiếp
for (let i = 0; i < 10; i++) {
  if (i === 5) break;      // dừng khi i = 5
  if (i % 2 === 0) continue; // bỏ qua số chẵn
  console.log("break/continue:", i);
}

// ===== Labeled loop (nhãn cho loop lồng nhau) =====
// Hữu dụng khi cần break/continue loop NGOÀI từ bên trong loop lồng nhau
outer: for (let i = 0; i < 3; i++) {
  for (let j = 0; j < 3; j++) {
    if (j === 1) continue outer; // thoát vòng lặp j hiện tại, tiếp tục vòng lặp outer
    console.log("labeled:", i, j);
  }
}

// ===== Vòng lặp vô hạn có kiểm soát =====
// Hữu dụng khi điều kiện dừng phức tạp, không gói gọn trong 1 biểu thức đơn giản
let attempts = 0;
while (true) {
  attempts++;
  if (attempts >= 3) break; // luôn phải có điều kiện break, tránh treo chương trình
  console.log("vô hạn có kiểm soát:", attempts);
}

// ===== for...of với entries() trên array (giống string ở đầu file) =====
const fruits = ["apple", "banana", "cherry"];
for (const [index, fruit] of fruits.entries()) {
  console.log("entries():", index, fruit);
}

// ===== Lặp qua Map và Set bằng for...of =====
const map = new Map([["a", 1], ["b", 2]]);
for (const [key, value] of map) {
  console.log("Map:", key, value);
}

const set = new Set([1, 2, 2, 3]);
for (const value of set) {
  console.log("Set:", value);
}

// ===== Object.keys/values/entries kết hợp for...of =====
// Vì object thường không iterable trực tiếp, dùng Object.entries để lấy [key, value]
for (const [key, value] of Object.entries(obj)) {
  console.log("Object.entries:", key, value);
}