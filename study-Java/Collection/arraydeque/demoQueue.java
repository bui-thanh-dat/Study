package collection.arraydeque;

import java.util.*;

public class demoQueue {
    public static void main(String[] args) {
        Deque<Integer> queue = new ArrayDeque<>();

        queue.offer(1);
        queue.offer(2);
        queue.offer(3);

        System.out.println(queue.poll());; // lấy ra 1 — phần tử cũ nhất
        System.out.println(queue.peek());; // xem 2
    }
}
