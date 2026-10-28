package collection.arraydeque;

import java.util.ArrayDeque;
import java.util.Deque;

public class demoDeque {
    public static void main(String[] args) {
        Deque<Integer> stack = new ArrayDeque<>();
        stack.push(1);
        stack.push(2);
        stack.push(3);

        int c= stack.pop(); // lay ra 3, phan tu moi nhat;
        int a  = stack.peek();  // xem 2 nhưng không lấy ra
        System.out.println(stack.isEmpty());
        System.out.println(a);
    }
}
