//
// draw.js
//

//Line
function Line(){
  this.x1 = 0;
  this.y1 = 0;
  this.x2 = 0;
  this.y2 = 0;
  this.w = 1;
  this.style = "#000000";
};
Line.prototype.render = function(){
  this.x1 = this.x2;
  this.y1 = this.y2;
  this.x2 = event.clientX;
  this.y2 = event.clientY;
  renderer.beginPath();
  renderer.moveTo(this.x1, this.y1);
  renderer.lineTo(this.x2, this.y2);
  renderer.lineWidth = this.w;
  renderer.strokeStyle = this.style;
  renderer.stroke();
};
Line.prototype.follow = function(){
  this.x1 = this.x2;
  this.y1 = this.y2;
  this.x2 = event.clientX;
  this.y2 = event.clientY;
};

// Create Canvas and elements
var canvas = document.createElement("canvas");
function setCanvasSize(){
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
};
window.addEventListener("resize", setCanvasSize);
var renderer = canvas.getContext("2d");
var stroke = new Line();
window.onmousemove = function(){stroke.follow();};
window.addEventListener("mousedown", function(){
  window.onmousemove = function(){stroke.render();};});
window.addEventListener("mouseup", function(){
  window.onmousemove = function(){stroke.follow();};});


// Main
window.onload = function(){
  document.body.appendChild(canvas);
  setCanvasSize();
  reset();
};

// Reset
var reset = function() {
  renderer.fillStyle = "#FFFFFF";
  renderer.fillRect(0, 0, canvas.width, canvas.height);
};

var changeColor = function(color, w){
  stroke.style = color;
  stroke.w = w;
};
