// ==================== BAI HOC: MAP TRONG JAVASCRIPT ====================
// Map luu du lieu theo cap key-value.
// Khac object, key cua Map co the la bat ky gia tri nao, ke ca object va function.
// Map ghi nho thu tu them key va co the lap qua bang for...of.

// 1. Tao Map
const emptyMap = new Map();
const scores = new Map([
  ["An", 8],
  ["Binh", 9],
  ["Chi", 7],
]);

console.log("Map rong:", emptyMap);
console.log("Map diem:", scores);

// 2. Them va cap nhat du lieu bang set()
scores.set("Dung", 10);
scores.set("An", 9); // Key "An" da co: cap nhat value, khong tao key moi
console.log("Sau set:", scores);

// set() tra ve chinh Map, nen co the goi lien tiep
const settings = new Map()
  .set("theme", "dark")
  .set("language", "vi");
console.log("Cai dat:", settings);

// 3. Doc, kiem tra va xoa du lieu
console.log("Diem cua An:", scores.get("An")); // 9
console.log("Co hoc sinh Chi khong?", scores.has("Chi")); // true
console.log("Xoa Chi thanh cong khong?", scores.delete("Chi")); // true
console.log("Key khong ton tai:", scores.get("Khong co")); // undefined

// get() tra ve undefined neu khong tim thay key.
// Dung has() neu can phan biet key khong co voi key co value la undefined.
const data = new Map([["optionalValue", undefined]]);
console.log("Key co ton tai:", data.has("optionalValue")); // true
console.log("Gia tri cua key:", data.get("optionalValue")); // undefined

// 4. Kich thuoc va xoa toan bo
console.log("So cap key-value:", scores.size); // size la property, khong phai size()
const temporaryMap = new Map([["a", 1], ["b", 2]]);
temporaryMap.clear();
console.log("Sau clear:", temporaryMap); // Map(0) {}

// 5. Duyet Map
const capitals = new Map([
  ["Viet Nam", "Ha Noi"],
  ["Nhat Ban", "Tokyo"],
  ["Phap", "Paris"],
]);

// Mac dinh, for...of tra ve tung cap [key, value]
for (const [country, capital] of capitals) {
  console.log("for...of:", country, "->", capital);
}

// Map co cac phuong thuc keys(), values() va entries()
console.log("Keys:", [...capitals.keys()]);
console.log("Values:", [...capitals.values()]);
console.log("Entries:", [...capitals.entries()]);

// forEach nhan tham so theo thu tu value, key, map
capitals.forEach((capital, country) => {
  console.log("forEach:", country, "->", capital);
});

// 6. Key khong chi la chuoi
const userKey = { id: 1 };
const userData = new Map();
userData.set(userKey, { name: "Lan", role: "student" });

console.log("Tim bang key goc:", userData.get(userKey));
console.log("Tim bang object moi:", userData.get({ id: 1 })); // undefined

// Object duoc so sanh theo tham chieu; noi dung giong nhau khong co nghia la cung key.
userData.set(NaN, "gia tri cua NaN");
console.log("NaN van tim duoc:", userData.get(NaN)); // "gia tri cua NaN"

// 7. Quy tac thu tu
const orderedMap = new Map([
  ["first", 1],
  ["second", 2],
]);
orderedMap.set("first", 100); // Cap nhat value khong doi vi tri key
orderedMap.delete("first");
orderedMap.set("first", 1); // Xoa roi them lai: key nam cuoi
console.log("Thu tu cac key:", [...orderedMap.keys()]); // ["second", "first"]

// 8. Chuyen doi Map va Object
const fruitMap = new Map([
  ["apple", 3],
  ["banana", 5],
]);
const fruitEntries = [...fruitMap]; // Mang cac cap [key, value]
const fruitObject = Object.fromEntries(fruitMap); // Object voi key la chuoi
const mapAgain = new Map(Object.entries(fruitObject));

console.log("Map sang mang entries:", fruitEntries);
console.log("Map sang Object:", fruitObject);
console.log("Object sang Map:", mapAgain);

// Khi chuyen sang Object, key khong-phai-chuoi co the bi chuyen thanh chuoi.
// vi vay khong phai Map nao cung chuyen doi qua lai ma giu nguyen key.

// 9. Khi nao nen dung Map?
// - Khi can luu cac cap key-value va thuong xuyen them/xoa/tim key.
// - Khi key can la number, object, function hoac gia tri khac string.
// - Khi can duyet theo thu tu them key.
// Dung Object khi mo ta mot doi tuong voi cac thuoc tinh co ten co dinh.

// 10. Tu kiem tra
// - Neu set() duoc goi hai lan voi cung mot key, size thay doi the nao?

// - Vi sao get({ id: 1 }) khong tim thay key userKey o vi du tren?

// - Hay thu viet Map luu ten mon hoc va diem, sau do duyet de in tung cap.
const subjectMap = new Map([
  ["Toan", 8],
  ["Van", 7],
  ["Anh", 9]
]);
for (const [subject, score] of subjectMap) {
  console.log("Môn học:", subject, "- Điểm:", score);
}