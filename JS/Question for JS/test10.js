"use strict";
console.log("문제1 / array 편집----------------------------");
//1.배열의 삭제
//다음배열에서 400,500을 삭제하는 코드를 입력하시오
let nums = [100, 200, 300, 400, 500];
let array = nums.slice(0, 3);
console.log(array);

let nums1 = [100, 200, 300, 400, 500];
nums1.pop();
nums1.pop();
console.log(nums1);

console.log("문제2/ slice활용-----------------------------");
//2.배열의 내장함수
let arr = [200, 100, 300];
arr[2] = 10000;
arr[3] = 300;
console.log(arr);

let arr2 = [200, 100, 300];
arr2.splice(2, 0, 10000);
console.log(arr2);

console.log("문제3 틀림-----------------------------");
//다음의 출력값으로 바른것은?
let arr3 = [100, 200, 300];
console.log(typeof arr3);

console.log("문제4-----------------------------");
console.log("문제5-----------------------------");
console.log("문제6-----------------------------");
console.log("문제7 틀림-----------------------------");
//Js의 식별자로 가능한것은?
//-> 문자(대,소 모두가능), _, $로 시작
// let과같은 예약어는 불가능 / 숫자로 시작은 X
console.log("문제8 틀림-----------------------------");
//객체의 키 이름 중복일경우 "마지막 인덱스를 출력"
//오답원인 : lastIndexOf와 헷갈림(배열에 같은 value가 있을때, 마지막인덱스값을 갖고오는것)
console.log("문제9 틀림-----------------------------");
var year = "2019";
var month = "04";
var day = "26";
var hour = "11";
var minute = "34";
var second = "27";

var result = year.concat(
  "/" + month + "/" + day + " " + hour + ":" + minute + ":" + second
);

console.log(result);

console.log("문제10-----------------------------");

const n = prompt("숫자를 입력하시오(5)");

for (let i = 1; i <= n; i++) {
  console.log(" ".repeat(n - i) + "*".repeat(2 * i - 1));
}
