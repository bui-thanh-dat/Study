# Bài tập Phần 2 — SET

## Bài 1 — Ba loại Set

Cho `List<Integer> nums = [5, 3, 8, 3, 1, 8]`. In ra:
1. Số giá trị khác nhau
2. Danh sách đã loại trùng, **giữ thứ tự ban đầu**
3. Danh sách đã loại trùng, **sắp xếp tăng dần**

**Kết quả mong đợi**
```
4
[5, 3, 8, 1]
[1, 3, 5, 8]
```

---

## Bài 2 — Số lặp lại đầu tiên

Viết hàm `public static Integer firstDuplicate(List<Integer> input)` trả về số đầu tiên bị lặp lại. Không có thì trả về `null`.

```
[2, 5, 1, 5, 2]  →  5
[1, 2, 3]        →  null
```

---

## Bài 3 — Giao, hợp, hiệu

Cho `a = [1, 2, 3, 4, 5]` và `b = [4, 5, 6, 7]`. In ra phần tử chung, hợp của hai tập, và phần tử chỉ có ở `a`. Cuối cùng in lại `a` và `b` để chứng minh chúng không bị thay đổi.

**Kết quả mong đợi**
```
Giao:  [4, 5]
Hợp:   [1, 2, 3, 4, 5, 6, 7]
Hiệu:  [1, 2, 3]
a:     [1, 2, 3, 4, 5]
b:     [4, 5, 6, 7]
```

---

## Bài 4 — Đếm từ khác nhau

Viết hàm `public static int countDistinctWords(String sentence)`.

```
"the cat and the dog and the bird"  →  5
```

**Mở rộng:** `"The the THE cat"` phải ra `2`.

---

## Bài 5 — HackerRank: Java Hashset

Nhập `t` cặp chuỗi (trái, phải). Sau mỗi cặp, in số cặp **khác nhau** đã gặp đến lúc đó.

```
Input          Output
5
john tom       1
john mary      2
john tom       2
mary anna      3
mary anna      3
```
