float sensorCorrector(float inVal, float margin, boolean isAngle){
  int n=0;
  float sum=0;
  //add all valid sensor values together
  if(isAngle) {
    for (float v : preSensors) {
    //println(v,"");
    //println(v,inVal);
    //println(abs(v-inVal));

    //make a proper pattern for this, this would propably work:
      //float vA=v-HALF_PI*(int(v/HALF_PI)-int(inVal/HALF_PI));
      float vA=v-HALF_PI*round((v-inVal)/HALF_PI);
      //for(int j=0; j<8; j++){
      //vA=v-HALF_PI*j;
      if(abs(vA-inVal) <= margin) {
        sum += vA;
        n++;
        //println(v,"");
        //break
      }
      //if(frameCount%30==0){ 
        //println(vA-inVal,inVal,vA,v);
        //print(int(inVal/HALF_PI),int(v/HALF_PI));
      //}
      //}

      //v1=v+HALF_PI;
      //v2=v-HALF_PI;
      //v3=v-PI;
      //v4=v-PI-HALF_PI;
      //v5=v-TWO_PI;
      //if (abs(v-inVal) <= margin) {
        //sum += v;
        //n++;
        //rMem is not updating
        //println(v,"");
      //} else if (abs(v1-inVal) <= margin) {
        //sum += v1;
        //n++;
      //} else if (abs(v2-inVal) <= margin) {
        //sum += v2;
        //n++;
      //} else if (abs(v3-inVal) <= margin) {
        //sum += v3;
        //n++;
      //} else if (abs(v4-inVal) <= margin) {
        //sum += v4;
        //n++;
      //} else if (abs(v5-inVal) <= margin) {
        //sum += v5;
        //n++;
      //}
      }
    } else {
      for (float v : preSensors) {
        if(abs(v-inVal) <= margin) {
          //not an angle and valid
          sum += v;
          n++;
        }
      }
    }
  //}
  //println("");
  //print(n,"");

  validSensors = n;

  //return the average sensor value
  if(n>0){
    return sum/n;
  } else {
    return inVal;
  }
}

void calibration(int type) {
  //switch(rMem) {
    //case 0:
  if(type==0){
    rMem = getAngle(6,7);
    //case 1:
  } else if(type==2){
    xMemR = (sensors[3] + sensors[4] + sensors[5])/3;
    //case 2:
  } else if(type==3){
    yMemB = (sensors[6] + sensors[7])/2;
    //case 3:
  } else if(type==1){
    yMemF = (sensors[0] + sensors[1] + sensors[2])/3;
  }
  //}
    //yLen = yMemF + yMemB
}

float cruiseControl(float targetVel, float forceNow, float velNow) {
  //return targetVel*50;
  //return targetVel-forceNow;
  return targetVel - velNow;
}

void measureVel() {
  //velocity is distance per time, assume time=1/60s
  //dt=1/60;
  rVelMeasure=(rPrev-rMem);  ///dt;
  sVelMeasure=(sPrev-yMemF);  ///dt;
  pVelMeasure=(pPrev-xMemR);  ///dt;
  textSize(15);
  text(rVelMeasure,75,75);
  text(sVelMeasure,75,0);
  text(pVelMeasure,0,75);
  //rVelMeasure=0;
  //sVelMeasure=0;
  //pVelMeasure=0;
  //if(frameCount%10==0){
    //println(yMemF-sPrev,yMemF,sPrev);
    //print(round(yMemF-sPrev),round(yMemF),"_");
    //print((yMemF-sPrev),"");
  //}

  rPrev=rMem;
  sPrev=yMemF;
  pPrev=xMemR;

  //text(rVelMeasure,-100,-100);
  //text(pVelMeasure,0,-100);
  //text(sVelMeasure,-100,0);
  if(firstFrame){
    rVelMeasure=0;  ///dt;
    sVelMeasure=0;  ///dt;
    pVelMeasure=0;  ///dt;
  }
}
