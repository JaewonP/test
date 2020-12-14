//1. string concatenation
console.log("my" + "cat");
console.log("2" + 3);
console.log(`string literals: 1+2=${1 + 2}`); //$사용시 변수값을 계산해서 string으로 포함하여 문자열만듬
console.log("emma's \n\tdiary");

//2.Numeric operators
console.log(1 + 1);
console.log(5 * 2);
console.log(5 ** 2); //제곱!

//3. Increment and decrement operators
let counter = 2;
const preIncrement = ++counter;
//counter=counter+1;
//preincrement=counter;
console.log(`preincrement: ${preIncrement}, counter: ${counter}`);
const postIncrement = counter++;
//postincrement=counter;
//counter=counter+1;
console.log(`postIncrement: ${postIncrement}, counter: ${counter}`);

//4. Assignment operators
let x = 3;
let y = 6;
console.log((x += y));
x *= y;

//5. Comparison operators
console.log(10 < 6); //less than
console.log(10 <= 6); //less than or equals

//6. Logical operators: ||(or), &&(and), !(not)
const value1 = false;
const value2 = 4 < 2;
//||(or), find the first truthy value
console.log(`or: ${value1 || value2 || check()}`); //헤비한연산이 마지막, true를 맨앞에
function check() {
  for (let i = 0; i < 10; i++) {
    //wasting Time
    console.log("4");
  }
  return true;
} //or:true가 리턴됨
//&&(and), find the first falsy value
console.log(`and: ${value1 && value2 && value3}`);
function chech() {
  for (let i = 0; i < 10; i++) {
    //wasting time
    console.log("5");
  }
  return true;
} //and: false가 리턴됨
//!(not)
console.log(!value1);

//7. Equality
const stringFive = "5";
const numberFive = 5;

//==loose equality==
console.log(stringFive == numberFive); //같은타입으로 간주됨
console.log(stringFive != numberFive);
//==strict equality==
console.log(stringFive === numberFive); //같은타입이아님 string vs number
console.log(stringFive !== numberFive);
//example
console.log(0 == false);
console.log(0 === false);
console.log(null == undefined); //같은것으로 간주됨! 주의!!!!!
console.log(null === undefined); //둘이 타입이 다름

//8. conditional operators: if
//9. Ternary operator:?
//  condition? value1:value2 ;
console.log(name === "emma" ? "yes" : "no");
//10. switch
const browser = "IE";
switch (browser) {
  case "IE":
    console.log("go away");
    break;

  case "chrome":
  case "firefox": //같은메세지출력시엔 묶어준다
    console.log("love you!");
    break;

  default:
    console.log("same all!");
    break;
}

//11.while loop
//while
let a = 3;
while (a > 0) {
  console.log(`while: ${a}`);
  a--;
}

//do while
do {
  console.log(`do while: ${a}`);
} while (a > 0); //조건에 맞으면 멈춘다

//for loop(& next loop)
