const moreBtn = document.queryselector(
  "middleandupnext2 .middle .info .action .moreBtn"
);
const title = document.queryselector(
  "middleandupnext2 .middle .info .titleandBtn .title"
);

moreBtn.addeventlistener("click", () => {
  moreBtn.classList.toggle("clicked");
  title.classList.toggle("clamp");
});
