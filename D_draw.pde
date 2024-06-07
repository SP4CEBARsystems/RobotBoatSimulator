void drawBackground(){
  background(153);
  stroke(0,0,0);
  fill(200,250,255);
  rect(border,border,width-2*border,height-2*border);
}

void drawBricks(){
  //use this to draw rectangles from an array
  fill(153);
  for (int i=0; i<bricks.length; i+=2) {
    PVector v1 = bricks[i];
    PVector v2 = bricks[i+1];
    rect(v1.x, v1.y, v2.x, v2.y);
  }

  //for (PVector v : bricks) {
    //rect(v.x, v.y, v.x, v.y);
  //}
}

void drawText(){
  text(mode,-30,30);
  text(rAcc,-75,-75);
  text(sAcc,-75,0);
  text(pAcc,0,-75);
}

void drawBalls(){
  //for(int i=0; i<=9; i++){
    //ellipse( balls[0,i], balls[1,i], ballDiameter, ballDiameter);
  //}
  fill(0,127,0);
  stroke(0,127,0);
  
  // The syntax only applies when iterating
  // over an existing array 
  for (PVector v : vectors) {
    ellipse(v.x, v.y, ballDiameter, ballDiameter);
  }

    //ellipse(0.5*width,0.5*height, ballDiameter, ballDiameter);
}

void linePlot(float a1,float b1,float a2,float b2,float dir2,float xb,float yb){
  for (int i=0; i<=19; i++) {
    int y= (int)(a1*50*i+b1);
    if(((dir2==0 || dir2==3) && i*50 > xb) || ((dir2==1 || dir2==2) && i*50 < xb)) { 
      ellipse(i*50,y,10,10);
    }
    
    int x= (int)(a2*50*i+b2);
    if(((dir2==0 || dir2==1) && i*50 > yb) || ((dir2==2 || dir2==3) && i*50 < yb)) { 
      ellipse(x,i*50,10,10);
    }

    //if((dir2==0 && a1>0) || (dir2==1 && a1>0) || (dir2==2 && a1>0) || (dir2==3 && a1>0)) {
    //}
    //print(dir2,"_");
  }
}

void anglePlot(float a) {
  for(int i=0; i<50; i++){
    int x=(int)(cos(a)*i*50);
    int y=(int)(sin(a)*i*50);
    ellipse(x,y,10,10);
  }
}
