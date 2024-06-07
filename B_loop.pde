void draw() {
  //D R A W
  //first loop (after "width" and "height" are properly defined)
  if(firstFrame) defineObjects();
  ellipseMode(CENTER);
  //rectMode(CORNERS)
  drawBackground();
  drawBricks();
  drawBalls();
  motionPhysics();
  drawText();
  firstFrame = false;
}
