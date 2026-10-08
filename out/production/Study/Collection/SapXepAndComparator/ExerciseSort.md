# Bài tập Phần 4 — SẮP XẾP & COMPARATOR

## Bài 1 — Sắp xếp cơ bản

Cho `List<Integer> nums = [5, 3, 8, 1, 9]` và `List<String> names = ["chi", "an", "binh"]`.

In ra:
1. `nums` tăng dần
2. `nums` giảm dần
3. `names` theo A→Z
4. `names` theo Z→A

---

## Bài 2 — Giữ nguyên list gốc

Viết hàm `public static List<Integer> sortedCopy(List<Integer> input)` trả về bản **đã sắp xếp** tăng dần, list gốc không bị thay đổi.

```
input  = [5, 3, 8]
output = [3, 5, 8]
input sau khi gọi hàm vẫn là [5, 3, 8]
```

---

## Bài 3 — Class Student với Comparable

Tạo class `Student` có `id` (int), `name` (String), `cgpa` (double). Cho `Student` sắp theo **id tăng dần** làm thứ tự mặc định.

Tạo list 4 sinh viên, `Collections.sort`, in ra theo định dạng `id name cgpa`.

---

## Bài 4 — Comparator nhiều tiêu chí

Vẫn dùng list ở Bài 3. Không sửa class `Student`, dùng Comparator để sắp theo:
- **cgpa giảm dần**
- cgpa bằng nhau → **tên A→Z**
- tên cũng bằng nhau → **id tăng dần**

Dữ liệu thử (cố tình có điểm trùng và tên trùng):
```
3  binh  3.5
1  an    3.9
4  an    3.5
2  chi   3.5
```

**Kết quả mong đợi**
```
1 an 3.9
4 an 3.5
3 binh 3.5
2 chi 3.5
```

---

## Bài 5 — Sắp Map theo value

Dùng lại Map đếm từ ở Phần 3 với câu `"the cat and the dog and the bird"`.

In các từ theo **số lần giảm dần**, mỗi dòng một từ:
```
the = 3
and = 2
...
```

---

## Bài 6 — Top N

Viết hàm `public static List<String> topWords(String sentence, int n)` trả về `n` từ xuất hiện nhiều nhất.

```
topWords("the cat and the dog and the bird", 2)  →  [the, and]
```

---

## Bài 7 — HackerRank: Java Sort

Sắp danh sách sinh viên theo: cgpa giảm dần → tên A→Z → id tăng dần. In tên từng sinh viên.

---

## Bài 8 — HackerRank: Java Comparator

Sắp danh sách người chơi theo: điểm giảm dần → tên A→Z. Viết một class `Checker` implements `Comparator<Player>`.
