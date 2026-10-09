# Tổng hợp: Datatypes và so sánh trong JavaScript

## 1. Các kiểu dữ liệu

**Primitive (nguyên thủy):** lưu trực tiếp giá trị.

| Kiểu | Ví dụ | Ghi chú |
|---|---|---|
| `number` | `21`, `19.99` | Không phân biệt int/float |
| `string` | `"Dat"` | |
| `boolean` | `true`, `false` | |
| `undefined` | `let x;` | Khai báo nhưng chưa gán |
| `null` | `null` | Cố ý "không có giá trị" |
| `bigint` | `123n` | Số rất lớn |
| `symbol` | `Symbol("id")` | Giá trị duy nhất |

**Reference (tham chiếu):** object, array, function.

**Cần nhớ khi dùng `typeof`:**

- `typeof null` ra `"object"` (lỗi lịch sử, null không phải object)
- `typeof NaN` ra `"number"`
- Kiểm tra mảng dùng `Array.isArray(x)`, vì `typeof []` ra `"object"`

## 2. Primitive copy giá trị, object chia sẻ tham chiếu

```js
let a = 10; let b = a; b = 20;   // a vẫn 10

const o1 = { x: 1 }; const o2 = o1; o2.x = 99;  // o1.x cũng thành 99
```

Đây là nguồn gốc của rất nhiều bug.

## 3. `==` và `===`

- `===`: so sánh cả giá trị lẫn kiểu, **không ép kiểu**.
- `==`: ép kiểu theo luật riêng, nhiều ngoại lệ.

**Quy tắc: mặc định luôn dùng `===`.**

| Biểu thức | Kết quả | Lý do |
|---|---|---|
| `"5" == 5` | `true` | Chuỗi được ép sang số |
| `[] == false` | `true` | `false`→0, `[]`→`""`→0 |
| `null == undefined` | `true` | Luật riêng: chỉ bằng nhau, không bằng gì khác |

## 4. Hai ngoại lệ của `===`

- **`NaN === NaN` là `false`**. Kiểm tra NaN bằng `Number.isNaN(x)`.
- **`[] === []` là `false`**. Object so sánh theo địa chỉ bộ nhớ, không theo nội dung. Hai mảng riêng biệt luôn khác nhau dù cùng nội dung.

```js
const a = [];
const b = [];
const c = a;

console.log(a === b); // false
console.log(a === c); // true
```

## 5. Ép kiểu với toán tử

| Biểu thức | Kết quả | Lý do |
|---|---|---|
| `"10" + 5` | `"105"` | `+` gặp chuỗi thì nối chuỗi |
| `"10" * 2` | `20` | `*` chỉ làm với số nên ép sang số |
| `Number("abc")` | `NaN` | Không chuyển được |
| `Number("")` | `0` | Chuỗi rỗng thành 0, nhớ kiểm tra `trim() === ""` |

Input từ `prompt-sync` luôn là **string**, nên phải `Number()` trước khi tính.

## 6. Falsy và truthy

**Falsy (6 giá trị):** `false`, `0`, `""`, `null`, `undefined`, `NaN`.

**Mọi thứ khác là truthy**, kể cả `"0"`, `[]`, `{}`.

Lưu ý: `Boolean([])` là `true` nhưng `[] == false` cũng là `true`. Hai cái dùng hai đường ép kiểu khác nhau.

## 7. Điểm cần luyện lại

Gốc chung của các câu đoán sai: dựa vào trực giác "trông giống nhau thì bằng nhau".

1. `==` ép kiểu, `===` không.
2. `NaN` không bằng chính nó.
3. Object so sánh theo tham chiếu.

## 8. Bài tập còn treo

Viết hàm so sánh nội dung hai mảng `[1, 2, 3]` và `[1, 2, 3]` bằng hai cách:

1. `JSON.stringify`
2. So sánh từng phần tử

Sau đó tìm xem `JSON.stringify` bị lỗi ở trường hợp nào.
