package Lambda;

import java.util.Arrays;

interface HanhDong {
    int thucHien(int x);
}

//class NhanDoi implements HanhDong {
//    @Override
//    public int thucHien(int x) {
//        return x * 2;
//    }
//}

class CongMuoi implements HanhDong {
    @Override
    public int thucHien(int x) {
        return x + 10;
    }
}

public class Test {
    static void xuLy(int[] arr, HanhDong hd) {
        for (int i = 0; i < arr.length; i++) {
            arr[i] = hd.thucHien(arr[i]);
        }
    }
    public static void main(String[] args) {
        int[] arr = {1,2,3,4};
        xuLy(arr,new HanhDong() {
            @Override
            public int thucHien(int x) {
                return x * 2;
            }
        });

        xuLy(arr,new CongMuoi());
        System.out.println(Arrays.toString(arr));
    }
}
