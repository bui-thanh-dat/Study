const person = {
    first_name: "Spongebob",
    last_name: "Squarepants",
    age: 30,
    isEmployed: true,
    sayHello: function(){
        console.log("Hello, I am bui thanh dat !");
    }
}
const dog = {
    sayHello: () => console.log("Hi! I am Golden"),
}

console.log(person.age);
person.sayHello();

dog.sayHello();

// ===== Truy cập property: dot notation vs bracket notation =====
// Dot notation: dùng khi biết trước tên property, tên hợp lệ như định danh biến
console.log(person.first_name);
// Bracket notation: dùng khi tên property là biến, có khoảng trắng, hoặc ký tự đặc biệt
const key = "last_name";
console.log(person[key]);

// ===== Thêm / sửa / xóa property =====
person.email = "spongebob@bikinibottom.com"; // thêm mới
person.age = 31;                              // sửa
delete person.isEmployed;                     // xóa
console.log(person);

// ===== Kiểm tra property có tồn tại không =====
console.log("email" in person);          // true
console.log(person.hasOwnProperty("age")); // true
console.log(person.notExist === undefined); // true, cách kiểm tra khác

// ===== Property shorthand và method shorthand =====
// Khi tên biến và tên property giống nhau, có thể viết tắt
const name = "Patrick";
const city = "Bikini Bottom";
const character = {
  name,          // tương đương name: name
  city,          // tương đương city: city
  greet() {      // method shorthand, tương đương greet: function() {...}
    console.log(`Hi, I'm ${this.name} from ${this.city}`);
  },
};
character.greet();

// ===== Computed property name =====
// Dùng biến để đặt TÊN property ngay khi tạo object
const field = "score";
const player = {
  [field]: 100, // tên property lấy từ giá trị biến "field" -> "score"
};
console.log(player);

// ===== Object.keys / values / entries =====
console.log(Object.keys(character));   // ["name", "city", "greet"]
console.log(Object.values(character)); // [giá trị tương ứng]
console.log(Object.entries(character)); // [[key, value], ...]

// ===== Spread và rest với object =====
// Spread: tạo object mới bằng cách "trải" property từ object khác (copy nông - shallow copy)
const basicInfo = { name: "Squidward", job: "Cashier" };
const fullInfo = { ...basicInfo, age: 40 };
console.log(fullInfo);

// Rest: khi destructuring, lấy các property còn lại chưa được tách ra thành object riêng
const { name: squidName, ...rest } = fullInfo;
console.log(squidName, rest);

// ===== Destructuring object =====
const { first_name, age } = person;
console.log(first_name, age);

// ===== Nested object =====
const company = {
  name: "Krusty Krab",
  owner: {
    name: "Mr. Krabs",
    age: 65,
  },
};
console.log(company.owner.name);
// Optional chaining: tránh lỗi khi property lồng nhau có thể không tồn tại
console.log(company.owner?.address.street); // undefined, không bị lỗi crash

// ===== this trong object method =====
// "this" trỏ tới object đang gọi method (lưu ý: arrow function KHÔNG có this riêng,
// nó lấy this từ scope bên ngoài, nên dog.sayHello() ở trên không dùng được this.name)

// ===== Object.freeze =====
// Ngăn không cho thêm/sửa/xóa property sau khi freeze
const frozenObj = Object.freeze({ constant: 1 });
frozenObj.constant = 2; // không có lỗi nhưng cũng không thay đổi (ở non-strict mode)
console.log(frozenObj.constant); // vẫn là 1