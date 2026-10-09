// ===== 1. if cơ bản =====
const temp = 35;
if (temp > 30) {
  console.log("Trời nóng");   // chạy vì điều kiện đúng
}

// ===== 2. if / else =====
const age = 16;
if (age >= 18) {
  console.log("Đủ tuổi");
} else {
  console.log("Chưa đủ tuổi"); // chạy
}

// ===== 3. if / else if / else =====
// Kiểm tra từ trên xuống, nhánh ĐẦU TIÊN đúng thì chạy rồi thoát, bỏ qua phần còn lại.
const score = 85;
if (score >= 90) {
  console.log("Xuất sắc");
} else if (score >= 80) {
  console.log("Giỏi");          // chạy (85 >= 80), các nhánh sau bị bỏ qua
} else if (score >= 65) {
  console.log("Khá");
} else {
  console.log("Cần cố gắng");
}

// Thứ tự điều kiện quan trọng: đảo ngược thì kết quả sai
if (score >= 65) {
  console.log("Khá");           // chạy ở đây, dù 85 đáng lẽ là "Giỏi"
} else if (score >= 80) {
  console.log("Giỏi");          // không bao giờ tới được
}

// ===== 4. Điều kiện là truthy / falsy (liên hệ bài logical operators) =====
const items = [];
if (items.length) {             // 0 là falsy
  console.log("Có phần tử");
} else {
  console.log("Danh sách rỗng"); // chạy
}

if ([]) {
  console.log("[] là truthy");   // chạy: mảng rỗng vẫn là truthy
}

// ===== 5. Kết hợp điều kiện bằng && và || =====
const hasTicket = true;
const isVip = false;
if (hasTicket && (age >= 18 || isVip)) {
  console.log("Được vào");
} else {
  console.log("Không được vào"); // chạy: age = 16 và không phải VIP
}

// ===== 6. Bẫy: = và == và === =====
let x = 5;
if (x === 5) {
  console.log("x bằng 5");       // đúng: so sánh
}
// if (x = 10) { ... }  // KHÔNG phải so sánh: đây là phép GÁN, kết quả 10 là truthy

// ===== 7. Bẫy: bỏ dấu {} =====
// Không có {} thì if chỉ điều khiển ĐÚNG MỘT câu lệnh ngay sau nó.
const ok = false;
if (ok)
  console.log("dòng 1");        // thuộc về if
console.log("dòng 2");          // KHÔNG thuộc về if -> luôn chạy
// Khuyến nghị: luôn dùng {} dù chỉ một dòng.

// ===== 8. Early return / guard clause: tránh lồng if quá sâu =====
function checkUser(user) {
  if (!user) {
    return "Chưa đăng nhập";
  }
  if (!user.isActive) {
    return "Tài khoản bị khóa";
  }
  return "Xin chào " + user.name;  // trường hợp chính nằm ở cuối, dễ đọc
}
console.log(checkUser(null));
console.log(checkUser({ name: "Dat", isActive: false }));
console.log(checkUser({ name: "Dat", isActive: true }));

// ===== 9. Toán tử ba ngôi: dạng ngắn của if/else khi chỉ GÁN giá trị =====
const label = age >= 18 ? "người lớn" : "trẻ em";
console.log(label);              // "trẻ em"
