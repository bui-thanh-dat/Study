package Collection.List;

import java.util.*;

public class Exercise_List {
    public static void main(String[] args) {
        // Bài 1. Tạo List<String> chứa 5 tên. In ra danh sách, kích thước, tên đầu tiên, tên cuối cùng.
        ArrayList<String> list = new ArrayList<>(List.of("Dat","Oanh","Hieu","Ngoc","Linh"));

        for(String s: list){
            System.out.println(s);
        }

        System.out.println(list.size());

        System.out.println(list.get(0));
        System.out.println(list.get(4));

        /* Bài 2. Cho List<Integer> chứa [5, 3, 8, 3, 1, 8]:

        In tổng và trung bình cộng
        In phần tử lớn nhất (tự viết vòng lặp, không dùng Collections.max)
        Đếm xem số 3 xuất hiện mấy lần*/

        ArrayList<Integer> nums = new ArrayList<>(List.of(5, 3, 8, 3, 1, 8));

        int sum = 0;
        for(int n: nums){
            sum += n;
        }
        System.out.println("SUM is: "+sum);

        float avg = sum/nums.size();
        System.out.println("AVERAGE is: "+ avg);

        int max =  nums.get(0);
        for(int i = 0; i < nums.size(); i++){
            if( nums.get(i) > max){
                max =  nums.get(i);
            }
        }
        System.out.println("MAX is: "+max);

        int min = nums.get(0);
        for(int n: nums){
            if(n < min){
                min = n;
            }
        }
        System.out.println("MIN is: "+min);

        System.out.println("number of occurrences of the number 3: "+nums.indexOf(3));

        /* Bài 3. Cho List<Integer> chứa [1, -2, 3, -4, 5]. Xoá tất cả số âm. Làm hai cách: removeIf và Iterator.*/

        ArrayList<Integer> number = new ArrayList<>(List.of(1, -2, 3, -4, 5));

        // number.removeIf(n -> n < 0);

        Iterator<Integer> it = number.iterator();
        while(it.hasNext()){
            if( it.next() < 0 ){
                it.remove();
            }
        }
        System.out.println("number: "+number);

        List<Integer> reversed = reverse(number);

        System.out.println(number);
        System.out.println(reversed);

        System.out.println(filterAndUpper(list));


    }
    // Bài 4 — Đảo ngược danh sách
    public static List<Integer> reverse (List<Integer> input) {
        List<Integer> result = new ArrayList<>();

        for(int i = input.size(); i > 0; i--){
            result.add(input.get(i-1));
        }
        return result;
    }
    // Bài 5 — Lọc chuỗi dài hơn 3 và viết hoa
    public static List<String> filterAndUpper(List<String> input){
        List<String> result = new ArrayList<>();

        for(String s: input){
            if(s.length() > 3 ){
                String upper = s.toUpperCase();
                result.add(upper);
            }
        }
        return result;
    }

}
