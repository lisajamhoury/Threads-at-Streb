void setRopeCenter() {
  println(mouseX, mouseY);
  
  fill(255);
  rectMode(CENTER);
  rect(mouseX, mouseY, 200, 200);
  fill(0);
  textSize(26);
  textAlign(CENTER);
  text(mouseX + ", " + mouseY, mouseX, mouseY);
  rectMode(CORNER);

}