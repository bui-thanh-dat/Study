package Collection.List;

import java.util.*;


public class DuyetList {
    public static void main(String[] args) {
        List<String> names = new ArrayList<>(List.of("Hien", "Danh", "Dat"));

        // Cách 1: for-each — dùng khi chỉ cần đọc giá trị (dùng nhiều nhất)
        for(String n : names){
            System.out.println(n);
        }

        // Cách 2: for có index — dùng khi cần biết vị trí hoặc cần sửa
        for (int i = 0; i < names.size(); i++){
            System.out.println(i + ": "+names.get(i));
        }
        // Cách 3: forEach + lambda (Java 8+)
        names.forEach(n -> System.out.println(n));

        /*
        1.5 Ba cái bẫy
        Bẫy 1 — remove(int) và remove(Object) với List<Integer> */

        List<Integer> nums = new ArrayList<>(List.of(10,20,30));

        nums.remove(1);  // xoá INDEX 1 → [10, 30]
        System.out.println(nums);

        nums.remove(Integer.valueOf(10));  // xoá GIÁ TRỊ 10 → [30]
        System.out.println(nums);

    // Bẫy 2 — xoá phần tử trong lúc for-each
        List<Integer> numbers = new ArrayList<>(List.of(1,-2,3, -4));

        for(Integer n : numbers){
//            if(n < 0 ) numbers.remove(n); //    ConcurrentModificationException
        }

        numbers.removeIf( n -> n < 0); // ✅ ngắn gọn nhất (Java 8+)

//        Iterator<Integer> it = numbers.iterator();
//        while(it.hasNext()){
//            if(it.next() < 0 ){
//                it.remove();
//            }
//        }
        System.out.println(numbers);

        // Bẫy 3 — List.of() là danh sách bất biến
//        List<String> a = List.of("Hien", "Danh", "Dat");
//        a.add("Ngoc");// ❌ UnsupportedOperationException

        List<String> b = new ArrayList<>(List.of("Hien", "Danh", "Dat"));
        b.add("Ngoc");
        System.out.println(b);

// 1.6 Vài hàm tiện ích hay dùng
        List<Integer> c = new ArrayList<>(List.of(3,5,7,1,5,8,6));

        Collections.sort(c);
        System.out.println(c); // [1, 3, 5, 5, 6, 7, 8]

        Collections.reverse(c);
        System.out.println(c); // [8, 7, 6, 5, 5, 3, 1]

        System.out.println(Collections.max(c)); // 8
        System.out.println(Collections.min(c)); // 1

    }
}
