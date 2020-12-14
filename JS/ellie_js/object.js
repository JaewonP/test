"use strict";
//object={key, value};
//1. Literals and properties
const obj1 = {};
const obj2 = new Object(); //'object constructor'에서 따온이름

function print(person) {
  console.log(person.name);
  console.log(person.age);
}
const emma = { name: "emma", age: 31 };
print(emma);

//2. Computed properties
//key should be always String
console.log(emma.name);
console.log(emma["name"]); //배열에서 받아오듯이 접근가능(key는 string타입으로!)
emma["hasjob"] = true;
console.log(emma.hasjob);

function printValue(obj, key) {
  //console.log(obj.key)->x
  console.log(obj["name"]);
}
printValue(emma, "name");
printValue(emma, "age");

//3. Property value shorthand
const person1 = { name: "emma", age: 31 };
const person2 = { name: "lilly", age: 27 };
const person3 = { name: "ohgu", age: 1 };
const person4 = new Person("ipgu", 1);
console.log(person4);

//4.Constructor
function Person(name, age) {
  //this=();
  this.name = name;
  this.age = age;
  //return this;
}

//5. in operator  //해당object에 key가 있는지 확인하는것  -->true /false return
console.log("name" in emma);
console.log("age" in emma);
console.log("random" in emma);

//6. for...in, for...of
//console.clear();
//for (key in emma) {      //for(key in obj)
//  console.log(key);
//}

//const array = [1, 2, 3, 4];
//for (value of array) {         //for(value of iterable-수많은.)
// console.log(value);
//}

//6. cloning
//Object.assign
const user = { name: "emma", age: "20" };
const user2 = user;

//old way
const user3 = {};
for (key in user) {
  user3[key] = user[key];
}

console.log(user3);

const user4 = {};
Object.assign(user4, user);
console.log(user4);

//or  const user4=object.assign({},user)
