document.getElementById("handy").addEventListener("change", updateBackground);
updateBackground();

function updateBackground() {
  document.body.style.backgroundColor = document.getElementById("handy").checked ? "red" : "blue";
}
