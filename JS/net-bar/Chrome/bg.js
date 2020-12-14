const body = document.querySelector("body");
const IMG_NUMBER = 6;

function paintImage(imgNumber) {
  const image = new Image();
  image.src = `images/${imgNumber + 1}.jpg`; //변수-이미지파일 연결
  image.classList.add("bgImage"); //이미지에 class추가(css주기위함) -js를 css에 연결
  body.appendChild(image); //html body태그에 연결 -js를 html에 연결
}
function genRandom() {
  const number = Math.floor(Math.random() * IMG_NUMBER);
  return number;
}
function init() {
  const randomNumber = genRandom();
  paintImage(randomNumber);
}
init();
