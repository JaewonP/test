const canvas = document.getElementById("jscanvas");
const ctx = canvas.getContext("2d");
const colors = document.getElementsByClassName("jsColor");
const range = document.getElementById("jsRange");
const mode = document.getElementById("jsMode");
const save = document.getElementById("jsSave");

const INITIAL_COLOR = "black";
const CANVAS_SIZE = 500;

canvas.width = CANVAS_SIZE;
canvas.height = CANVAS_SIZE;

ctx.fillStyle = "white";
ctx.fillRect(0, 0, CANVAS_SIZE, CANVAS_SIZE);
ctx.strokeStyle = INITIAL_COLOR; /* getContext값의 초기값을 정해준다 */
ctx.fillStyle = INITIAL_COLOR; /* 초기값이 반복되는걸 알아챈 순간, 초기값을 설정해준다 */
ctx.lineWidth = 2.5;

let painting = false;
let filling = false;

function onMouseMove(event) {
  const x = event.offsetX;
  const y = event.offsetY;

  if (!painting) {
    ctx.beginPath();
    ctx.moveTo(x, y);
  } else {
    ctx.lineTo(x, y);
    ctx.stroke(); /* 획을 긋는다  */
  }
}
function startPainting(event) {
  painting = true;
}
function stopPainting(event) {
  painting = false;
}
function handleColorClick(event) {
  const color = event.target.style.backgroundColor;
  ctx.strokeStyle = color;
  ctx.fillStyle = color;
}
function handleRangeChange(event) {
  const range = event.target.value;
  ctx.lineWidth = range;
}
function handleModeClick(event) {
  if (filling === true) {
    filling = false;
    mode.innerText = "Fill";
  } else {
    filling = true;
    mode.innerText = "Paint";
    ctx.fillStyle = ctx.strokeStyle; /*기존 선색과 같은 채움색이어야하므로 */
  }
}
function handleCanvasClick() {
  if (filling) {
    ctx.fillRect(0, 0, CANVAS_SIZE, CANVAS_SIZE);
  }
}
function handleCM(event) {
  event.preventDefault();
}
function handleSaveClick(event) {
  const image = canvas.toDataURL(); /* toDataURL()안에 비우면 PNG가 디폴트값, 채울경우 ("image/jpeg") */
  const link = document.createElement("a");
  link.href = image;
  link.download = "PaintJS by borobom>.<";
  link.click();
}

if (canvas) {
  canvas.addEventListener("mousemove", onMouseMove);
  canvas.addEventListener("mousedown", startPainting);
  canvas.addEventListener("mouseup", stopPainting);
  canvas.addEventListener("mouseleave", stopPainting);
  canvas.addEventListener("click", handleCanvasClick);
  canvas.addEventListener("contextmenu", handleCM);
}

Array.from(colors).forEach((color) =>
  color.addEventListener("click", handleColorClick)
);
if (range) {
  range.addEventListener("input", handleRangeChange);
}
if (mode) {
  mode.addEventListener("click", handleModeClick);
}
if (save) {
  save.addEventListener("click", handleSaveClick);
}
