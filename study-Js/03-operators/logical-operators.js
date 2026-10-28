// ===== 1. Ba toán tử logic: && (và), || (hoặc), ! (phủ định) =====
console.log(true && true);    // true
console.log(true && false);   // false (cần CẢ HAI đúng)
console.log(true || false);   // true  (chỉ cần MỘT đúng)
console.log(false || false);  // false
console.log(!true);           // false (đảo ngược)
console.log(!false);          // true

// ===== 2. Truthy / Falsy =====
// JS ép mọi giá trị về boolean khi dùng trong điều kiện.
// Chỉ có 8 giá trị falsy: false, 0, -0, 0n, "", null, undefined, NaN
console.log(Boolean(0));          // false
console.log(Boolean(""));         // false
console.log(Boolean(null));       // false
console.log(Boolean(undefined));  // false
console.log(Boolean(NaN));        // false

// Mọi thứ còn lại đều truthy, kể cả những cái "trông như rỗng"
console.log(Boolean("0"));        // true  <-- bẫy: chuỗi "0"
console.log(Boolean(" "));        // true  (chuỗi có khoảng trắng)
console.log(Boolean([]));         // true  (mảng rỗng)
console.log(Boolean({}));         // true  (object rỗng)

// ===== 3. && và || trả về GIÁ TRỊ, không chỉ true/false =====
// || trả về giá trị truthy đầu tiên (hoặc giá trị cuối cùng nếu không có)
console.log("a" || "b");     // "a"
console.log("" || "b");      // "b"
console.log(0 || null);      // null (cả hai falsy -> lấy cuối)

// && trả về giá trị falsy đầu tiên (hoặc giá trị cuối cùng nếu không có)
console.log("a" && "b");     // "b"
console.log("" && "b");      // ""
console.log(1 && 2 && 3);    // 3

// Ứng dụng thường gặp: giá trị mặc định
const userName = "" || "Khách";
console.log(userName);       // "Khách"

// ===== 4. Short-circuit (đoản mạch) =====
// Vế trái đã đủ quyết định kết quả thì vế phải KHÔNG được chạy.
function sayHi() {
  console.log("sayHi đã chạy");
  return true;
}
console.log(false && sayHi());  // false (sayHi KHÔNG chạy)
console.log(true || sayHi());   // true  (sayHi KHÔNG chạy)
console.log(true && sayHi());   // in "sayHi đã chạy" rồi mới ra true

// Ứng dụng: tránh lỗi khi truy cập thuộc tính của null/undefined
const user = null;
console.log(user && user.name);  // null (không văng lỗi)

// ===== 5. ?? (nullish coalescing) khác || ở đâu? =====
// || coi 0, "", false là falsy -> bị thay thế (có thể không mong muốn)
// ?? chỉ thay thế khi vế trái là null hoặc undefined
const score = 0;
console.log(score || 100);   // 100 <-- sai ý nếu 0 là điểm hợp lệ
console.log(score ?? 100);   // 0   (đúng)
console.log(null ?? 100);    // 100
console.log(undefined ?? 100); // 100

// ===== 6. !! để ép sang boolean =====
console.log(!!"hello");   // true
console.log(!!0);         // false

// ===== 7. Thứ tự ưu tiên: ! > && > || =====
console.log(true || false && false);    // true  (&& tính trước: false && false = false)
console.log((true || false) && false);  // false (dùng ngoặc để rõ ý)

// ===== 8. So sánh: == và === (hay đi cùng toán tử logic) =====
console.log(1 == "1");    // true  (ép kiểu rồi mới so sánh)
console.log(1 === "1");   // false (so sánh cả kiểu -> nên dùng cái này)
console.log(null == undefined);   // true
console.log(null === undefined);  // false
console.log(NaN === NaN);         // false <-- NaN không bằng chính nó
console.log(Number.isNaN(NaN));   // true  (cách kiểm tra NaN đúng)
