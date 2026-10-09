console.log(1 + "2");      // "12"
console.log(1 + 2 + "3");  // "33"  (1+2=3 trước, rồi "3"+"3")
console.log("1" + 2 + 3);  // "123" (nối từ trái sang phải)
console.log(1 + null);     // 1     (null → 0)
console.log(1 + undefined);// NaN   (undefined → NaN)
console.log(true + 1);     // 2     (true → 1)
console.log("a" + null);   // "anull"
console.log([] + []);      // ""
console.log([] + {});      // "[object Object]"

console.log("10" - 3);   // 7
console.log("10" * "2"); // 20
console.log("abc" * 2);  // NaN
console.log("10" / 4);   // 2.5
console.log(true * 5);   // 5
console.log(null * 5);   // 0

console.log(10 < 9);      // false (số với số)
console.log("10" < "9");  // true  <-- so sánh chuỗi theo thứ tự ký tự, "1" < "9"
console.log("10" < 9);    // false (một bên là số nên chuỗi được ép sang số)

