package Lambda;

import java.util.Arrays;

@FunctionalInterface
interface HanhDong {
    int thucHien(int x);
}

//class NhanDoi implements HanhDong {
//    @Override
//    public int thucHien(int x) {
//        return x * 2;
//    }
//}

//class CongMuoi implements HanhDong {
//    @Override
//    public int thucHien(int x) {
//        return x + 10;
//    }
//}

public class Test {
    static void xuLy(int[] arr, HanhDong hd) {
        for (int i = 0; i < arr.length; i++) {
            arr[i] = hd.thucHien(arr[i]);
        }
    }
    public static void main(String[] args) {
        int[] arr = {1,2,3,4};
//        xuLy(arr,new HanhDong() {
//            @Override
//            public int thucHien(int x) {
//                return x * 2;
//            }
//        });
//        xuLy(arr, new HanhDong() {
//            @Override
//            public int thucHien(int x){ return x - 1; }
//        });
//        xuLy(arr,new CongMuoi());

        xuLy(arr, x -> x * 2 );
        xuLy(arr, x -> x + 10 );
        xuLy(arr, x -> x - 1  );
        System.out.println(Arrays.toString(arr));

        String[] arr1 = {"java","python","c++", "go"};
        Arrays.sort(arr1, (a,b) -> b.length() - a.length());
        System.out.println(Arrays.toString(arr1));
    }
}
