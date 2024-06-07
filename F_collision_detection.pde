void proximityDetector(float xb,float yb,float x1l,float y1l,float rot,float lrot, float addr,int rayLen){
//P R O X I M I T Y   S E N S O R S
  //lesson: try to avoid using atan or atan2 and always try to use angles instead of dy/dx

  //known bugs:
  //there's always one ball at the top-left where intersections aren't detected
  //it might be possible for intersections sometimes not to be detected between certain rays and certain objects

  //calculate the absolute sensor position using the rotation matrix
  float x1 = xb + x1l * cos(rot) - y1l * sin(rot);
  float y1 = yb + x1l * sin(rot) + y1l * cos(rot);
  //if (addr==1) {
    //print(xb,"");
    //print(yb,"");
    //print(x1,"");
    //print(y1,"");
  //}

  //angles
  float ang1= radians(lrot);
  float ang = ang1 + rot;

  //ray end coordinate, relative to unrotated base
  int x2l = (int)(x1l + cos(ang1) * rayLen);
  int y2l = (int)(y1l + sin(ang1) * rayLen);

  //direction
  float dir = tan(ang);

  //angle quadrant
  int dir2= floor(ang/HALF_PI) & 3;

  //preparations for "y=a1*x+b1" and "x=a2*y+b2"
  float a1=dir;
  float b1=y1-dir*x1;
  float a2=1/dir;
  float b2=-b1/dir;

  fill(0);
  rotate(-rot);
  translate(-xb, -yb);

  int dist = rayLen;
  
  //if (addr==1) {
    //print(round(dist),"");
  //}

  //B O X   C H E C K
  PVector v1;
  PVector v2;
  for (int i=-2; i<bricks.length; i+=2) {
    if(i>=0){
      v1 = bricks[i];
      v2 = bricks[i+1];
    } else {
      v1 = new PVector(border,border);
      v2 = new PVector(width-2*border,height-2*border);
      //PVector v1 = new PVector(10,10);
      //PVector v2 = new PVector(600,600);
    }
    //ellipse(v1.x,v1.y, 10,10);
    //ellipse(v1.x+v2.x,v1.y+v2.y, 10,10);
    int v2x= (int)(v1.x+v2.x);
    int v2y= (int)(v1.y+v2.y);
    //ellipse(v2x,v2y, 10,10);

    //remove the "addr": it is only used for debugging
    dist= min(dist, checkBox(a1,b1,v1.x,v1.y,v2y,dir2==0||dir2==3,dir2==1||dir2==2,xb,true ,x1,y1  ,addr));
    dist= min(dist, checkBox(a1,b1,v2x, v1.y,v2y,dir2==0||dir2==3,dir2==1||dir2==2,xb,true ,x1,y1  ,addr));
    dist= min(dist, checkBox(a2,b2,v1.y,v1.x,v2x,dir2==0||dir2==1,dir2==2||dir2==3,yb,false,x1,y1  ,addr));
    dist= min(dist, checkBox(a2,b2,v2y, v1.x,v2x,dir2==0||dir2==1,dir2==2||dir2==3,yb,false,x1,y1  ,addr));

    //PVector h4 = 
    //rectv(v1.x, v1.y, v2.x, v2.y);
  }

  //if (addr==1) {
    //print(round(dist),"");
  //}

  //dist=0
  
  //int dist = rayLen;
  //points

  //B A L L   C H E C K
  for (PVector v : vectors) {
    //ellipse(v.x,v.y, 10,10);
    //ellipse(x1,y1, 10,10);
    //ellipse( (v.x-x1), (v.y-y1), 10,10);
    //if (( abs( dir*(v.x-x1) -(v.y-y1) +b1 ) / sqrt( 1+dir^2 )) <= (ballDiameter/2) && true) {
    if (( abs( dir*(v.x) -(v.y) +b1 ) / sqrt( 1+dir*dir )) <= (ballDiameter/2) && ((v.x>x1&&(dir2==0||dir2==3)) || (v.x<x1&&(dir2==1||dir2==2)))) {
      //int di=dist(1,1,2,2);
      //dist = min(dist, dist(1,1,2,2));
      //dist = min(dist, dist(v.x,v.y,x1,y1));
      //dist = min(dist, sqrt( (v.x-x1)^2 + (v.y-y1)^2 ));
      //dist = sqrt( sq(v.x-x1) + sq(v.y-y1) )
      dist = (int)(min(dist, sqrt( sq(v.x-x1) + sq(v.y-y1) )));
      ////print( sqrt( (v.x-x1)^2 + (v.y-y1)^2 ),"_" );
      
      //view absolute ball-ray intersection coordinates
      //ellipse(v.x,v.y,10,10);
    }
  }
  //int dist=100;
  float mdx=cos(ang1);
  float mdy=sin(ang1);
  //print(ang);

  //if (addr==1) {
    //print(round(dist),"");
  //}
  
  sensors[(int)addr]=dist;

  translate(xb, yb);
  rotate(rot);
  
  //view plotted distance values
  //ellipse(x1l+mdx*dist*1, y1l+mdy*dist*1, 10,10);
  stroke( constrain(dir2*40+100,0,255));
  fill(255,0,0);
  textSize(10);
  //text(dir2,x1l,y1l)
  text(dist,x1l,y1l);
  line(x1l,y1l,x2l,y2l);
}

int checkBox(float a,float b,float x,float y1,float y2,boolean c1,boolean c2,float xb,boolean d,float bx,float by,float i) {
  int y=(int)(a*x+b);
  // && a>=0
  if (y>=y1 && y<=y2 && ((c1 && x>xb) || (c2 && x<xb))) {
    //return PVector(x,y);
    if(d==true){
      //if (i==1) {
        //print(round(dist(x,y,bx,by)),"");
        //print(x,"");
        //print(y,"");
        //print(bx,"");
        //print(by,"");
        //after going deeper and deeper into the code I discovered that the 3-1-3-1 problem has to do with the coordinates of the vessel
      //}
      //view absolute box-ray intersection coordinates
      //ellipse(x,y,10,10);
      return (int)dist(x,y,bx,by);
    } else {
      //view absolute box-ray intersection coordinates
      //ellipse(y,x,10,10);
      return (int)dist(y,x,bx,by);
    }
  } else {
    return 10001;
  }
}

PVector hitCoords(int n,int xb,int yb,int rot) {
  PVector v = sensorPos[n];
  float a = sensorAng[n];
  float d = sensors[n];

  //calculate sensor position using the rotation matrix
  float x1 = xb + v.x * cos(rot) - v.y * sin(rot);
  float y1 = yb + v.x * sin(rot) + v.y * cos(rot);
  
  //ellipse(xb,yb,10,10);
  //ellipse(x1,y1,10,10);
  //angles
  float ang1 = radians(a);
  float ang = ang1 + rot;
  int xo = (int)(x1+cos(ang)*d);
  int yo = (int)(y1+sin(ang)*d);
  //ellipse(xo,yo,10,10);
  return new PVector(xo,yo);
}
