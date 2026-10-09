// ===== 1. Primitive (kiểu nguyên thủy) =====
const age = 21;                 // number
const price = 19.99;            // number (JS không phân biệt int/float)
const name = "Dat";             // string
const isStudent = true;         // boolean
let notAssigned;                // undefined (khai báo nhưng chưa gán)
const empty = null;             // null (cố ý "không có giá trị")
const big = 12345678901234567890n; // bigint (số rất lớn, có chữ n cuối)
const id = Symbol("id");       // symbol (giá trị duy nhất)

console.log("--- typeof ---");
console.log(typeof age);         // number
console.log(typeof name);        // string
console.log(typeof isStudent);   // boolean
console.log(typeof notAssigned); // undefined
console.log(typeof empty);       // object  <-- lỗi lịch sử của JS, null KHÔNG phải object
console.log(typeof big);         // bigint
console.log(typeof id);          // symbol

// ===== 2. Reference (kiểu tham chiếu) =====
const user = { name: "Dat", age: 21 }; // object
const nums = [1, 2, 3];                // array (thực chất là object)
function hello() {}                    // function

console.log("--- reference ---");
console.log(typeof user);              // object
console.log(typeof nums);              // object
console.log(Array.isArray(nums));      // true  <-- cách đúng để kiểm tra array
console.log(typeof hello);             // function

// ===== 3. Khác biệt primitive vs reference =====
let a = 10;
let b = a;       // COPY giá trị
b = 20;
console.log("--- copy vs tham chiếu ---");
console.log(a, b);               // 10 20 (a không đổi)

const obj1 = { x: 1 };
const obj2 = obj1;               // CHIA SẺ cùng một object
obj2.x = 99;
console.log(obj1.x, obj2.x);     // 99 99 (cả hai đổi)

// ===== 4. Chuyển đổi kiểu =====
console.log("--- chuyển đổi ---");
console.log(Number("42"));       // 42
console.log(Number("abc"));      // NaN
console.log(Number(""));         // 0
console.log(String(123));        // "123"
console.log(Boolean(0));         // false
console.log(Boolean("hello"));   // true
console.log("5" + 1);            // "51" (nối chuỗi)
console.log("5" - 1);            // 4   (tự ép sang số)

// ===== 5. NaN và so sánh =====
console.log("--- so sánh ---");
console.log(typeof NaN);         // number (!)
console.log(NaN === NaN);        // false -> dùng Number.isNaN()
console.log(Number.isNaN(NaN));  // true
console.log(5 == "5");           // true  (ép kiểu rồi so sánh)
console.log(5 === "5");          // false (so sánh cả kiểu) <-- luôn dùng ===

// ===== 6. Falsy values (các giá trị coi là false) =====
// false, 0, "", null, undefined, NaN
console.log("--- falsy ---");
console.log(Boolean(""), Boolean(null), Boolean(undefined), Boolean(NaN)); // tất cả false
console.log(Boolean("0"), Boolean([]), Boolean({})); // tất cả true (bất ngờ!)