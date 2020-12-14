"use strict";
console.log("문제11----------------------------");
//for문을 이용한 기본활용
let s = 0;

for (let i = 0; i <= 100; i++) {
  s += i;
}

console.log(s);

console.log("문제12----------------------------");
class Wizard {
  constructor(health, mana, armor) {
    this.health = health;
    this.mana = mana;
    this.armor = armor;
  }

  attack() {
    console.log("파이어볼");
  }
}
const x = new Wizard(545, 210, 10);
console.log(x.health, x.mana, x.armor);
x.attack();

console.log("문제13 구리게 풀음----------------------------");

//let answer = prompt("숫자를 입력해주세요");

// switch (answer) {
//   case "1":
//     alert("수성");
//     break;

//   case "2":
//     alert("금성");
//     break;

//   case "3":
//     alert("지구");
//     break;

//   case "4":
//     alert("화성");
//     break;

//   case "5":
//     alert("목성");
//     break;

//   case "6":
//     alert("토성");
//     break;

//   case "7":
//     alert("천왕성");
//     break;

//   default:
//     alert("해왕성");
//     break;
// }

const planets = [
  "수성",
  "금성",
  "지구",
  "화성",
  "목성",
  "토성",
  "천왕성",
  "해왕성",
];
const n = prompt("몇번째 행성인가요?");
alert(planets[n - 1]);

//배열에 원하는정보를 나열후 거기서 꺼내오는것 --> 숫자받아서, 그 숫자에서 -1한 값을 부르면된다
//그 해당배열 planets의 몇번째-1의 정보!

console.log("문제14----------------------------");
const a = prompt("숫자를 입력하세요");

if (a % 3 === 0) {
  alert("짝");
} else {
  alert(a);
}

console.log("문제15----------------------------");
const b = prompt("이름을 입력하세요");

// if (b === "김다정") {
//   alert("안녕하세요. 저는 김다정입니다");
// }
console.log(`안녕하세요 저는${b}입니다`); //고정적인 내용과, 바뀔 내용 분간하기!!!

console.log("문제16 / 배열관련함수 총집합----------------------------"); //배열화 해서 푸는게 맞았어.
const c = prompt("문장을 입력하세요");
const reverseString = c.split("").reverse().join(""); //split에 구분자없으면 한배열에 모두몰빵
console.log(reverseString); //join에 구분자는 옵션!

console.log("문제17----------------------------");
const d = prompt("키를 입력하세요");

if (d >= 150) {
  console.log("yes");
} else console.log("no");

console.log("문제18 / split이용하여 평균점수 구하기------------help!!!-------");
const e = prompt("점수 3개를 입력하세요").split(" ");
let sum = 0;
for (let i = 0; i < e.length; i++) {
  sum = sum + parseInt(e[i], 10);
}
console.log(Math.floor(sum / e.length));

console.log("문제19----------------------------");
// const f = prompt("숫자 두개를 입력하세요").split(",");
// alert(f[0] ** f[1]);

const f = prompt("숫자 두개를 입력하세요").split(" ");
alert(Math.pow(f[0], f[1]));

console.log(
  "문제20 / parseInt로 나머지구하기-----------help!!!-----------------"
);
const g = prompt("숫자 두개를 입력하세요, 나눠버리게").split("");

let result = Math.floor(parseInt(g[0], 10) / parseInt(g[1], 10));
let left = parseInt(g[0], 10) % parseInt(g[1], 10);
console.log(result, left);
