# Bài tập Java - Giải mã tin nhắn

## Đề bài

Viết hàm:

```java
public static String decryptMessage(String encryptedMessage)
```

để giải mã một tin nhắn theo quy tắc sau.

### Quy tắc 1: Đảo thứ tự các từ

Tin nhắn được tạo thành từ nhiều từ, các từ cách nhau bởi một dấu cách.

Khi giải mã, **thứ tự các từ phải được đảo ngược**.

Ví dụ:

```text
"hello java world"
```

trở thành:

```text
"world java hello"
```

### Quy tắc 2: Giải mã từng từ

Trong mỗi từ, một chữ số đứng ngay sau một ký tự cho biết ký tự đó phải xuất hiện **tổng cộng bao nhiêu lần**.

Ví dụ:

```text
a3
```

có nghĩa là:

```text
aaa
```

Ví dụ:

```text
b2
```

có nghĩa là:

```text
bb
```

Nếu một từ có nhiều ký tự được mã hóa, hãy xử lý tất cả.

Ví dụ:

```text
a2b3
```

trở thành:

```text
aabbb
```

### Ví dụ hoàn chỉnh

Input:

```text
a2b3 hello c2d2
```

Sau khi giải mã từng từ:

```text
aabbb
hello
ccdd
```

Sau đó đảo thứ tự các từ:

```text
ccdd hello aabbb
```

Output:

```text
ccdd hello aabbb
```

---

## Yêu cầu

Hoàn thành hàm:

```java
public static String decryptMessage(String encryptedMessage)
```

Hàm phải:

1. Tách chuỗi thành các từ bằng `split(" ")`.
2. Duyệt các từ từ cuối về đầu.
3. Duyệt từng ký tự trong mỗi từ bằng `charAt()`.
4. Nếu gặp chữ cái, thêm nó vào kết quả.
5. Nếu gặp chữ số:
   - Chuyển chữ số từ `char` sang `int`.
   - Lấy ký tự ngay trước nó.
   - Thêm ký tự đó đủ số lần còn thiếu.
6. Dùng `StringBuilder` để xây dựng kết quả.
7. Trả về kết quả bằng `toString()`.

---

## Ví dụ 1

### Input

```text
a3 b2 c4
```

### Output

```text
cccc bb aaa
```

---

## Ví dụ 2

### Input

```text
h2e2l3 world
```

### Output

```text
world hheelll
```

---

## Ví dụ 3

### Input

```text
a2b2 cat d3e2
```

### Output

```text
dddee cat aabb
```

---

## Ràng buộc

- `1 <= encryptedMessage.length() <= 1000`
- Tin nhắn chỉ chứa chữ cái tiếng Anh, chữ số từ `1` đến `9` và dấu cách.
- Mỗi chữ số luôn đứng sau một chữ cái.
- Không có hai chữ số liên tiếp.
- Không cần xử lý số có nhiều chữ số như `10`, `12`, `25`.

---

## Gợi ý

Bạn có thể sử dụng:

```java
String[] words = encryptedMessage.split(" ");
```

Để duyệt từ cuối về đầu:

```java
for (int i = words.length - 1; i >= 0; i--) {

}
```

Để lấy từng ký tự:

```java
char ch = word.charAt(j);
```

Kiểm tra chữ số:

```java
Character.isDigit(ch)
```

Chuyển `'3'` thành `3`:

```java
int count = ch - '0';
```

Xây dựng chuỗi:

```java
StringBuilder result = new StringBuilder();
result.append(ch);
```

---

## Mục tiêu luyện tập

Bài này tập trung vào:

- `String`
- `split()`
- `length()`
- `charAt()`
- `Character.isDigit()`
- `StringBuilder`
- `append()`
- `toString()`
- vòng lặp `for`
- duyệt mảng từ cuối về đầu
- xử lý `char` và `int`

**Không xem đáp án ngay. Hãy tự viết hàm `decryptMessage()` trước.**

Con người học lập trình bằng cách tự vật lộn với vòng `for`, một truyền thống đáng tiếc nhưng khá hiệu quả.
