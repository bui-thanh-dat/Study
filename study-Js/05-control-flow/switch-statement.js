// ===== 1. switch cơ bản =====
// So sánh giá trị trong ngoặc với từng case bằng === (so sánh nghiêm ngặt).
const day = 3;
switch (day) {
  case 1:
    console.log("Thứ Hai");
    break;
  case 2:
    console.log("Thứ Ba");
    break;
  case 3:
    console.log("Thứ Tư");   // chạy
    break;
  default:
    console.log("Ngày khác"); // chạy khi không case nào khớp
}

// ===== 2. Bẫy lớn nhất: quên break (fall-through) =====
// Khi một case khớp, JS chạy tiếp TẤT CẢ các case bên dưới cho tới khi gặp break.
const n = 1;
switch (n) {
  case 1:
    console.log("case 1");   // chạy
  case 2:
    console.log("case 2");   // cũng chạy dù n không bằng 2
  case 3:
    console.log("case 3");   // cũng chạy
    break;                   // dừng ở đây
  case 4:
    console.log("case 4");   // không chạy
}

// ===== 3. Fall-through có chủ đích: gộp nhiều case chung một xử lý =====
const month = 2;
switch (month) {
  case 4:
  case 6:
  case 9:
  case 11:
    console.log("30 ngày");
    break;
  case 2:
    console.log("28 hoặc 29 ngày"); // chạy
    break;
  default:
    console.log("31 ngày");
}

// ===== 4. switch dùng === nên KHÔNG ép kiểu =====
const input = "1";               // chuỗi, không phải số
switch (input) {
  case 1:
    console.log("khớp số 1");    // KHÔNG chạy: "1" === 1 là false
    break;
  case "1":
    console.log("khớp chuỗi '1'"); // chạy
    break;
}

// ===== 5. default không bắt buộc đặt cuối =====
// Quy ước: đặt cuối cho dễ đọc. Nếu đặt giữa mà thiếu break thì vẫn fall-through.
const color = "tím";
switch (color) {
  case "đỏ":
    console.log("Màu đỏ");
    break;
  case "xanh":
    console.log("Màu xanh");
    break;
  default:
    console.log("Màu không xác định"); // chạy
}

// ===== 6. Dùng return trong hàm thay cho break =====
function getDayName(d) {
  switch (d) {
    case 1: return "Thứ Hai";
    case 2: return "Thứ Ba";
    case 3: return "Thứ Tư";
    default: return "Không hợp lệ";
  }
}
console.log(getDayName(2)); // "Thứ Ba"
console.log(getDayName(9)); // "Không hợp lệ"

// ===== 7. switch (true): dùng cho điều kiện khoảng giá trị =====
// Mỗi case là một biểu thức boolean, case nào ra true đầu tiên sẽ chạy.
const score = 72;
switch (true) {
  case score >= 90:
    console.log("Xuất sắc");
    break;
  case score >= 70:
    console.log("Khá");        // chạy
    break;
  default:
    console.log("Cần cố gắng");
}

// ===== 8. Phạm vi biến trong case =====
// Tất cả case dùng chung MỘT khối {} của switch. Khai báo let/const trùng tên sẽ lỗi.
// Cách tránh: bọc từng case trong {}.
const type = "a";
switch (type) {
  case "a": {
    const msg = "Loại A";
    console.log(msg);          // chạy
    break;
  }
  case "b": {
    const msg = "Loại B";      // không lỗi nhờ có {} riêng
    console.log(msg);
    break;
  }
}

// ===== 9. Khi nào dùng switch, khi nào dùng if/else? =====
// switch: so sánh MỘT biến với nhiều giá trị cố định (ngày, tháng, loại, lệnh...).
// if/else: điều kiện phức tạp, khoảng giá trị, kết hợp nhiều biến.
