"use strict";

//1. Array declaration
const arr1 = new Array();
const arr2 = [1, 2];

//2. Index position -어떻게 배열에 접근하는가?
const fruits = ["☆", "★"];
console.log(fruits);
console.log(fruits.length);
console.log(fruits[fruits.length - 1]); //index(key)를 입력하여 value받아온다

//3. Looping over an array

//for
//for (let i = 0; i < fruits.length; i++) {
//  console.log(fruits[i]);}

//for...of
for (let fruit of fruits) {
  console.log(fruit);
}

//forEach
console.clear();
//fruits.forEach(function (fruit, index, Array) {
//  console.log(fruit, index, Array);
//});
fruits.forEach((fruit) => console.log(fruit));
//foreach는 배열안에들어있는 value들 마다 내가 전달한 함수를 출력하는구나

//4. addition, deletion, copy
//push: add and item to the end
fruits.push("♡", "♥");
console.log(fruits);
//pop: remove an item from the end
fruits.pop();
console.log(fruits);
fruits.pop();
console.log(fruits); //뒤부터 뺴고 넣는거

//unshift: add an item to the beginning
fruits.unshift("□", "■");
console.log(fruits);
//shift: remove an item from the beginning
fruits.shift();
console.log(fruits);
fruits.shift();
console.log(fruits);

//*note! shift,unshift -> pop/push보다 느리다! 그러니까 pop,push로 쓴다(배열뒤부터접근)
//splice:remove an item by index position
fruits.push("◇", "◆", "■");
console.log(fruits);
fruits.splice(1, 1); //몇개지울지 안정하면 다지운다
console.log(fruits);
fruits.splice(1, 0, "▷", "▶"); //데이터를 지우지않고 원하는부분에 데이터를 넣을때
console.log(fruits);

//combine two array
const fruits2 = ["♧", "♣"];
const newFruits = fruits.concat(fruits2);
console.log(newFruits);

//5. Searching_find the index
//indexof
console.clear();
console.log(fruits);
console.log(fruits.indexOf("☆"));
console.log(fruits.indexOf("＆")); //없는index찾을때 -1출력

//includes
console.log(fruits.includes("☆"));
console.log(fruits.includes("§")); //없는거면 false출력

//lastindexof _중복되는 value값이 있을때 앞에서부터 찾으려면 indexof, 마지막꺼 찾으려면 lastIndexOf
console.clear();
fruits.push("☆");
console.log(fruits);
console.log(fruits.indexOf("☆"));
console.log(fruits.lastIndexOf("☆")); //대문자 주의
