// ==================== BAI HOC 5 PHUT: ERROR HANDLING ====================
// Error handling (xu ly loi) giup chuong trinh phan ung ro rang khi gap loi,
// thay vi dung dot ngot ma khong cho biet dieu gi da xay ra.

// 1. Tao va nem loi voi throw
// Dung Error de mo ta mot tinh huong bat thuong.
const errorExample = new Error("Da xay ra loi");
console.log("Ten loi:", errorExample.name); // Error
console.log("Thong diep:", errorExample.message); // Da xay ra loi

// throw nem loi ra ngoai; neu khong duoc bat, chuong trinh se dung tai loi do.
function calculateDiscount(price) {
  if (price < 0) {
    throw new Error("Gia tien khong the am");
  }

  return price * 0.9;
}

// 2. Bat loi voi try...catch
// Code trong try duoc chay truoc. Neu co loi, chuong trinh chuyen sang catch.
try {
  const discountedPrice = calculateDiscount(-50);
  console.log("Gia sau giam:", discountedPrice);
} catch (error) {
  console.log("Khong the tinh gia:", error.message);
}

console.log("Chuong trinh tiep tuc sau khi xu ly loi.");

// 3. finally
// finally chay sau try/catch, du co loi hay khong.
try {
  console.log("Dang thuc hien thao tac...");
  calculateDiscount(100);
} catch (error) {
  console.log("Loi:", error.message);
} finally {
  console.log("Thao tac da ket thuc.");
}

// 4. Bat loi khi phan tich JSON
const text = '{"name":"Lan"}';

try {
  const user = JSON.parse(text);
  console.log("Ten nguoi dung:", user.name);
} catch (error) {
  console.log("JSON khong hop le:", error.message);
}

// Thu thay text bang chuoi khong phai JSON, vi du: "khong phai JSON",
// de quan sat catch xu ly loi nhu the nao.

// 5. Khi nao nen nem loi?
// Kiem tra dieu kien dau vao va nem loi neu gia tri khong hop le.
// Khong nen bat loi roi bo qua; hay thong bao, xu ly, hoac nem loi tiep.
//
// Nen:
// try {
//   // thao tac co the that bai
// } catch (error) {
//   console.error("Khong the hoan thanh:", error.message);
// }
//
// Tranh catch rong vi loi se bi che giau:
// try {
//   // thao tac co the that bai
// } catch (error) {}

// 6. Ghi nho
// - throw new Error("..."): tao va nem loi.
// - try: dat code co the gap loi vao day.
// - catch (error): xu ly loi; error.message chua thong diep loi.
// - finally: don dep hoac bao ket thuc; chay du thanh cong hay that bai.
// - try...catch thong thuong bat loi dong bo. Voi Promise, can await trong try.

// Tu kiem tra:
// - Neu calculateDiscount nhan gia 200, ket qua la bao nhieu?
// - Neu bo try...catch khi goi calculateDiscount(-50), dieu gi xay ra?
// - Hay tu viet mot ham nem Error neu tuoi nho hon 0.
function checkAge(age) {
  if (age < 0) {
    throw new Error("Tuoi khong the am");
  }
  return age;
}