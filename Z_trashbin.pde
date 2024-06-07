//T  R  A  S  H

//R A Y   D E F I N I T I O N S
  //draw front proximity detector rays
  //for(int i=0; i<=2; i++){
    //proximityDetector(xPos, yPos,vesWidth, (i-1)*fDetectorSpacing, rayLen, (i-1)*fDetectorSpacing,rota,0,i);
  //}
  
  //draw right proximity detector rays
  //for(int i=0; i<=2; i++){
    //proximityDetector(xPos, yPos,(i-1)*0.75*vesWidth, vesHeight, (i-1)*0.75*vesHeight, rayLen,rota,90,i+3);
  //}
  
  //draw back proximity detector rays
  //for(int i=0; i<=1; i++){
    //proximityDetector(xPos, yPos,-vesWidth, (-0.75+i*1.5)*vesHeight, -rayLen, (-0.75+i*1.5)*vesHeight,rota,180,i+6);
  //}
  
  //draw diagonal proximity detector rays
  //proximityDetector(xPos, yPos, vesWidth, vesHeight, rayLen, rayLen, rota, 45, 8);
  //proximityDetector(xPos, yPos, vesWidth, -vesHeight, rayLen, -rayLen, rota, -45, 9);




//P R O X I M I T Y   D E T E C T O R

  //float dir1= float(y2l-y1l) / ( float(x2l-x1l) + 0.000001 );
  //float ang1= ( float(lrot) * TWO_PI ) / 360.0
  //ang1= atan2(dir1)
  //atan doesn't like inf

  //can't assign a var type
  //dir = dir1 + tan(rot);

  //rota=constrain(rota, -PI, PI);
  //if(ang<0) {ang+=TWO_PI;} else if(ang>TWO_PI) {ang-=TWO_PI;}
  //if (rota<0) {rota=TWO_PI} else if (rota>TWO_PI) {rota=0}

  //if(dir2<0) {dir2=3;} else if(dir2>3) {dir2=0;}
  //dir2=dir2 % 4;
  //dir2 = dir2 & 3;
  //if (dir2 > 1) {print(dir2,"");}

  //dx=dir
  //dy=dir
  //y = dir*(x-x1)+y1
  //y = dir*x+y1-dir*x1
  //x = y/dir -(y1-dir*x1)

  //0 = dir*x -y +y1-dir*x1
  //a1*x -1*y +b1=0


  //x(n)= and y(n)=

  //y(0) = y1-dir*x1
  //y(n) += dir  and  x=n
  
  //dy=yb
  //dx=xb

  //dx=x1
  //dy=y1
  //while( blue( get(dx,dy) ) == 255 ) {
    //dx++
    //dy+=dir
  //}




  //if(dir2!=0 && dir2!=1 && dir2!=2 && dir2!=3) {print(dir2,ang/PI,"_");}

  //text(rota/PI,100,200);
  //text(dir2,300,200);

  //ellipse(x1,y1, 10,10);
  
  //get x = a1 * y + b1 formula
  //get y = a2 * x + b2 formula
  //array for rectangle x1,y1,x2,y2
  //generate y for both x coordinates and check if they lie between the known y coordinates
  //generate x for both y coordinates and check if they lie between the known x coordinates
  //if any of these checks return true then this box is hit
  
  ////variables: a1,b1,a2,b2,x1,y1,x2,y2
  //checkBox(a1,b1,x1,y1,y2) || checkBox(a1,b1,x2,y1,y2) || checkBox(a2,b2,y1,x1,x2) || checkBox(a2,b2,y2,x1,x2)


  //plot ALL inputs, and write a function to plot the line formula
  //plot absolute coordinates, not distances
  //make sure all inputs are right, before debugging these functions

  
  //linePlot(a1,b1,a2,b2,dir2,xb,yb);


  //mathematical intersections between a circle and a line

  //(x-x1)^2 + (y-y1)^2 = r^2
  //y-y1=[+/-]sqrt(sq(r) - sq(x-x1))
  //y=a*x+b
  //a*x+b-y1=[+/-]sqrt(sq(r) - sq(x-x1))
  //sq(a*x+b-y1)=sq(r) - sq(x-x1)
  //sq(a*x+b-y1) + sq(x-x1) - sq(r) = 0
  //(sq(a)+1)*x^2 + (a*(b-y1)-x1)*2*x + sq(b-y1)+sq(x1)-sq(r) = 0
  //a=(sq(a)+1); b=(a*(b-y1)-x1)*2; c=sq(b-y1)+sq(x1)-sq(r);
  //d=sq(b)-4*a*c; x1=(-b+sqr(d))/(2*a); x2=(-b-sqr(d))/(2*a);
  //y1=a*x1+b; y2=a*x2+b;
