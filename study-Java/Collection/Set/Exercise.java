package Collection.Set;

import org.w3c.dom.ls.LSOutput;

import java.util.*;

public class Exercise {
    public static void main(String[] args) {
        List<Integer> list = List.of(5, 3, 8, 3, 1, 8);

        Set<Integer> list1 = new HashSet<>(list);
        System.out.println("Số giá trị khác nhau: "+list1);

        Set<Integer> list2 = new LinkedHashSet<> (list);
        System.out.println("Loại trùng, giữ thứ tự ban đầu: "+list2);

        Set<Integer> list3 = new  TreeSet<> (list);
        System.out.println("Loại trùng, sắp xếp tăng dần: "+list3);


        System.out.println(firstDuplicate(list));


        Set<Integer> a = new HashSet<> (List.of(1, 2, 3, 4, 5));
        Set<Integer> b = new HashSet<> (List.of(4, 5, 6 , 7 ));


        Set<Integer> inter = new HashSet<>(a);
        inter.retainAll(b);
        System.out.println("Giao: "+inter);

        Set<Integer> union = new HashSet<>(a);
        union.addAll(b);
        System.out.println("Hop: "+union);

        Set<Integer> diff = new HashSet<>(a);
        diff.removeAll(b);
        System.out.println("Giao: "+diff);

        System.out.println("a: "+a);
        System.out.println("a: "+b);

        String sentence = "the cat and the dog and the bird";

        System.out.println(countDistinctWords(sentence));


        Scanner sc = new Scanner(System.in);

        System.out.print("Nhap so cap: ");
        int n = sc.nextInt();

        Set<String> set = new HashSet<>(n);

        for (int i = 0; i < n; i++) {
            String left = sc.next();
            String right = sc.next();

            String pair = left +" "+ right;

            set.add(pair);
        }

        System.out.println(set.size());


    }
    // Bài 2 — Số lặp lại đầu tiên
    public static Integer firstDuplicate(List<Integer> input){
        Set<Integer> seen = new HashSet<>();
        for(Integer n: input){
            if(!seen.add(n)){
                return n;
            }
        }
        return null;
    }
    public static int countDistinctWords (String sentence){
        String[] words = sentence.split(" ");
        Set<String> set = new HashSet<>();
        for(String w: words){
            set.add(w);
        }
        return set.size();
    }


}
