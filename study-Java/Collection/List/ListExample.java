package Collection.List;

import java.util.*;

public class ListExample {
    public static void main(String[] args) {
        List <String> names = new ArrayList<>();

        // ADD
        names.add("An");  // [An]
        names.add("Binh"); // [An, Binh]
        names.add("Chi");   // [An, Binh, Chi]
        names.add(1, "Dung");  // chèn vào vị trí 1 → [An, Dung, Binh, Chi]

        // READ
        System.out.println(names.get(0)); // An
        System.out.println(names.size()); // 4
        System.out.println(names.contains("Chi")); // TRUE
        System.out.println(names.indexOf("Binh")); // 2
        System.out.println(names.isEmpty()); // false

        // UPDATE
        names.set(0, "Anh");
        System.out.println(names);

        // DELETE
        names.remove("Binh");  // xoá theo giá trị → [Anh, Dung, Chi]
        System.out.println(names);

        names.remove(0); // xoá theo index   → [Dung, Chi]
        System.out.println(names);

        names.clear();  // xoá sạch
        System.out.println(names);
    }
}
