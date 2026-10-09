console.log(Number("42"));     // 42
console.log(Number("  42  ")); // 42 (bỏ khoảng trắng hai đầu)
console.log(Number("42px"));   // NaN
console.log(Number(""));       // 0   <-- bẫy
console.log(Number(null));     // 0
console.log(Number(undefined));// NaN
console.log(Number(true));     // 1
console.log(Number([]));       // 0
console.log(Number([5]));      // 5
console.log(Number([1, 2]));   // NaN
console.log(+"42");            // 42 (dấu + đứng trước là cách viết gọn)


//parseInt và parseFloat khoan dung hơn Number: đọc từ trái sang, dừng khi gặp ký tự không hợp lệ.
console.log(parseInt("42px"));      // 42
console.log(Number("42px"));        // NaN
console.log(parseFloat("3.14abc")); // 3.14
console.log(parseInt("abc"));       // NaN
console.log(parseInt(""));          // NaN (khác Number("") là 0)
console.log(parseInt("3.99"));      // 3 (cắt, không làm tròn)
console.log(parseInt("101", 2));    // 5 (luôn truyền cơ số khi dùng) // parseInt(string, radix) // 

// NÊN VIẾT
//let age = parseInt("20", 10); // Ép chuỗi "20" theo hệ thập phân -> ra 20

// KHÔNG NÊN VIẾT
//let age = parseInt("20"); // Để JS tự đoán cơ số

//Sang chuỗi:
console.log(String(123));       // "123"
console.log(String(null));      // "null"
console.log(String(undefined)); // "undefined"
console.log(String([1, 2]));    // "1,2"
console.log(String({}));        // "[object Object]"
console.log((255).toString(16));// "ff" 
/*Hàm .toString(16) nghĩa là: "Chuyển số 255 (đang ở hệ thập phân - cơ số 10) 
sang dạng chuỗi ở hệ thập lục phân (Hexadecimal - cơ số 16)". */

//Sang boolean:
console.log(Boolean("hello")); // true
console.log(Boolean(0));       // false
console.log(!!"hello");        // true (!! là cách viết gọn)