package Collection.Map;

import java.util.*;

public class ThaoTacCoBan {
    public static void main(String[] args) {
        Map<String, Integer> ages = new HashMap<>();

        //ADD
        ages.put("An",20);
        ages.put("Binh",22);
        ages.put("Chi",19);

        //READ
        System.out.println(ages.get("An")); // 20
        System.out.println(ages.get("Zoe")); // null
        System.out.println(ages.containsKey("Binh")); // true
        System.out.println(ages.containsValue(19)); // true
        System.out.println(ages.size()); // 3

        //UPDATE
        ages.put("An",21);  // An: 20 -> 21

        // DELETE
        ages.remove("Chi");

        System.out.println(ages);


        // 3.4 getOrDefault
        ages.getOrDefault("Zoe", 0);
        System.out.println(ages);

        // 3.5 Ba cách duyệt Map

        //Cách 1: chỉ cần key
        for(String name: ages.keySet()){
            System.out.println(name);
        }
        // Cách 2: chỉ cần value
        for(Integer age: ages.values()){
            System.out.println(age);
        }
        // // Cách 3: cần cả key lẫn value — DÙNG CÁCH NÀY NHIỀU NHẤT
        for(Map.Entry<String, Integer> e: ages.entrySet()){
            System.out.println(e.getKey() + " "+ e.getValue());
        }
        // lambda
        ages.forEach((k,v) -> System.out.println(k + " " + v));


        //3.6 Kỹ thuật đếm tần suất
        List<String> items = List.of("a","b","c","a","c","a");
        Map<String,Integer> count = new HashMap<>();

        for(String x : items ){
            count.put(x, count.getOrDefault(x,0) + 1);
            //count.merge(x, 1, Integer::sum);
        }
        System.out.println(count);


        // int n = count.get("z"); // ❌ NullPointerException

        // 3.9 Value có thể là collection
        Map<String, List<String>> classes = new HashMap<>();
        classes.put("10A", new ArrayList<>(List.of("An","Binh")));
        classes.get("10A").add("Chi"); // // thêm học sinh vào lớp 10A
        System.out.println(classes);
    }
}
