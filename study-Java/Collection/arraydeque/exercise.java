package collection.arraydeque;
import java.util.*;

public class exercise {
    public static void main(String[] args) {
        Deque<Integer> stack = new ArrayDeque<>();
        stack.push(1);
        stack.push(2);
        stack.push(3);

        while(!stack.isEmpty()){
            System.out.println(stack.pop());
        }
        System.out.println("size = " + stack.size());

        Deque<Integer> queue = new ArrayDeque<>();
        queue.offer(1);
        queue.offer(2);
        queue.offer(3);

        while(!queue.isEmpty()){
            System.out.println(queue.poll());
        }
        System.out.println("size = " + queue.size());

        Deque<Character> stack2 = new ArrayDeque<>();
//        stack2.push("h");
//        stack2.push("e");
//        stack2.push("l");
//        stack2.push("l");
//        stack2.push("o");
        String input = "hello";
        for(int i = 0; i < input.length(); i++){
            //stack2.push(input.substring(i, i+1));
            char c = input.charAt(i);
            stack2.push(c);
        }

        String ketQua = "";

        while(!stack2.isEmpty()){
           ketQua += stack2.pop();
        }
        System.out.println(ketQua);
    }
}
/* Here is a comment **** */
/* This is also a comment /* More comments */ */