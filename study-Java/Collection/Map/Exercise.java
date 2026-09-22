package Collection.Map;

import java.util.*;


public class Exercise {
    public static void main(String[] args) {

        // Bài 1 — Danh bạ cơ bản

        Map<String, String> map = new HashMap<>();
        map.put("An","0901");
        map.put("Binh","0902");
        map.put("Chi", "0903");

        System.out.println(map.get("Binh"));

        map.put("An","0999");
        System.out.println(map.get("An"));

        map.remove("Chi");

        System.out.println(map);

        System.out.println(map.getOrDefault("Dung","Not found"));


        // Bài 2 — Đếm tần suất số

        List<Integer> nums = List.of(5, 3, 8, 3, 1, 8, 3);
        Map<Integer, Integer> count = new LinkedHashMap<>();

        for(Integer i : nums){
            count.put(i, count.getOrDefault(i,0)+1);
        }
        System.out.println(count);

        // Bài 3 — Đếm ký tự
        Map<Character, Integer> count1 = new TreeMap<>();
        String text = "hello world";

        for(char c: text.toCharArray()){
            if(c == ' '){
                continue;
            }

            count1.put(c, count1.getOrDefault(c,0)+1);
        }
        System.out.println(count1);


        // Bài 5 — In từng dòng
//        for(Integer i : nums){
//            count.put(i, count.getOrDefault(i,0)+1);
//        }
        for(Map.Entry<Integer, Integer> e: count.entrySet()){
            System.out.println(e.getKey()+ " Xuat hien "+ e.getValue()+" lan");
        }

        // Bài 4 — Từ xuất hiện nhiều nhất
        System.out.println(mostFrequentWord("the cat and the dog and the bird"));

        //
        Map<Integer, List<String>> map1 = new TreeMap<>();
        List<String> list1 = List.of("an", "binh", "chi", "dung", "ha", "khoa");

        for(String word: list1){
            int leng = word.length();
            if(!map1.containsKey(leng)){
                map1.put(leng, new ArrayList<>());
            }
            List<String> box = map1.get(leng);
            box.add(word);
        }
        System.out.println(map1);


    }
    public static String mostFrequentWord(String sentence){
        String[] words = sentence.split(" ");
        Map<String, Integer> count = new HashMap<>();
        for(String word: words) {
            count.put(word,count.getOrDefault(word,0)+1 );
        }
        String bestWord = null; // tu dang giu ki luc, ban dau chua co.
        int bestCount = 0; // so lan cua tu do, ban dau = 0;
        for(String word: count.keySet()) {
            int c = count.get(word);

            if(c > bestCount){
                bestCount = c;
                bestWord = word;
            }
        }
        return bestWord;
    }
}
