form = document.querySelector(".js-form");
input = form.querySelector("input");
greetting = document.querySelector(".js-greetting");
USER_LS = "userName";
SHOWING_CN = "showing"; //CN=Class Name

function saveName(text) {
  localStorage.setItem(USER_LS, text);
}
function handleSubmit(event) {
  event.preventDefault(); //preventDefault로 천장까지 못올라가게막음
  let currentValue = input.value;
  paintGreeting(currentValue);
  //currentValue = "";
  saveName(currentValue);
}
function askForName() {
  form.classList.add(SHOWING_CN); //form이 나타나게한다.
  form.addEventListener("submit", handleSubmit); //event는 버블과같아서 root에서부터 document까지 올라간다
}
function paintGreeting(text) {
  form.classList.remove(SHOWING_CN);
  greetting.classList.add(SHOWING_CN);
  greetting.innerText = `hello ${text}`;
}
function loadName() {
  const currentUser = localStorage.getItem(USER_LS);
  if (currentUser === null) {
    askForName();
  } else {
    paintGreeting(currentUser);
  }
}
function init() {
  loadName();
}
init();
