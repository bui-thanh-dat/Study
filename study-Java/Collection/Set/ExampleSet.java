package Collection.Set;

import java.util.*;

public class ExampleSet {
    public static void main(String[] args) {
        Set<String> set = new HashSet<>();

        set.add("An");
        set.add("Binh");
        set.add("An");

        System.out.println(set);
        System.out.println(set.size());
        System.out.println(set.contains("An"));
        System.out.println(set.remove("Binh"));

        // 2. add() trả về true/false
        System.out.println(set.add("An"));
        System.out.println(set.add("Dat"));
        System.out.println(set);
        List<Integer> data = List.of(5, 3, 8, 3, 1, 8);

        // 2.4 Ba loại Set — khác nhau ở thứ tự

        new HashSet<>(data);        // [1, 3, 5, 8]  — thứ tự KHÔNG đảm bảo
        new LinkedHashSet<>(data);  // [5, 3, 8, 1]  — giữ thứ tự CHÈN VÀO
        new TreeSet<>(data);        // [1, 3, 5, 8]  — luôn SẮP XẾP tăng dần


        // 2.5 Phép toán tập hợp
        Set<Integer> a = new HashSet<>(List.of(1, 2, 3, 4, 5));
        Set<Integer> b =  new HashSet<>(List.of(4,5 ,6,7,8,9,10));

        Set<Integer> union = new HashSet<>(a);
        union.addAll(b); // // hợp:  [1, 2, 3, 4, 5]
        System.out.println(union);

        Set<Integer> inter = new HashSet<>(a);
        inter.retainAll(b); // giao: [3, 4]
        System.out.println(inter);

        Set<Integer> difference = new HashSet<>(a);
        difference.removeAll(b);  //  // hiệu a − b: [1, 2]
        System.out.println(difference);

        List<Integer> list = List.of(1, 2, 3, 4, 5, 3 );
        Set<Integer> set1 = new HashSet<>(list); // List → Set (loại trùng)
        System.out.println(set1);
        List<Integer> back = new ArrayList<>(set1);   // Set → List (để dùng get/sort)
        System.out.println(back);

    }
    public static boolean hasDuplicates(List<String> input) {
        Set<String> set = new HashSet<>();

        for(String n: input){
            if(!set.add(n)){
                return true;
            }
        }
        return false;
    }
}

