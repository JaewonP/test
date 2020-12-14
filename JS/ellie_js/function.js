"use strict";
//1. function declaration
//function name(para1, para2) {body....return;}
//naming: dosometiong, command, verb -> 한가지 동작에 대한 함수를 만들기!(다기능x)
//* function is object in js(변수에 할당, 파라미터에 전달, 함수리턴에 사용 가능!)
function log(message) {
  console.log(message);
}
log("helloemma");
log(1234);

//2.parameters
function changename(obj) {
  obj.name = "hwanggu";
}
const emma = { name: "emma" };
changename(emma); //emma의 이름이 hwanggu로 바뀌고
console.log(emma); //emma를 불러와서 그에 저장된 name:hwanggu출력

//3.default parameter(add in ES6)
function showmessage(message, from = "unknown") {
  //사용자가 파라미터를 전달하지않을때, 원하는 대체값 설정가능
  console.log(`${message} by ${from}`);
}
showmessage("emma");

//4. rest parameters(ES6)
function printall(...args) {
  //-> 다수의 형태의 인자가 배열형태로 전달되는것
  for (let i = 0; i < args.length; i++) {
    //-> 1번
    console.log(args[i]);
  }
  for (const arg of args) {
    //-> 2번
    console.log(arg);
  }
}
printall("bomgu", "hwanggu", "ohgu");

//5. Local scope  //tinted window
//지역변수에 선언되어있는것을 {}밖에서는 보지못한다.
//부모객체에 선언되어있는것을 자식객체에서도 끌어다쓸수있다.

//6. return a value
function sum(a, b) {
  return a + b; //return값이 생략된 함수는 return undefined가 생략되어있다.
}
const result = sum(1, 2);
console.log(`sum: ${sum(1, 2)}`);

//7.early return, early exit
//8. function expression
const print = function () {
  //함수를 변수에넣어 바로 함수선언
  //anonymous function
  console.log("print");
};
print();

const printagain = print;
printagain();

const sumagain = sum; //위에서 선언한 sum함수를 다른변수에 할당하면, 그 할당받은변수가 함수행세 쌉가능
console.log(sumagain(1, 3));

//9.callback hell  -> 필요한내용을 함수의 파라미터로 갖고있다가, 필요하면 가져다가 함수실행하는함수
function randomquiz(answer, printyes, printno) {
  if (answer === "love you") {
    printyes();
  } else {
    printno();
  }
}

const printyes = function () {
  console.log("yes!");
};
const printno = function print() {
  console.log("no!");
};
randomquiz("wrong", printyes, printno);
randomquiz("love you", printyes, printno);

//10.arrow function -> 함수를 간결하게함(always! anonymous함수)
const add = (a, b) => a + b;
const simpleprint = () => console.log("simpleprint!");

//11. IIFE : Immediately Invoked Function Expression
(function hello() {
  console.log("IIFE");
})();
//hello();     -> 따로 호출하지않고, 선언과 동시에 호출하는방법=IIFE
