# Bài tập Phần 3 — MAP

## Bài 1 — Danh bạ cơ bản

Tạo `Map<String, String>` lưu tên → số điện thoại. Thực hiện lần lượt và in kết quả sau mỗi bước:
1. Thêm: An → 0901, Binh → 0902, Chi → 0903
2. In số của Binh
3. Đổi số của An thành 0999
4. Xoá Chi
5. Kiểm tra "Chi" còn trong danh bạ không
6. In số của "Dung" — nếu không có thì in `Not found`

**Kết quả mong đợi** (thứ tự in Map có thể khác)
```
{An=0901, Binh=0902, Chi=0903}
0902
{An=0999, Binh=0902, Chi=0903}
{An=0999, Binh=0902}
false
Not found
```

---

## Bài 2 — Đếm tần suất số

Cho `List<Integer> nums = [5, 3, 8, 3, 1, 8, 3]`. Đếm số lần xuất hiện của mỗi số. In theo **thứ tự xuất hiện đầu tiên**.

**Kết quả mong đợi**
```
{5=1, 3=3, 8=2, 1=1}
```

---

## Bài 3 — Đếm ký tự

Cho chuỗi `"hello world"`. Đếm số lần xuất hiện của mỗi ký tự, **bỏ qua dấu cách**. In theo **thứ tự bảng chữ cái**.

**Kết quả mong đợi**
```
{d=1, e=1, h=1, l=3, o=2, r=1, w=1}
```

---

## Bài 4 — Từ xuất hiện nhiều nhất

Viết hàm `public static String mostFrequentWord(String sentence)`.

```
"the cat and the dog and the bird"  →  "the"
```

---

## Bài 5 — In từng dòng

Dùng Map đếm được ở Bài 2, in mỗi cặp trên một dòng theo định dạng:

```
5 xuat hien 1 lan
3 xuat hien 3 lan
8 xuat hien 2 lan
1 xuat hien 1 lan
```

---

## Bài 6 (nâng cao) — Nhóm theo độ dài

Cho `["an", "binh", "chi", "dung", "ha", "khoa"]`. Nhóm các từ theo độ dài, dùng `Map<Integer, List<String>>`, key sắp xếp tăng dần.

**Kết quả mong đợi**
```
{2=[an, ha], 3=[chi], 4=[binh, dung, khoa]}
```

---

## Bài 7 — HackerRank: Java Map

Danh bạ điện thoại: nhập `n` mục (tên và số), sau đó nhận các truy vấn tên cho đến hết input. Với mỗi truy vấn, in `ten=so` nếu tìm thấy, ngược lại in `Not found`.
