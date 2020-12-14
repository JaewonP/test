"use strict";

//2.variable, rw (read/write)  //let(added in ES6)
let globalname = "global name";
{
  let name = "emma";
  console.log(name);
  name = "baby";
  console.log(name);
}
console.log(name);
console.log(globalname);

//3. const(read only) -
const count = 17;
const size = 17.1;
console.log(`value: ${count}, type: ${typeof count}`);
console.log(`value: ${size}, type: ${typeof size}`);

//NOTE!
//immutable data types: primitive types, frozen objects
//Mutable data types: all objects by default are mutable in JS

//4. variable types
//number, string,
const char = "c";
const branden = "branden";
const greeting = "hello" + branden;
console.log(`value: ${greeting}, type: ${typeof greeting}`);
const hellobob = `hi ${branden}!`;
console.log(
  `value: ${hellobob}, type: ${typeof hellobob}'); <- 이런식으로 작업!(띄어쓰기도 인정됨)`
);
console.log("value: " + hellobob + "type:" + typeof hellobob);

//boolean
//false: 0,'',null,undefined
//true: any other value
const canread = true;
const test = 1 < 3;
console.log(`value: ${canread}, type: ${typeof canread}`);
console.log(`value: ${test}, type: ${typeof test}`);

//null
let nothing = null;
console.log(`value: ${nothing}, type: ${typeof nothing}`);

//undefined
let x;
console.log(`value: ${x}, type: ${typeof x}`);

//symbol -> 고유한 식별자를 만들떄! 1,2번 symbol의 식별자는 다른거!(값만 같고 각자 고유한 식별자)
const symbol1 = Symbol("id");
const symbol2 = Symbol("id");
console.log(symbol1 === symbol2);
//string이 같고 동일한 식별자를 만들고싶을떄
const gSymbol1 = Symbol.for("id");
const gSymbol2 = Symbol.for("id");
console.log(gSymbol1 === gSymbol2);

//5. dynamic typing -> 그떄그떄 쓰고싶은 변수타입으로 변경해서 사용가능(뒤통수 주의 )
let text = "hello";
console.log(text.charAt(0));
console.log(text.charAt(4));
console.log(`text: ${text}, type: ${typeof text}`);
text = 1;
console.log(`text: ${text}, type: ${typeof text}`);
text = "7" + 5;
console.log(`text: ${text}, type: ${typeof text}`);
console.log(text.charAt(4));
