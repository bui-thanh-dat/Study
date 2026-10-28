# HackerRank — Java Stack

Link: https://www.hackerrank.com/challenges/java-stack/problem
Subdomain: Java › Data Structures — Medium, 20 điểm

## Đề bài

Cho các chuỗi chỉ gồm các ký tự ngoặc `{`, `}`, `(`, `)`, `[`, `]`. Với mỗi chuỗi, kiểm tra xem các ngoặc có **cân bằng** không.

Một chuỗi cân bằng khi mọi ngoặc mở đều có ngoặc đóng tương ứng, và thứ tự lồng nhau đúng.

## Input

Mỗi dòng là một chuỗi ngoặc. Đọc đến hết input (không biết trước số dòng).

## Output

Với mỗi chuỗi, in `true` nếu cân bằng, `false` nếu không.

## Ví dụ

**Input**
```
{}()
({()})
{}(
[]
```

**Output**
```
true
true
false
true
```

## Ý tưởng — vì sao dùng Stack

Ngoặc lồng nhau tuân theo quy tắc **vào sau ra trước**: ngoặc mở sau phải được đóng trước. Đó đúng là hành vi của stack.

Stack chứa **những ngoặc mở đang chờ được đóng**.

Chạy tay `"{[()]}"`:

| Ký tự | Hành động | Stack sau |
|---|---|---|
| `{` | push | `{` |
| `[` | push | `[ {` |
| `(` | push | `( [ {` |
| `)` | pop ra `(` → khớp | `[ {` |
| `]` | pop ra `[` → khớp | `{` |
| `}` | pop ra `{` → khớp | rỗng |

Hết chuỗi, stack rỗng → **true**.

## Ba trường hợp KHÔNG hợp lệ

| # | Trường hợp | Ví dụ | Phát hiện ở đâu |
|---|---|---|---|
| 1 | pop ra ngoặc không khớp | `{[(])}` | trong vòng lặp |
| 2 | gặp ngoặc đóng khi stack rỗng (thừa ngoặc đóng) | `)(` | trong vòng lặp |
| 3 | hết chuỗi mà stack vẫn còn (thừa ngoặc mở) | `{[` | sau vòng lặp |

Trường hợp 2 **bắt buộc** phải kiểm tra `isEmpty()` trước khi `pop()`, nếu không sẽ ném `NoSuchElementException`.

Trường hợp 3 là lý do dòng cuối phải là `return stack.isEmpty()` chứ không phải `return true`.

## Khung thuật toán

```
tạo stack rỗng

với mỗi ký tự c trong chuỗi:
    nếu c là ngoặc MỞ:
        push c
    ngược lại:
        nếu stack rỗng:
            return false              ← Sai 2
        top = pop()
        nếu top không khớp với c:
            return false              ← Sai 1

return stack.isEmpty()                ← Sai 3
```

## Bộ test tự kiểm tra

| Chuỗi | Kết quả | Kiểm tra điều gì |
|---|---|---|
| `{[()]}` | true | lồng nhau nhiều tầng |
| `{[(])}` | false | Sai 1 — sai thứ tự lồng |
| `)(` | false | Sai 2 — thừa ngoặc đóng |
| `{[` | false | Sai 3 — thừa ngoặc mở |
| `()` | true | cơ bản |
| `[]{}()` | true | nhiều cặp nối tiếp |

## Ghi chú

- Dùng `ArrayDeque` thay cho class `Stack` cũ — `Stack` chậm và đã lỗi thời, tài liệu Java khuyên dùng `ArrayDeque`.
- `Deque<Character>` chứ không phải `Deque<char>` — Collection chỉ chứa object.
- So sánh ký tự dùng `==` với nháy đơn `'('`, không dùng `.equals()` với nháy kép `"("`.
- Mỗi chuỗi input cần một stack **rỗng mới** — đặt dòng tạo stack trong hàm `isBalanced` là tự động được vậy.
