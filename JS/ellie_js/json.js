"use strict";
//JSON
//JavaScript Object Notation_자바스크립트 객체 표기법

// 1.Object to JSON
// Stringify(obj)
let json = JSON.stringify(true);
console.log(json);

json = JSON.stringify(["bomgu", "ohgu"]);
console.log(json);

//객체생성하여 객체를 전달
const bomgu = {
  name: "bomi",
  age: "31",
  job: null,
  hobby: "snowboarding",
};
json = JSON.stringify(bomgu);
console.log(json);

json = JSON.stringify(bomgu, ["name", "age"]); //객체의 옵션을 배열로 선택하여 전달가능
console.log(json);

json = JSON.stringify(bomgu, (key, value) => {
  console.log(`key: ${key}, value: ${value}`);
  return value;
});
console.log(json);

//2. JSON to Object
//parse(json)
console.clear;
