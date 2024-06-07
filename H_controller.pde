int controlSoftware(float xb,float yb,float rot,int rayLen){
//C O N T R O L   S O F T W A R E
  //front (0-2)
  //sensors[];
  //diagonal (8-9)
  //sensors[];
  //sensors[];

  //line left (3-5)
  //sensors[];
  //line back (6-7)
  //PVector v1 = sensorPos[6];
  //PVector v2 = sensorPos[7];

  //ellipse(v.x,v.y,10,10);

  //float a1 = sensorAng[6];
  //float a2 = sensorAng[7];
  //float s1 = sensors[6];
  //float s2 = sensors[7];
  //float avg = 0.5*(s1+s2);
  //PVector s1 = hitCoords(6, xb, yb, rot);
  //PVector s2 = hitCoords(7, xb, yb, rot);
  //ellipse(s1.x,s1.y,10,10);
  //ellipse(s2.x,s2.y,10,10);
  //need sensor base coordinates and rotation
  //int s1y=
  //int s2y=
  //int s1x=
  //int s2x=

  //float dir=(s1.y-s2.y)/(s1.x-s2.x);
  //float ang=atan2(dir);
  //   B
  //  /R
  // A--
  
  //the robot doesn't know it's absolute coordinates (it doesn't have a GPS)
  //so it's center coordinate is (0,0) and it's rotation is 0
  //we measure the distance and the angle of the surroundings


  //software goals

  //level 1
  //correct rotation
    //find accurate rotation compared to box
      //use all usable proximity detectors
      //when there are thee in line, calculate three angles for all the combinations
    //track rotation
      //calibrate on startup to determine our rotation
      //track and store the rotation
      //discard angles from sensor data that has a big difference compared to the stored angle
    //correct it to keep it at a target value
  //correct position
    //find distance to the right
    //correct it to keep it at a target value
  //avoid collision
    //find distance at the front
    //rotate 90deg once at the end of the pool
  //track progress
    //find distance to the front and back
    //track it and store it
    //discard any sudden change, or change related to rotations
  //the controller returns neccessary r,x,y to correct to keep the target values, scale the forces depending on the proximity to the target
  //in arduino convert those forces into motor movement

  //write a function to check for a set of parameters if their difference to the input is more than a predefined tolerance, and calculate and return the average of the remaining parameters, if no parameters are usable, then it'll return the input value or it may be better to return some sort of a predefined error code (something like -100000), or it could return the number of usable sensor values, it reads from a flexible array with array.length, or with the special array for loop, the array is first filled with angles, then with side distances, and then with front distances, and then with back distances, the margin variable is changed whenever it's at the end and it has to do the 90 deg turn
    //this function is used to turn the rotation and the position sensor inputs into more reliable values
  //mode variable
    //0 stabilize, stationary
    //1 go forward until a wall is close
    //2 turn 90 degrees
    //3 scan left
    //4 scan right
  //scan angle variable
    //holds our current angle minus the angle stored before the scanning started
    //is used to return the position if scanning would bring it out of sync, if the combining function returns an error: it can use it to guess the orientation

  //level 2
  //detect obstacles
  //find distance to the detected obstacle
  //find direction of the detected obstacle (left, right, or straightahead)
  //correct the course

  //level 3
  //detect balls
  //find distance to the detected ball
  //find direction of the detected ball (left, right, or straightahead)
  //correct the course

  //generate relative coordinates
  for (int i=0; i<=9; i++) {
    sample[i] = hitCoords(i, 0, 0, 0);
    //plot relative coordinates
    ellipse(sample[i].x,sample[i].y,10,10);
  }

  

  //PVector s1 = sample[6];
  //PVector s2 = sample[7];
  //float ang = getAngle(s1,s2);

  //calibration
  if (firstFrame==true) {
    //calibration(-1);
    rMem = getAngle(6,7);
    xMemR = (sensors[3] + sensors[4] + sensors[5])/3;
    yMemB = (sensors[6] + sensors[7])/2;
    yMemF = (sensors[0] + sensors[1] + sensors[2])/3;
    yLen = yMemF + yMemB;
    //print("HI");
    //println(xMemR);
    //println(sample[3],sample[4],sample[5],"/3");
    //println(sensors[3],sensors[4],sensors[5],"/3");
    //println(sensors[3]);
  }
  //xMemR, yMemF, yMemB, rMem, yLen

  textSize(10);

  //preSensors.size() = 0;
  //preSensors=0;
  preSensors.clear(); 

  //the preSensors array is never reset, how do I reset it?, also what does "add" do?, should I use "append" instead?

  //front
  preSensors.append( getAngle(0,1) );
  preSensors.append( getAngle(1,2) );
  preSensors.append( getAngle(0,2) );

  preSensors.append( getAngle(8,9) );
  preSensors.append( getAngle(0,8) );
  preSensors.append( getAngle(2,9) );
  //right
  preSensors.append( getAngle(3,4) );
  preSensors.append( getAngle(4,5) );
  preSensors.append( getAngle(3,5) );
  //back
  preSensors.append( getAngle(6,7) );

  //println(preSensors.size());


  //perhaps I could make an "all combinations" function which would take one base value N and run the getAngle function with the combinations: {N,N+1},{N+1,N+2},{N,N+2}


  // this bit of code is repeated 4x, it should be put into a function (put it into the sensorcorrector)
  float ang = sensorCorrector(rMem,0.02,true);
  //println(ang);
  //if(typeof rMem === 'undefined' || isNaN(ang)) {
  ////if(typeof ang === 'NaN') {
  //  //println("gottem");
  //  //println("");
  //  //println("");
  //} else {
    //println("nope");
    rMem = ang;
    if (validSensors==0) {
      angSync++;
      //angSync
      //rSync
      //fSync
      //bSync
      if (angSync>=noSync) {
        calibration(0);
      }
    }
  //}
  //print(ang,"");

  //temporary (to test new angles)
  //ang = getAngle(6,7,sample[6],sample[7]);

  //ellipse(s1.x,s1.y,10,10);
  //ellipse(s2.x,s2.y,10,10);
  //stroke(255,0,0);
  //line(s1.x,s1.y,s2.x,s2.y);

  //our local angle-finding method
  //float dir = (s1.x - s2.x) / (s1.y - s2.y);
  //float ang = atan(dir);

  //print(dir,"");

  //float ang = acos(abs(s1*s2) / mag(s1) * mag(s2));
  //print(ang,"");

  //ang=HALF_PI;
  
  //atan couldn't've been avoided (maybe search on web for "avoid arc tangent")
  //update: unit vectors is the way to go (and then use acos(dx)*sgn(dy))
  //try to use the dotproduct abs(v1*v2)/len(v1)*len(v2)
  //dotproduct x1,y1, x2,y2 = x1*x2 + y1*y2

  //s1.y = a * s1.x + b
  //b = s1.y-a*s1.x

  //the correct B value (but we don't need a line)
  //int b = s1.y-dir*s1.x;

  //return 10
  //linePlot(dir,b,0,0,0,0,0)
  //print(ang);

  //rotate(-rot);
  //translate(-xb, -yb);
  //put absolute coordinates to plot here
  //translate(xb, yb);
  //rotate(rot);

  //plot a line to display the angle
  fill(0,255,0);
  anglePlot(ang);
  fill(255,0,0);


  //yMemF, yLen
  //front
  preSensors.clear(); 
  preSensors.append( sensors[0] );
  preSensors.append( sensors[1] );
  preSensors.append( sensors[2] );
  preSensors.append( sensors[8] );
  preSensors.append( sensors[9] );

  float sFront = sensorCorrector(yMemF,10,false);
  //println(frontS);
  //if(typeof yMemF === 'undefined' || isNaN(sFront)) {
  //  //println("gottem");
  //} else {
    //println("nope");
    yMemF = sFront;
    ellipse(sFront,0,5,20);
    //line(sFront,10,sFront,-10);
    if (validSensors==0) {
      fSync++;
      if (fSync>=noSync) {
        calibration(1);
      }
    }
  //}
  //print(round(sensors[0]),round(sensors[1]),round(sensors[2]),"_");

  //xMemR
  //right
  preSensors.clear(); 
  preSensors.append( sensors[3] );
  preSensors.append( sensors[4] );
  preSensors.append( sensors[5] );

  float sRight = sensorCorrector(xMemR,10,false);
  //println(frontS);
  //if(typeof xMemR === 'undefined' || isNaN(sRight)) {
  //  //println("gottem");
  //} else {
    //println("assign",xMemR,sRight);
    xMemR = sRight;
    ellipse(0,sRight,20,5);
    if (validSensors==0) {
      rSync++;
      if (rSync>=noSync) {
        calibration(2);
      }
    }
  //}
  //println( int(sensors[3]), int(sensors[4]), int(sensors[5]),xMemR,sRight);

  //yMemB, yLen
  //back
  preSensors.clear(); 
  preSensors.append( sensors[6] );
  preSensors.append( sensors[7] );

  float sBack = sensorCorrector(yMemB,10,false);
  //println(frontS);
  //if(typeof yMemB === 'undefined' || isNaN(sBack)) {
  //  //println("gottem");
  //} else {
    //println("nope");
    yMemB = sBack;
    ellipse(-sBack,0,5,20);
    if (validSensors==0) {
      bSync++;
      if (bSync>=noSync) {
        calibration(3);
      }
    }
  //}
  //println( int(sensors[6]), int(sensors[7]), yMemB,sBack);

  //add modes and control
  //return the motor turn direction
  if(ang > 0.25*QUARTER_PI){
    return -1;
  } else if(ang < -0.25*QUARTER_PI) {
    return 1;
  } else {
    return 0;
  }
  //return 0;
}

int boatDriver(float targetAng, float targetDistR, float targetDistF, float targetDistB, boolean FrontOrBack, boolean neutral) {

  //rotation
    //rAcc += 0;

    //rAcc -= 0.1* cruiseControl( sqrtFull(rMem - targetAng), rAcc, -rVelMeasure);

    //rAcc -= 0.1* cruiseControl( sqrtFull(rMem - targetAng), rAcc, rVel);
    rAcc = 0.1*(targetAng - rMem);

    //if(frameCount%180==0){
      //println(((rVelMeasure+rVel)),((rVelMeasure)),((rVel)));
    //}
    //println(rVelMeasure+rVel);
    //println(sgn(rVelMeasure),sgn(rVel));

    //rAcc = 0
    //rAcc =0;
  //if(rMem > targetAng+0.1*QUARTER_PI){
    //rAcc=-0.0001;
  //} else if(rMem < targetAng-0.1*QUARTER_PI) {
    //rAcc=0.0001;
  //} else {
    //rAcc=0;
    //rAcc=0.0001*rAcc/abs(rAcc);
  //}

  if (!neutral) {
    //right distance

    //pAcc -= cruiseControl(0.2* sqrtFull(xMemR - targetDistR), pAcc, pVelMeasure);
    pAcc = 0.1*(targetDistR - xMemR);

    //if(xMemR > targetDistR+10){
      //pAcc=-0.01;
    //} else if(xMemR < targetDistR-10) {
      //pAcc=0.01;
    //} else {
      //pAcc=0;
      //pAcc=0.01*(pAcc)/abs(pAcc);
    //}
    //println(rDir,pAcc,xMemR);

    if(FrontOrBack) {
      //front distance

      //sAcc += cruiseControl(0.2* sqrtFull(yMemF - targetDistF), sAcc, sVelMeasure);
      sAcc = 0.1*(yMemF - targetDistF);

      //println(sAcc);
      //println(yVel);
      //if(yMemF > targetDistF+10){
        //sAcc = 0.02;
      //} else if(yMemF < targetDistF-10) {
        //sAcc = -0.02;
      //} else {
        //sAcc=0;
        //sAcc=0.02*(sAcc)/abs(sAcc);
      //}
      //println(rDir,sAcc,yMemF);

    } else {
      //back distance
      //sAcc += cruiseControl(0.0005* sqrtFull(targetDistB - yMemB), sAcc, sVelMeasure);
      sAcc = 0.1*(targetDistB - yMemB);
      //if(yMemB > targetDistB+10){
        //sAcc = -0.01;
      //} else if(yMemB < targetDistB-10) {
        //sAcc = 0.01;
      //} else {
        //sAcc=0;
        //sAcc=0.01*(sAcc)/abs(sAcc);
      //}
      //println(rDir,sAcc,yMemB);
    }
  } else {
    pAcc = 0;
    sAcc = 0;
  }
 
  text(0.002* sqrtFull(rMem - targetAng),100,100);
  text(0.2* sqrtFull(yMemF - targetDistF),120,0);
  text(0.2* sqrtFull(xMemR - targetDistR),0,120);

  if(mode==0){
    //drive forward mode
    return abs(yMemF-targetDistF)<20 ? 1 : 0;
    //println(targetDistF,yMemF);
  } else {
    //rotation mode
    return abs(rMem-targetAng)<0.1 ? 1 : 0;
  }


  //if (rDir!=0) {
    //rAcc=0.001*rDir;
  //} else {
    //rAcc=0.0001*(rAcc)/abs(rAcc);
  //}
  //rAcc=0.001*rDir
  //rAcc=-0.0;




  //rotate back and forth
  //if(rMem > 0*0.25*QUARTER_PI+targetAng){
    //rDir = -1;
    //rAcc=-0.0001;
  //} else if(rMem < 0*-0.25*QUARTER_PI+targetAng) {
    //rDir = 1;
    //rAcc=0.0001;
  //} else {
    //rDir = 0;
    //keep sign
    //rAcc=0.0001*rAcc/abs(rAcc);
  //}

  //right distance back and forth
  //if(xMemR > targetDistR+0*50){
    //rDir = -1;
    //pAcc=-0.01;
  //} else if(xMemR < targetDistR+0*-50) {
    //rDir = 1;
    //pAcc=0.01;
  //} else {
    //rDir = 0;
    //pAcc=0.01*(pAcc)/abs(pAcc);
  //}
  //println(rDir,pAcc,xMemR);

  //back distance back and forth
  //if(yMemB > targetDistB+0*50){
    //rDir = -1;
    //sAcc = -0.01;
  //} else if(yMemB < targetDistB+0*-50) {
    //rDir = 1;
    //sAcc = 0.01;
  //} else {
    //rDir = 0;
    //sAcc=0.01*(sAcc)/abs(sAcc);
  //}
  //println(rDir,sAcc,yMemB);

  //front distance back and forth
  //if(yMemF > targetDistF+1*50){
    //rDir = 1;
    //sAcc = 0.02;
  //} else if(yMemF < targetDistF+1*-50) {
    //rDir = -1;
    //sAcc = -0.02;
  //} else {
    //rDir = 0;
    //sAcc=0.02*(sAcc)/abs(sAcc);
  //}
  //println(rDir,sAcc,yMemF);
}
