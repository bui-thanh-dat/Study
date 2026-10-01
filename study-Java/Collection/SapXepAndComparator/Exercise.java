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


        List<Student> students = new ArrayList<>();
        students.add(new Student(3,"binh",3.5));
        students.add(new Student(1,"an",3.9));
        students.add(new Student(2,"chi",3.5 ));
        students.add(new Student(4,"an", 3.6));

        students.sort((a,b) -> Integer.compare(a.id,b.id));
        System.out.println("Sort in ascending order ID : "+students);
        for(Student student : students){}


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
