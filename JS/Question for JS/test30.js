"use strict";
console.log("문제21/ set..?----------------------------");
console.log("문제22----------------------------");
console.log("문제23----------------------------");
console.log("문제24/대문자로 바꾸기----------------------------");
let name = prompt("이름을 입력하세요");
console.log(name.toUpperCase());

console.log("문제25/원의넓이 구하기----------------------------");
const n = prompt("반지름을 입력하세요");
console.log(`원의 넓이는 ${Area(n)}입니다`);

function Area(a) {
  return Math.floor(Math.PI * n * n);
}

console.log("문제26/객체생성------이런거 너무어려워----------------------");
//행성문제 2
const planets = {
  수성: "mercury",
  금성: "venus",
  지구: "earth",
  화성: "mars",
  목성: "jupiter",
};
let receiveplanet = prompt("행성을 입력하세요");
console.log(planets[receiveplanet]);

console.log("문제27/객체만들기-----이런거 너모어려워..-----------------------");
const name1 = prompt("학생이름을 입력하세요").split(" ");
const score = prompt("학생의 점수를 입력하세요").split(" ");
let obj = {};

for (let i = 0; i < name1.length; i++) {
  obj[name1[i]] = score[i];
}
console.log(obj);

console.log("문제28----------------------------");
console.log("문제29----------------------------");
console.log("문제30----------------------------");
