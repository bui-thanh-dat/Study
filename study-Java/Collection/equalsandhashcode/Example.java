package collection.equalsandhashcode;

import java.util.Objects;

public class Example {
    public static class Student {
        private int id;
        private String name;
        private double gpa;

        public Student(int id, String name, double gpa) {
            this.id = id;
            this.name = name;
            this.gpa = gpa;
        }

        @Override
        public boolean equals(Object o) {
            if (o == null || getClass() != o.getClass()) return false;
            Student student = (Student) o;
            return id == student.id && Double.compare(gpa, student.gpa) == 0 && Objects.equals(name, student.name);
        }

        @Override
        public int hashCode() {
            return Objects.hash(id, name, gpa);
        }
    }
}