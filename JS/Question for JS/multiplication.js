while (true) {
  let num1 = Math.floor(Math.random() * 9) + 1;
  let num2 = Math.floor(Math.random() * 9) + 1;
  let result = num1 * num2;
  let condition = true;
  while (condition) {
    let answer = prompt(String(num1) + "곱하기" + String(num2) + "는?");
    if (result == answer) {
      alert("딩동댕");
      condition = false; //true로 하면 반복x
    } else {
      alert("땡");
    }
  }
}
