float atan3(float dx,float dy){
  //vector-angle calculator using unit vectors
  float l=mag(dx,dy);
  return acos(constrain(dx/l,-1,1)) * sgn(dy/l);
}

//sign function (because processing doesn't have one)
int sgn(float inVal){
  //1*2-1=1 if greater than 0
  //0*2-0=0 if equal to 0
  //0*2-1=-1 if smaller than 0
  return int(inVal>0.0)*2 - int(inVal!=0.0); 
}

float sqrtFull(float inVal) {
  return sgn(inVal) * sqrt( abs(inVal) );
}

//get the angle between two points and the x-axis
float getAngle(int n1,int n2){
  //I could convert these vectors to unit vectors
  //PVector s3 = (s2-s1)/mag(s2-s1);
  //{ 0,0,0, 90,90,90, 180,180, 45,-45 }
  //Front: 0, Back: PI, Right: HALF_PI
  float sa = 0;
  if(sensorAng[n1] == sensorAng[n2]){
    //sa= radians(sensorAng[n1]);
    sa= sensorAng[n1];
    //crappy way to detect if a sensor is pointed to the right
    if(sa % 180 == 0) {
      sa=0;
    } else {
      sa=-HALF_PI;
    }
  } 
  //else {
    //error code (of which there's no detector for) (so I may as well leave it undefined)
    //return -1000
    //but this error will never happen, unless the predefined tables are changed
  //}

  //take the input vectors s1 and s2 and calculate the vector that goes from s1 to s2
  PVector s1=sample[n1];
  PVector s2=sample[n2];
  float x1=s2.x-s1.x;
  float y1=s2.y-s1.y;

  //I could avoid using atan(dy/dx) by making a unit vector, now I'll never divide by zero
  float v = (- atan3(x1,y1) + HALF_PI + sa);
  anglePlot(v);

  //attempt to counter walls by looping them around at 180 degrees
  //if(v<0){
    //v+=PI
  //} else if(v>=PI) {
    //v-=PI
  //}

  //ellipse(0,100*dist(0, 0, s3.x, s3.y),10,10);
  //print(l);
  //ellipse(20*x1,20*y1,10,10);
  //ellipse(s1.x,s1.y,10,10);
  //ellipse(s2.x,s2.y,10,10);
  //ellipse(10*x1,10*y1,10,10);
  //print(floor(degrees(acos(x1))),"");
  //print(sgn(0));
  //float y = asin(s3.y)
  //float v = ...
  //acos(-1) returns PI      and acos(1) returns 0
  //asin(-1) returns -0.5*PI and asin(1) returns 0.5*PI
  //I need to figure out how to determine the final angle value
  //I could supply indexes so that this function can access the sensor rotations and counter that as well
  //float v =

  //float v = atan((s1.x - s2.x) / (s1.y - s2.y))
  text(v,0.4*(s1.x+s2.x) , 0.4*(s1.y+s2.y) );
  return v;
}
