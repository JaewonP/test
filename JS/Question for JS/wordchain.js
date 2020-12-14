"use strict";

let word = "puppy";
let word1 = "hwanggu";

while (true) {
  let answer = prompt(word1);
  if (word1[word1.length - 1] === answer[0]) {
    word1 = answer;
  } else {
    alert("똑바로하라");
  }
}
