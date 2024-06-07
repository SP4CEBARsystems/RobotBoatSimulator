void motionPhysics(){
//M O T I O N   P H Y S I C S

  //in the real robot, try to model the physics accurately, the same format can still be used, but all constants (variables that don't change in the loop) have to be calculated with physics
  //acceleration
  int acc=0;
  //straight acceleration
  //sAcc=0.01;
  //perpendicular acceleration
  //pAcc=0;
  //pAcc=-0.01;
  //sAcc=0;

  //rAcc=-0.0;
  //0.0001
  //rAcc=-0.0001;

  float rMaxMotorPower = 0.0001;
  float sMaxMotorPower = 0.05;
  //float rMaxMotorPower = 0.001;
  //float sMaxMotorPower = 0.5;
  float pMaxMotorPower = sMaxMotorPower;

  float rDrag = 0.01;
  float lDrag = 0.01;
  //float rDrag = 0.1;
  //float lDrag = 0.1;

  //motors aren't infinitely powerful, so the forces are made limited here
  rAcc = constrain(rAcc,-rMaxMotorPower,rMaxMotorPower);
  sAcc = constrain(sAcc,-sMaxMotorPower,sMaxMotorPower);
  pAcc = constrain(pAcc,-pMaxMotorPower,pMaxMotorPower);

  //rAcc-=waterDrag*sgn(rVel)*sq(rVel);  
  rAcc-=rDrag*rVel;
  //rotation matrix to map the motor forces to the cartesian axis forces
  //drag in water, a squared number loses it's sign, which is bad for a vector like this
  //the velocity squared puts the system out of balance and causes drag-acc-vel oscillations, and that's bad 
  //(more vel -> more drag -> less acc -> less vel -> less drag -> more acc -> more vel)
  xAcc = sAcc*cos(rota)+pAcc*sin(rota) -lDrag*xVel;  //-waterDrag*sgn(xVel)*sq(xVel);
  yAcc = sAcc*sin(rota)-pAcc*cos(rota) -lDrag*yVel;  //-waterDrag*sgn(yVel)*sq(yVel);
  //real world isn't perfect: random forces are added
  //randomForces(0.001, 0.001, 0.000001);
  //randomForces(0.01, 0.01, 0.00001);
  //randomForces(0.1, 0.1, 0.0001);

  //velocity
  xVel+=xAcc;
  yVel+=yAcc;
  rVel+=rAcc;
  
  //position
  yPos+=yVel;
  xPos+=xVel;
  rota+=rVel;

  //print(sAcc*cos(rota)+pAcc*sin(rota) -waterDrag*sgn(xVel)*sq(xVel),"");
  //print(sAcc*cos(rota)+pAcc*sin(rota),"");
  //print(-waterDrag*sgn(xVel)*sq(xVel),"");
  //print(sgn(xVel)*sq(xVel),"");
  //sq(xVel) is 1,9,1,9,1,9
  //print(sq(xVel),"");
  //print(sgn(xVel),"");
  //xAcc is -2,2,-2,2,-2,2 which explains a lot
  //print(xAcc,"");
  //xVel is literally 1,3,1,3,1,3
  //print(xVel,"");
  //print(yVel,"");
  //print(xPos,"");
  //print(yPos,"");
  
  
  //loop
  if(yPos < 0) {
    yPos = 0;
    //yPos = height;
  }else if(yPos > height) {
    yPos = height;
    //yPos = 0;
  }
  if(xPos < 0) {
    xPos = 0;
    //xPos = width;
  }else if(xPos > width) {
    xPos = width;
    //xPos = 0;
  }
  
  textSize(64);
  //text(rota/PI,100,100);


  //draw vessel
  rectMode(CORNER);
  fill(153);
  stroke(0,0,0);
  translate(xPos, yPos);
  rotate(rota);
  rect(-vesWidth, -vesHeight, 2*vesWidth, 2*vesHeight);

  stroke(255,0,0);


  //draw all proximity detector rays
  for(int i=0; i<=9; i++){
    PVector v = sensorPos[i];
    proximityDetector(xPos, yPos,v.x,v.y,rota,sensorAng[i],i,rayLen);
  }

  rDir = controlSoftware(xPos,yPos,rota,rayLen);
  //rDir=-1;
  //xMemR, yMemF, yMemB, rMem, yLen
  

  //the boatdriver function is called with taget values:
  //(target rotation, target right-distance, target front-distance, minimal back-distance
  //use the wall value to keep track of the walls and directions





  //neutral=true;
  //wall=-1;
  //println(2*rMem/PI);
  //int wallDist = 150;
  //boolean FrontOrBack = true;
  //boolean neutral = false;
  measureVel();
  //FrontOrBack
  boolean progress = boatDriver(wall*HALF_PI, wallDist,wallDist,wallDist, true,neutral) != 0;
  //if(frameCount%10==0){
    //println(progress<0.051 && abs(xVel)<1 && abs(yVel)<1 && abs(rVel)<0.1,  progress<1,abs(xVel)<1, abs(yVel)<1,abs(rVel)<0.1,  mode, wall, progress, xVel, yVel, rVel);
  //}
  //the water drag, the motor forces, and these tolerances, have to be in balance
  //otherwise the vessel will just bounce around the target forever
  if(progress && abs(xVel)<0.1 && abs(yVel)<0.1 && abs(rVel)<0.0005) {
    //use a switch statement (switch(mode))
    //print("SWITCH TO");
    if(mode==0){
      //println("M1");
      //set mode to "rotation mode"

      wall--;
      neutral=true;
      mode=1;

      //call calibrate();
    } else {
      //println("M0");
      //set mode to "drive forward mode"
      neutral=false;
      mode=0;
      //call calibrate();
    }
  }
  
  //switch(mode) {
  //set the mode and wall values inside the function
  //case 0:
  //boatDriver();
  //case 1:
  //boatDriver();
  //case 2:
  //boatDriver();
  //case 3:
  //boatDriver();
  //case 4:
  //boatDriver();
  //}

  //rAcc=0;
  //sAcc=0;
  //pAcc=0;

  //cruiseControl();
  //rAccTest += 0.005* (-0.01 + rVelMeasure);
  //rAccTest += 1* (-0.001 - rVel);
  //println(0.0001 - rVel, rVel);
  //sAccTest += 0.005* cruiseControl(1, 0, sVelMeasure);
  //rAcc=rAccTest;
  //pAcc=0;
  //sAcc=sAccTest;
  //sAcc=2.5;
  //println(sVelMeasure);
}

void randomForces(float xNoise, float yNoise, float rNoise) {
  //perhaps use xAcc, yAcc
  xAcc += random(-xNoise, xNoise);
  yAcc += random(-yNoise, yNoise);
  rAcc += random(-rNoise, rNoise);
}
