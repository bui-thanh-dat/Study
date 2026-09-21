# HackerRank — Java Hashset

Link: https://www.hackerrank.com/challenges/java-hashset/problem
Subdomain: Java › Data Structures

## Đề bài

**Set** (tập hợp) lưu các giá trị không theo thứ tự cụ thể và không có giá trị lặp lại. Ví dụ `{1, 2, 3}` là một set, còn `{1, 2, 2}` thì không.

Cho `T` cặp chuỗi. Hai cặp `(a, b)` và `(c, d)` được coi là **giống nhau** khi `a = c` **và** `b = d`. Như vậy `(a, b)` **khác** `(b, a)`.

Sau khi nhận **mỗi** cặp, in ra số cặp **khác nhau** đang có tính đến thời điểm đó.

## Input

- Dòng đầu: số nguyên `T` — số lượng cặp
- `T` dòng tiếp theo: mỗi dòng gồm hai chuỗi cách nhau bởi một dấu cách

## Ràng buộc

- `1 ≤ T ≤ 100000`
- Mỗi chuỗi dài tối đa 5 ký tự, chỉ gồm chữ thường

## Output

In `T` dòng. Dòng thứ `i` là số cặp khác nhau sau khi đã nhận cặp thứ `i`.

## Ví dụ

**Input**
```
5
john tom
john mary
john tom
mary anna
mary anna
```

**Output**
```
1
2
2
3
3
```

**Giải thích**
1. Sau cặp 1: có 1 cặp — (john, tom)
2. Sau cặp 2: có 2 cặp — (john, tom), (john, mary)
3. Sau cặp 3: (john, tom) đã có → vẫn 2 cặp
4. Sau cặp 4: có 3 cặp — thêm (mary, anna)
5. Sau cặp 5: (mary, anna) đã có → vẫn 3 cặp

## Code khởi tạo (HackerRank cho sẵn)

```java
import java.io.*;
import java.util.*;

public class Solution {
    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        int t = s.nextInt();
        String[] pair_left = new String[t];
        String[] pair_right = new String[t];

        for (int i = 0; i < t; i++) {
            pair_left[i] = s.next();
            pair_right[i] = s.next();
        }

        // Write your code here
    }
}
```

## Ghi chú

- **Test case 5 bị lỗi phía HackerRank**: test này ngầm coi `(a, b)` và `(b, a)` là trùng, trái với đề. Lời giải đúng theo đề sẽ fail đúng 1 test này — không cần sửa code để lách.
- Điểm mấu chốt: biến mỗi cặp thành **một chuỗi** có **dấu phân cách** ở giữa, để `("ab", "c")` và `("a", "bc")` không bị coi là trùng.
