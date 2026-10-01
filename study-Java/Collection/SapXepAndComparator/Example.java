package Collection.SapXepAndComparator;

import java.util.*;
public class Example {
    public static void main(String[] args) {
        List<Integer> nums = new ArrayList<>(List.of(5,3,8,1));
        Collections.sort(nums); // [1, 3, 5, 8]
        System.out.println(nums);

        List<String> names = new ArrayList<>(List.of("chi","an","binh"));
        Collections.sort(names); // [an, binh, chi]
        System.out.println(names);

        //Collections.reverse(nums); // // [8, 5, 3, 1]
        nums.sort(Collections.reverseOrder());
        System.out.println(nums);

// 4.2 "Thứ tự tự nhiên"
        List<String> a = new ArrayList<>(List.of("banana", "Apple", "cherry"));
        Collections.sort(a);       // [Apple, banana, cherry]
        System.out.println(a);


    }

    class Student implements Comparable<Student>{
        int id;
        String name;
        double cgpa;

        @Override
        public int compareTo(Student other){
            // return this.id - other.id; // sap xep id tang dan
            // return Integer.compare(this.id,other.id); // Tang dan
//            return Integer.compare(other.id,this.id); //giam dan
//            return this.name.compareTo(other.name); // A->Z
            return other.name.compareTo(this.name); // Z->A
        }

// 4.5 Cách 2: Comparator — thứ tự viết riêng bên ngoài
//        list.sort((a, b) -> Double.compare(a.cgpa, b.cgpa));    // điểm tăng dần
//        list.sort((a, b) -> a.name.compareTo(b.name));          // tên A→Z

    }
}
