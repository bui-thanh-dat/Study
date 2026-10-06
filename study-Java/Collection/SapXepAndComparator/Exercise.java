package Collection.SapXepAndComparator;

import java.util.*;

public class Exercise {
    public static void main(String[] args) {
        List<Integer> nums = new ArrayList<>(List.of(5, 3, 8, 1, 9));
        List<String> names = new ArrayList<>(List.of("chi", "an", "binh"));

        Collections.sort(nums);
        System.out.println("Sort in ascending order: "+nums);

        Collections.reverse(nums);
        System.out.println("Sort in descending order: "+nums);
        // nums.sort(Collections.reverseOrder());

        Collections.sort(names);
        System.out.println("Sort A-Z: "+names);

        Collections.reverse(names);
        System.out.println("Sort Z-A: "+names);

        List<Integer> number = new ArrayList<>(List.of(5, 3, 8, 1, 9));
        List<Integer> result = sortedCopy(nums);

        System.out.println(result);
        System.out.println(number);

        // Bài 3 — Class Student với Comparable
        List<Student> students = new ArrayList<>();
        students.add(new Student(3,"binh",3.5));
        students.add(new Student(1,"an",3.9));
        students.add(new Student(2,"chi",3.5 ));
        students.add(new Student(4,"an", 3.5));

        students.sort((a,b) -> Integer.compare(a.id,b.id));
        System.out.println("Sort in ascending order ID : "+students);
        for(Student student : students){}

       // Bài 4 — Comparator nhiều tiêu chí
        sortByMultiCriteria(students);

        for(Student s :  students){
            // System.out.println(s.id + " " + s.name + " " + s.cgpa);
            System.out.println(s);
        }
        // Bài 5 — Sắp Map theo value
        String sentence = "the cat and the dog and the bird";
        printByFrequency(sentence);

        // Bài 6 — Top N
        System.out.println(topWords(sentence,3));;

    }
    // Bài 4 — Comparator nhiều tiêu chí
    static void sortByMultiCriteria(List<Student> list){
        list.sort((a,b) -> {
            int c = Double.compare(b.cgpa,a.cgpa);
            if(c != 0) return c;
            c = a.name.compareTo(b.name);
            if(c != 0) return c;
            return Integer.compare(a.id,b.id);
        });
    }

    // Bài 5 — Sắp Map theo value
    static void printByFrequency(String sentence) {

        // 1.  Đếm
        Map<String, Integer> count = new HashMap<>();
        for(String w : sentence.split(" ")){
            count.put(w,count.getOrDefault(w,0)+1);
        }
        // 2. Chuyển sang List
        List<Map.Entry<String, Integer>> entries = new ArrayList<>(count.entrySet());

        // 3. sort
        entries.sort((e1,e2) -> {
            int c = Integer.compare(e2.getValue(),e1.getValue()); // tieu chi 1: value giam dan
            if( c != 0) return c; // khac nhau thi xong
            return e1.getKey().compareTo(e2.getKey()); // hoa thi key A->Z
        });
        // 4. In
        for(Map.Entry<String, Integer> entry : entries){
            System.out.println(entry.getKey()+ " = " + entry.getValue());
        }
    }

    // Bài 6 — Top N

    public static List<String> topWords(String sentence, int n) {
        Map<String, Integer> count = new HashMap<>();
        for(String w: sentence.split(" ")){
            count.put(w,count.getOrDefault(w,0)+1);
        }
        List<Map.Entry<String, Integer>> entries = new ArrayList<>(count.entrySet());

        entries.sort((e1,e2) -> {
            int c = Integer.compare(e2.getValue(),e1.getValue());
            if(c != 0) return c;
            return e1.getKey().compareTo(e2.getKey());
        });

        List<String> result = new ArrayList<>();
        for(Map.Entry<String, Integer> entry : entries){
            if(result.size() >= n ) break;
            result.add(entry.getKey());
        }
        return result;

    }

    public static List<Integer> sortedCopy(List<Integer> input) {
        ArrayList<Integer> output = new ArrayList<>(input);

        Collections.sort(output);
        return output;
    }

    static class Student {
        int id;
        String name;
        double cgpa;

        Student(int  id, String name, double cgpa) {
            this.id = id;
            this.name = name;
            this.cgpa = cgpa;
        }

        @Override
        public String toString(){ return id + " " + name + " " + cgpa; }
    }
}
