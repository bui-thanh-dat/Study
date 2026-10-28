// ============================================================
// MẢNG (ARRAY) TRONG JAVASCRIPT
// Mục lục:
//  1. Tạo mảng
//  2. Truy cập và sửa phần tử
//  3. length
//  4. Thêm / xóa ở đầu và cuối: push, pop, unshift, shift
//  5. Cắt và chèn ở giữa: slice, splice
//  6. Tìm kiếm: indexOf, includes, find, findIndex
//  7. Nối, chuyển đổi: concat, spread, join, split, reverse
//  8. Sắp xếp: sort
//  9. Duyệt mảng: for, for...of, forEach
// 10. map, filter, reduce
// 11. some, every
// 12. Mảng là kiểu tham chiếu: sao chép
// 13. Một số tiện ích khác
// ============================================================

// ===== 1. TẠO MẢNG =====
const fruits = ["táo", "cam", "xoài"];       // cách phổ biến nhất
const mixed = [1, "a", true, null];          // JS cho phép trộn nhiều kiểu
const empty = [];                            // mảng rỗng
const fiveSlots = new Array(5);              // 5 ô trống (chưa có giá trị)
console.log(fiveSlots.length);               // 5
console.log(fiveSlots[2]);                   // undefined
console.log(Array.from("hello"));            // ["h","e","l","l","o"] (từ chuỗi)
console.log(Array.from({ length: 3 }, (_, i) => i * 2)); // [0, 2, 4]
console.log(Array.of(7, 8, 9));              // [7, 8, 9]
console.log(Array.isArray(fruits));          // true (kiểm tra có phải mảng)
console.log(typeof fruits);                  // "object" <-- typeof không phân biệt được

// ===== 2. TRUY CẬP VÀ SỬA PHẦN TỬ =====
// Chỉ số (index) bắt đầu từ 0.
const colors = ["đỏ", "xanh", "vàng", "tím"];
console.log(colors[0]);                      // "đỏ"
console.log(colors[3]);                      // "tím"
console.log(colors[10]);                     // undefined (không báo lỗi)
console.log(colors.at(-1));                  // "tím" (at nhận số âm: đếm từ cuối)
console.log(colors[colors.length - 1]);      // "tím" (cách cũ để lấy phần tử cuối)

colors[1] = "lam";                           // sửa phần tử
console.log(colors);                         // ["đỏ","lam","vàng","tím"]

// const chỉ cấm gán lại biến, KHÔNG cấm sửa nội dung mảng
// colors = [];                              // lỗi: Assignment to constant variable
colors[0] = "hồng";                          // vẫn được

// ===== 3. LENGTH =====
const nums = [10, 20, 30];
console.log(nums.length);                    // 3

nums[5] = 60;                                // gán vào vị trí xa -> tạo "lỗ hổng"
console.log(nums);                           // [10,20,30, <2 empty items>, 60]
console.log(nums.length);                    // 6 (length = chỉ số lớn nhất + 1)

nums.length = 2;                             // gán length nhỏ lại -> cắt bớt mảng
console.log(nums);                           // [10, 20]

// ===== 4. THÊM / XÓA Ở ĐẦU VÀ CUỐI =====
//           push ->   [ ... ]   <- pop        (cuối)
//        unshift ->   [ ... ]   <- shift      (đầu)
// Cả 4 hàm đều SỬA TRỰC TIẾP mảng gốc.
const list = ["b", "c"];

console.log(list.push("d"));                 // 3 (trả về length mới)
list.push("e", "f");                         // thêm được nhiều phần tử
console.log(list);                           // ["b","c","d","e","f"]

console.log(list.pop());                     // "f" (trả về phần tử bị xóa)
console.log(list);                           // ["b","c","d","e"]

console.log(list.unshift("a"));              // 5 (trả về length mới)
console.log(list);                           // ["a","b","c","d","e"]

console.log(list.shift());                   // "a" (trả về phần tử bị xóa)
console.log(list);                           // ["b","c","d","e"]

console.log([].pop());                       // undefined (mảng rỗng, không lỗi)

// Lưu ý hiệu năng: shift/unshift phải dời toàn bộ phần tử, chậm hơn push/pop.

// ===== 5. CẮT VÀ CHÈN Ở GIỮA: slice VÀ splice =====
// ---- slice(start, end): LẤY một đoạn, KHÔNG sửa mảng gốc ----
// start được lấy, end KHÔNG được lấy.
const arr = [10, 20, 30, 40, 50];
//  index:    0   1   2   3   4
console.log(arr.slice(1, 3));                // [20, 30]
console.log(arr.slice(2));                   // [30, 40, 50]
console.log(arr.slice(-2));                  // [40, 50]
console.log(arr.slice(1, -1));               // [20, 30, 40]
console.log(arr.slice());                    // bản sao của cả mảng
console.log(arr);                            // [10,20,30,40,50] không đổi

// ---- splice(start, deleteCount, ...items): XÓA/CHÈN/THAY, SỬA mảng gốc ----
const sp = ["a", "b", "c", "d", "e"];

console.log(sp.splice(1, 2));                // ["b","c"] (trả về phần tử bị xóa)
console.log(sp);                             // ["a","d","e"]

sp.splice(1, 0, "X", "Y");                   // chèn tại index 1, xóa 0 phần tử
console.log(sp);                             // ["a","X","Y","d","e"]

sp.splice(2, 1, "Z");                        // thay 1 phần tử tại index 2
console.log(sp);                             // ["a","X","Z","d","e"]

sp.splice(-1, 1);                            // xóa phần tử cuối (số âm đếm từ cuối)
console.log(sp);                             // ["a","X","Z","d"]

// Nhớ: SLICE = cắt ra (không sửa), SPLICE = nối/ghép tại chỗ (có sửa).

// ===== 6. TÌM KIẾM =====
const items = ["a", "b", "c", "b", "d"];
console.log(items.indexOf("b"));             // 1  (vị trí đầu tiên)
console.log(items.lastIndexOf("b"));         // 3  (vị trí cuối cùng)
console.log(items.indexOf("z"));             // -1 (không tìm thấy)
console.log(items.includes("c"));            // true
console.log(items.includes("z"));            // false

// indexOf dùng === nên không ép kiểu
console.log([1, 2, 3].indexOf("2"));         // -1 ("2" khác 2)

// Tìm theo điều kiện: truyền vào một hàm
const ages = [12, 17, 21, 30];
console.log(ages.find((x) => x >= 18));      // 21 (phần tử đầu tiên thỏa)
console.log(ages.findIndex((x) => x >= 18)); // 2  (vị trí của nó)
console.log(ages.find((x) => x > 100));      // undefined (không có)
console.log(ages.findIndex((x) => x > 100)); // -1

// ===== 7. NỐI, CHUYỂN ĐỔI =====
const a1 = [1, 2];
const a2 = [3, 4];
console.log(a1.concat(a2));                  // [1,2,3,4] (mảng mới, không sửa a1)
console.log([...a1, ...a2]);                 // [1,2,3,4] (spread: cách hiện đại)
console.log([0, ...a1, 99, ...a2]);          // [0,1,2,99,3,4] (chèn thêm phần tử lẻ)

// join: mảng -> chuỗi
console.log(["a", "b", "c"].join("-"));      // "a-b-c"
console.log(["a", "b", "c"].join(""));       // "abc"
console.log([1, 2, 3].join());               // "1,2,3" (mặc định dấu phẩy)

// split: chuỗi -> mảng (là hàm của chuỗi, đối ngẫu của join)
console.log("a,b,c".split(","));             // ["a","b","c"]
console.log("hello".split(""));              // ["h","e","l","l","o"]

// reverse: đảo ngược, SỬA mảng gốc
const rev = [1, 2, 3];
rev.reverse();
console.log(rev);                            // [3,2,1]

// ===== 8. SẮP XẾP: sort =====
// sort SỬA mảng gốc. Mặc định sắp xếp theo CHUỖI (thứ tự bảng mã).
console.log(["c", "a", "b"].sort());         // ["a","b","c"]

// BẪY: sort số mà không có hàm so sánh
console.log([10, 9, 1, 100].sort());         // [1, 10, 100, 9] <-- sai ý! ("10" < "9" khi so chuỗi)

// Cách đúng: truyền hàm so sánh (a, b)
//  - trả về số ÂM  -> a đứng trước b
//  - trả về số DƯƠNG -> b đứng trước a
//  - trả về 0 -> giữ nguyên
console.log([10, 9, 1, 100].sort((a, b) => a - b));  // [1, 9, 10, 100] tăng dần
console.log([10, 9, 1, 100].sort((a, b) => b - a));  // [100, 10, 9, 1] giảm dần

// Sắp xếp object theo một thuộc tính
const people = [
  { name: "An", age: 30 },
  { name: "Bình", age: 20 },
  { name: "Chi", age: 25 },
];
people.sort((p, q) => p.age - q.age);
console.log(people.map((p) => p.name));      // ["Bình","Chi","An"]

// Muốn không sửa mảng gốc: sao chép trước rồi mới sort
const original = [3, 1, 2];
const sorted = [...original].sort((a, b) => a - b);
console.log(original);                       // [3,1,2] không đổi
console.log(sorted);                         // [1,2,3]

// ===== 9. DUYỆT MẢNG =====
const pets = ["chó", "mèo", "chim"];

// 9.1 for kinh điển: khi cần chỉ số hoặc cần dừng giữa chừng (break)
for (let i = 0; i < pets.length; i++) {
  console.log(i, pets[i]);                   // 0 chó / 1 mèo / 2 chim
}

// 9.2 for...of: lấy từng GIÁ TRỊ, gọn nhất
for (const pet of pets) {
  console.log(pet);                          // chó / mèo / chim
}

// 9.3 for...of kèm index bằng entries()
for (const [i, pet] of pets.entries()) {
  console.log(i, pet);
}

// 9.4 forEach: gọi hàm cho từng phần tử (không dùng được break)
pets.forEach((pet, i) => {
  console.log(`${i + 1}. ${pet}`);           // 1. chó / 2. mèo / 3. chim
});

// Lưu ý: for...in duyệt CHỈ SỐ (dạng chuỗi), không nên dùng cho mảng
for (const idx in pets) {
  console.log(idx, typeof idx);              // "0" string ...
}

// ===== 10. map, filter, reduce =====
// Cả ba đều trả về kết quả MỚI, không sửa mảng gốc.
const prices = [100, 200, 300, 400];

// map: biến đổi từng phần tử -> mảng MỚI cùng độ dài
console.log(prices.map((p) => p * 2));       // [200,400,600,800]
console.log(prices.map((p) => `${p}đ`));     // ["100đ","200đ","300đ","400đ"]

// filter: giữ phần tử thỏa điều kiện -> mảng MỚI (có thể ngắn hơn)
console.log(prices.filter((p) => p > 150));  // [200,300,400]
console.log(prices.filter((p) => p > 999));  // []

// reduce: gom cả mảng thành MỘT giá trị
// reduce((tích lũy, phần tử) => ..., giá trị khởi đầu)
console.log(prices.reduce((sum, p) => sum + p, 0));          // 1000
console.log(prices.reduce((max, p) => (p > max ? p : max))); // 400 (không có giá trị khởi đầu: lấy phần tử đầu)

// Xâu chuỗi các hàm: tổng giá của những món trên 150
const total = prices
  .filter((p) => p > 150)
  .reduce((sum, p) => sum + p, 0);
console.log(total);                          // 900

// ===== 11. some, every =====
const scores = [5, 8, 9];
console.log(scores.some((s) => s >= 9));     // true  (có ÍT NHẤT MỘT phần tử thỏa)
console.log(scores.every((s) => s >= 5));    // true  (TẤT CẢ phần tử đều thỏa)
console.log(scores.every((s) => s >= 8));    // false
console.log([].some((s) => s > 0));          // false (mảng rỗng)
console.log([].every((s) => s > 0));         // true  (mảng rỗng: "thỏa với mọi phần tử" là đúng theo logic)

// ===== 12. MẢNG LÀ KIỂU THAM CHIẾU =====
// Gán mảng KHÔNG sao chép, mà chỉ cho hai biến cùng trỏ về một mảng.
const x = [1, 2, 3];
const y = x;                                 // y trỏ cùng mảng với x
y.push(4);
console.log(x);                              // [1,2,3,4] <-- x cũng đổi!
console.log(x === y);                        // true

// Sao chép thật sự (shallow copy)
const z = [...x];                            // hoặc x.slice() hoặc Array.from(x)
z.push(5);
console.log(x);                              // [1,2,3,4] không đổi
console.log(z);                              // [1,2,3,4,5]

// So sánh mảng bằng === là so sánh THAM CHIẾU, không so sánh nội dung
console.log([1, 2] === [1, 2]);              // false (hai mảng khác nhau)

// Shallow copy: phần tử là mảng/object vẫn dùng chung
const nested = [[1], [2]];
const copy = [...nested];
copy[0].push(99);
console.log(nested);                         // [[1,99],[2]] <-- bị ảnh hưởng

// ===== 13. MỘT SỐ TIỆN ÍCH KHÁC =====
// Mảng lồng nhau -> làm phẳng
console.log([1, [2, [3, [4]]]].flat());      // [1, 2, [3, [4]]]
console.log([1, [2, [3, [4]]]].flat(Infinity)); // [1,2,3,4]

// Loại trùng lặp bằng Set
console.log([...new Set([1, 2, 2, 3, 3, 3])]); // [1,2,3]

// Điền giá trị
console.log(new Array(3).fill(0));           // [0,0,0]

// Destructuring: tách phần tử ra biến
const [first, second, ...rest] = [10, 20, 30, 40];
console.log(first, second, rest);            // 10 20 [30,40]

// Hoán đổi hai biến
let p = 1, q = 2;
[p, q] = [q, p];
console.log(p, q);                           // 2 1

// Math.max / Math.min với mảng: dùng spread
console.log(Math.max(...[3, 9, 4]));         // 9
