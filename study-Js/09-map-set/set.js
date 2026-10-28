// ==================== BAI HOC: SET TRONG JAVASCRIPT ====================
// Set la tap hop cac gia tri khong trung lap.
// Set ghi nho thu tu them phan tu va co the lap qua bang for...of.

// 1. Tao Set
const emptySet = new Set();
const numbers = new Set([1, 2, 2, 3, 3, 3]);

console.log("Set rong:", emptySet);
console.log("Tu dong loai gia tri trung:", numbers); // Set(3) { 1, 2, 3 }

// 2. Them, kiem tra va xoa phan tu
numbers.add(4); // Them gia tri 4
numbers.add(4); // Khong tao them phan tu vi 4 da co trong Set
console.log("Sau add:", numbers);
console.log("Co so 2 khong?", numbers.has(2)); // true
console.log("Xoa so 3 thanh cong khong?", numbers.delete(3)); // true
console.log("Sau delete:", numbers);

// 3. Kich thuoc va xoa toan bo
console.log("So phan tu:", numbers.size); // size la property, khong phai size()
const temporarySet = new Set(["a", "b"]);
temporarySet.clear();
console.log("Sau clear:", temporarySet); // Set(0) {}

// 4. Duyet qua Set
const colors = new Set(["red", "green", "blue"]);

for (const color of colors) {
	console.log("for...of:", color);
}

// forEach nhan gia tri hai lan; tham so thu hai cung la gia tri.
colors.forEach((value, sameValue) => {
	console.log("forEach:", value, sameValue);
});

// 5. Chuyen doi giua Set va Array
const letters = new Set(["a", "b", "c"]);
const lettersArray = [...letters];
console.log("Set sang Array:", lettersArray);

const arrayWithDuplicates = [1, 2, 2, 3, 3, 4];
const uniqueArray = [...new Set(arrayWithDuplicates)];
console.log("Loai trung trong Array:", uniqueArray);

// 6. Cac phep tap hop co ban
const setA = new Set([1, 2, 3]);
const setB = new Set([3, 4, 5]);

// Hop: phan tu thuoc A hoac B
const union = new Set([...setA, ...setB]);
console.log("Hop:", union); // Set { 1, 2, 3, 4, 5 }

// Giao: phan tu co trong ca A va B
const intersection = new Set([...setA].filter((value) => setB.has(value)));
console.log("Giao:", intersection); // Set { 3 }

// Hieu A - B: phan tu co trong A nhung khong co trong B
const difference = new Set([...setA].filter((value) => !setB.has(value)));
console.log("Hieu A - B:", difference); // Set { 1, 2 }

// 7. Quy tac so sanh gia tri
const specialValues = new Set([NaN, NaN, 0, -0]);
console.log("NaN va 0/-0 chi xuat hien mot lan:", specialValues.size); // 2

// Set so sanh object theo tham chieu, khong so sanh cac thuoc tinh ben trong.
const firstObject = { id: 1 };
const secondObject = { id: 1 };
const objects = new Set([firstObject, secondObject]);
console.log("Hai object rieng biet:", objects.size); // 2
console.log("Dung object goc:", objects.has(firstObject)); // true
console.log("Object moi cung noi dung:", objects.has({ id: 1 })); // false

// 8. Khi nao nen dung Set?
// - Khi can dam bao danh sach khong co gia tri trung lap.
// - Khi can them, xoa hoac kiem tra mot gia tri co ton tai hay khong.
// - Khi can loai gia tri trung lap trong mot mang.
// Khong dung Set neu can truy cap phan tu theo index nhu Array.
