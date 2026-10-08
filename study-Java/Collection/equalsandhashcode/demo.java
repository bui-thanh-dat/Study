package collection.equalsandhashcode;

import java.util.*;

public class demo {
    public static void main(String[] args) {
        // Sử dụng Example.Student đồng bộ với khai báo Set
        Set<Example.Student> set = new HashSet<>();

        set.add(new Example.Student(1, "an", 3.9));
        set.add(new Example.Student(1, "an", 3.9)); // y hệt

        System.out.println(set.size()); // Sẽ in ra: 1
    }
}