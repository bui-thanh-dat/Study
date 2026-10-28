const arr = [1,2,3,true];
const arr2 = new Array(5);
console.log(arr2[2]);

const arr3 = Array.from("hello");
console.log(arr3);

arr3[2] = 'y';
console.log(arr3);
console.log(arr3[arr3.length - 1]);

arr3[arr.length + 5] = "test";
console.log(arr3);

arr2.push(4);
arr2.pop(); // remove last element
console.log(arr2);

arr3.shift(); // remove first element 
console.log(arr3);

arr3.unshift("new");
console.log(arr3);

console.log(arr3.indexOf('o'));
console.log(arr3.lastIndexOf('l'));
console.log(arr3.includes('l'));

const arr4 = arr.concat(arr3);
console.log(arr4);

const str = arr.join("|");
console.log(str);

const arr5  = arr.slice(1,3);
console.log(arr5);

const arr6  = arr.splice(1,1);
console.log(arr6);
console.log(arr);