package Collection.SapXepAndComparator;
import java.util.*;

/**
 * Code mẫu minh hoạ mục 4.5 → 4.8 của Phần 4 (Sắp xếp & Comparator).
 * Chạy thẳng file này để xem kết quả từng phần.
 */

public class DemoComparator {

    // ===== Class Student dùng chung cho cả file =====
    static class Student {
        int id;
        String name;
        double cgpa;

        Student(int id, String name, double cgpa) {
            this.id = id;
            this.name = name;
            this.cgpa = cgpa;
        }

        // Quyết định cách in một Student khi println
        @Override
        public String toString() {
            return id + " " + name + " " + cgpa;
        }
    }

    // Tạo lại danh sách mới mỗi lần, vì sort sửa trực tiếp list gốc
    static List<Student> taoDanhSach() {
        List<Student> list = new ArrayList<>();
        list.add(new Student(3, "binh", 3.5));
        list.add(new Student(1, "an",   3.9));
        list.add(new Student(4, "an",   3.5));
        list.add(new Student(2, "chi",  3.5));
        return list;
    }

    static void in(String tieuDe, List<Student> list) {
        System.out.println("--- " + tieuDe + " ---");
        for (Student s : list) {
            System.out.println(s);
        }
        System.out.println();
    }

    public static void main(String[] args) {
        demo45();
        demo46();
        demo47();
        demo48();
    }

    // ===================================================================
    // 4.5 — COMPARATOR: thứ tự viết riêng bên ngoài, mỗi lần sort một kiểu
    // ===================================================================
    static void demo45() {
        System.out.println("=========== 4.5 COMPARATOR ===========\n");

        // Lambda (a, b) -> ... trả về âm / 0 / dương theo quy ước:
        //   âm    → a đứng trước b
        //   0     → bằng nhau
        //   dương → a đứng sau b

        List<Student> list = taoDanhSach();
        list.sort((a, b) -> Double.compare(a.cgpa, b.cgpa));   // cgpa TĂNG dần
        in("cgpa tang dan", list);

        list = taoDanhSach();
        list.sort((a, b) -> Double.compare(b.cgpa, a.cgpa));   // đảo a,b → GIẢM dần
        in("cgpa giam dan", list);

        list = taoDanhSach();
        list.sort((a, b) -> a.name.compareTo(b.name));         // tên A→Z
        in("ten A-Z", list);

        list = taoDanhSach();
        list.sort((a, b) -> b.name.compareTo(a.name));         // tên Z→A
        in("ten Z-A", list);

        list = taoDanhSach();
        list.sort((a, b) -> Integer.compare(a.id, b.id));      // id tăng dần
        in("id tang dan", list);
    }

    // ===================================================================
    // 4.6 — NHIỀU TIÊU CHÍ: so tiêu chí 1; bằng nhau (0) mới xét tiêu chí 2
    // ===================================================================
    static void demo46() {
        System.out.println("=========== 4.6 NHIEU TIEU CHI ===========\n");

        List<Student> list = taoDanhSach();

        list.sort((a, b) -> {
            // Tiêu chí 1: cgpa GIẢM dần (b trước a)
            int r = Double.compare(b.cgpa, a.cgpa);
            if (r != 0) {
                return r;              // cgpa khác nhau → quyết định xong
            }

            // Tiêu chí 2: tên A→Z
            r = a.name.compareTo(b.name);
            if (r != 0) {
                return r;
            }

            // Tiêu chí 3: id tăng dần
            return Integer.compare(a.id, b.id);
        });

        in("cgpa giam -> ten A-Z -> id tang", list);
        // Ket qua mong doi:
        // 1 an 3.9
        // 4 an 3.5
        // 3 binh 3.5
        // 2 chi 3.5
    }

    // ===================================================================
    // 4.7 — CÁCH VIẾT NGẮN (Java 8+): cùng kết quả với 4.6
    // ===================================================================
    static void demo47() {
        System.out.println("=========== 4.7 CACH VIET NGAN ===========\n");

        List<Student> list = taoDanhSach();

        list.sort(
            Comparator.comparingDouble((Student s) -> s.cgpa).reversed()  // cgpa giảm
                      .thenComparing(s -> s.name)                          // rồi tên A→Z
                      .thenComparingInt(s -> s.id)                         // rồi id tăng
        );

        in("cach ngan - ket qua giong 4.6", list);
    }

    // ===================================================================
    // 4.8 — SẮP MAP THEO VALUE: đổ entrySet ra List rồi sort
    // ===================================================================
    static void demo48() {
        System.out.println("=========== 4.8 SAP MAP THEO VALUE ===========\n");

        // Bước 1: đếm tần suất (mẫu của Phần 3)
        String sentence = "the cat and the dog and the bird";
        Map<String, Integer> count = new HashMap<>();
        for (String word : sentence.split(" ")) {
            count.put(word, count.getOrDefault(word, 0) + 1);
        }
        System.out.println("Map dem: " + count + "\n");

        // Bước 2: đổ các cặp ra List (Map không tự sắp theo value được)
        List<Map.Entry<String, Integer>> entries = new ArrayList<>(count.entrySet());

        // Bước 3: sort theo value giảm dần; value bằng nhau thì theo từ A→Z
        entries.sort((a, b) -> {
            int r = Integer.compare(b.getValue(), a.getValue());
            if (r != 0) {
                return r;
            }
            return a.getKey().compareTo(b.getKey());
        });

        // Bước 4: in
        System.out.println("--- so lan giam dan ---");
        for (Map.Entry<String, Integer> e : entries) {
            System.out.println(e.getKey() + " = " + e.getValue());
        }
    }
}
