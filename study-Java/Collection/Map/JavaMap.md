# HackerRank — Java Map

Link: https://www.hackerrank.com/challenges/phone-book/problem
Subdomain: Java › Data Structures

## Đề bài

Cho một danh bạ điện thoại gồm tên và số điện thoại của mọi người. Sau đó nhận tên của một số người dưới dạng truy vấn. Với mỗi truy vấn, in số điện thoại của người đó.

## Input

- Dòng đầu: số nguyên `n` — số mục trong danh bạ
- Mỗi mục gồm **hai dòng**: tên, rồi số điện thoại
- Sau đó là các truy vấn, mỗi truy vấn một dòng chứa tên. **Đọc đến hết input** (không biết trước số lượng)

## Ràng buộc

- Tên chỉ gồm chữ cái tiếng Anh viết thường, dạng `tên` hoặc `họ tên` (có thể có dấu cách)
- Số điện thoại có đúng 8 chữ số, không có số 0 đứng đầu
- `1 ≤ n ≤ 100000`
- `1 ≤ số truy vấn ≤ 100000`

## Output

Với mỗi truy vấn:
- Có trong danh bạ → in `ten=so`
- Không có → in `Not found`

## Ví dụ

**Input**
```
3
uncle sam
99912222
tom
11122222
harry
12299933
uncle sam
uncle tom
harry
```

**Output**
```
uncle sam=99912222
Not found
harry=12299933
```

**Giải thích**
- `uncle sam` có trong danh bạ → in tên và số
- `uncle tom` không có (danh bạ chỉ có `tom`, Map so khớp chính xác cả chuỗi) → `Not found`
- `harry` có → in tên và số

## Code khởi tạo (HackerRank cho sẵn)

```java
import java.util.*;
import java.io.*;

class Solution {
    public static void main(String[] argh) {
        Scanner in = new Scanner(System.in);
        int n = in.nextInt();
        in.nextLine();
        for (int i = 0; i < n; i++) {
            String name = in.nextLine();
            int phone = in.nextInt();
            in.nextLine();
        }
        while (in.hasNext()) {
            String s = in.nextLine();
        }
    }
}
```

## Ghi chú

- **Không xoá các dòng `in.nextLine();` đứng một mình.** `nextInt()` chỉ đọc con số, để lại dấu xuống dòng; `nextLine()` phía sau dùng để bỏ phần còn lại của dòng đó. Thiếu nó thì lần đọc tên tiếp theo sẽ ra chuỗi rỗng.
- Tên đọc bằng `nextLine()` (không phải `next()`) vì tên có thể chứa dấu cách.
- Định dạng in: `ten=so`, không có dấu cách quanh `=`.
