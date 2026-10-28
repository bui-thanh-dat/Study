const [x, x2, ...y] = [1,2,3,4];
console.log(x,x2,y);

const a = [1,2,3,4];
const b = [1,2,3,...a];
// const b = a;

b.push("hello");
console.log(a,b);

// Bỏ qua phần tử: dùng dấu phẩy trống để nhảy qua vị trí không cần lấy
const [first, , third] = [10, 20, 30];
console.log(first, third); // 10 30

// Giá trị mặc định: áp dụng khi phần tử ở vị trí đó là undefined (thiếu hoặc không có)
const [p1, p2, p3 = 99] = [1, 2];
console.log(p1, p2, p3); // 1 2 99

// Hoán đổi giá trị không cần biến tạm
let m = 1, n = 2;
[m, n] = [n, m];
console.log(m, n); // 2 1

// Destructuring ngay trong tham số hàm
function sumFirstTwo([v1, v2]) {
  return v1 + v2;
}
console.log(sumFirstTwo([5, 7])); // 12

// Spread khi truyền tham số hàm: "trải" các phần tử array thành từng argument riêng
console.log(Math.max(...a)); // tương đương Math.max(1,2,3,4,...)
// console.log(Math.max(a)); // NaN, vì Math.max không nhận cả array làm 1 argument

// Nested array destructuring: destructuring theo đúng cấu trúc lồng nhau
const [q1, [q2, q3]] = [1, [2, 3]];
console.log(q1, q2, q3); // 1 2 3