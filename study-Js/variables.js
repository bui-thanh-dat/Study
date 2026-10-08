// 1. Gán lại và khai báo lại
var a = 1;
let b = 2;
const c = 3;

a = 10;   // OK // Gán lại (Re-assignment).
b = 20;   // OK
// c = 30; // LỖI: Assignment to constant variable

var a = 100;   // OK (khai báo lại, dễ gây bug ngầm) // Khai báo lại (Re-declaration)
// let b = 200; // LỖI: Identifier 'b' has already been declared

// 2. const không có nghĩa là "bất biến"
const user = { name: "Dat"};
user.name = "Bui"; // OK, sửa nội dung
// use = {name : "X"} // LỖI, gán lại biến // Gán lại (Re-assignment).

const nums = [1, 2];
nums.push(3); // OK
console.log(nums); // [1, 2, 3]

// biến user giữ địa chỉ của object, const khóa địa chỉ đó, không khóa nội dung ở địa chỉ đó.

// 3. Scope (phạm vi)
if (true) {
  var x = "var";
  let y = "let";
  const z = "const";
}

console.log(x);  // "var"  (rò ra ngoài khối)
// console.log(y); // LỖI ReferenceError
// console.log(z); // LỖI ReferenceError

// 4. Hoisting và TDZ
console.log(p);  // undefined (không lỗi!)
var p = 5;

// console.log(q); // LỖI: Cannot access 'q' before initialization
let q = 5;

// 5. Bẫy kinh điển: var trong vòng lặp
for(var i = 0; i < 3 ; i++){
    setTimeout(() => console.log("var: ",i),0);
}
for(let i = 0; i < 3 ; i++){
    setTimeout(() => console.log("let: ",i),0);
}