console.log(7 + 2);   // 9
console.log(7 - 2);   // 5
console.log(7 * 2);   // 14
console.log(7 / 2);   // 3.5  (JS không chia nguyên)
console.log(7 % 2);   // 1    (chia lấy dư)
console.log(7 ** 2);  // 49   (lũy thừa)

// Chia nguyên: phải tự làm
console.log(Math.floor(7 / 2)) // 3
Math.floor(-7 / 2);  // -4  (Lưu ý: Không phải -3!)
console.log(Math.trunc(-7 / 2)) // -3  (cắt phần thập phân)

// Chia cho 0 KHÔNG lỗi
console.log(5 / 0);   // Infinity
console.log(-5 / 0);  // -Infinity
console.log(0 / 0);   // NaN

// % lấy dấu của số bị chia
console.log(-7 % 3);  // -1
console.log(7 % -3);  // 1

// Số thực không chính xác tuyệt đối (chuẩn IEEE 754, ngôn ngữ nào cũng vậy)
console.log(0.1 + 0.2);          // 0.30000000000000004
console.log(0.1 + 0.2 === 0.3);  // false

let n = 5;
console.log(n++); // 5 (trả giá trị cũ rồi mới tăng)
console.log(n);   // 6
console.log(++n); // 7 (tăng rồi mới trả)