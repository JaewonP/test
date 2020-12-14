const toDoForm = document.querySelector(".js-toDoForm");
const toDoInput = toDoForm.querySelector("input");
const toDoList = document.querySelector(".js-toDoList");

const TODOS_LS = "toDos";
const SHOWING_LN = "showing";
let toDos = [];
const newId = toDos.length + 1;

function deleteToDo(event) {
  const btn = event.target;
  const li = btn.parentNode;
  toDoList.removeChild(li); //객체의 자식노드 제거
  const cleanToDos = toDos.filter(function (toDo) {
    return toDo.id !== parseInt(li.id);
  }); //filter는 true만 모아놓을 함수를 새로만들어야함(forEach와같이 각각item과 같이 실행)
  toDos = cleanToDos;
  saveToDos();
}
function saveToDos() {
  localStorage.setItem(TODOS_LS, JSON.stringify(toDos));
}
function paintToDo(text) {
  //paint : 보여주다
  const li = document.createElement("li");
  const delBtn = document.createElement("button");
  delBtn.innerText = "X";
  delBtn.addEventListener("click", deleteToDo);
  const span = document.createElement("span");
  span.innerText = text;
  li.appendChild(delBtn);
  li.appendChild(span);
  li.id = newId;
  toDoList.appendChild(li);
  const toDosobj = {
    text: text,
    id: newId,
  };
  toDos.push(toDosobj);
  saveToDos();
}
function handleSubmit(event) {
  event.preventDefault();
  let currentValue = toDoInput.value;
  paintToDo(currentValue);
  toDoInput.value = " "; //변수에 저장하지말고, 원래의 toDoInput.value에 저장하기
}
function loadedToDos() {
  const loadedToDos = localStorage.getItem(TODOS_LS); //local은 무조건 string으로 글자가써져서 object로 숫자를 읽는다. 글자로바꾸려면 JSON사용
  if (loadedToDos !== null) {
    const parsedToDos = JSON.parse(loadedToDos);
    parsedToDos.forEach(function (toDo) {
      paintToDo(toDo.text);
    });
  }
}
function init() {
  loadedToDos();
  toDoForm.addEventListener("submit", handleSubmit);
}
init();
