void defineObjects(){
//define balls
  for (int i = 0; i < vectors.length; i++) {
    vectors[i] = new PVector(random(width),random(height));
  }
  //randomize balls
  //for(int i=0; i<=9; i++){
    //balls[0,i] = random(width);
    //balls[1,i] = random(height);
  //}

  //define blocks
  //top blocks
  for(int i=0; i<=2; i++){
    rectCoords(i,(i+1)*200,10,blockWidth,blockHeight);
  }

  //bottom blocks
  for(int i=0; i<=2; i++){
    rectCoords(i+3,(i+1)*200,height-10-blockHeight,blockWidth,blockHeight);
  }

  //center blocks
  for(int i=0; i<=2; i++){
    rectCoords(i+6,(i+1)*200,0.5*(height-block2Height),block2Width,block2Height);
  }


  
  //define front proximity detector rays
  for(int i=0; i<=2; i++){
    sensorPos[i] = new PVector(vesWidth, (i-1)*fDetectorSpacing);
    //rayLen, (i-1)*fDetectorSpacing
  }

  //define right proximity detector rays
  for(int i=0; i<=2; i++){
    sensorPos[i+3] = new PVector((i-1)*0.75*vesWidth, vesHeight);
    //(i-1)*0.75*vesHeight, rayLen
  }

  //define back proximity detector rays
  for(int i=0; i<=1; i++){
    sensorPos[i+6] = new PVector(-vesWidth, (-0.75+i*1.5)*vesHeight);
    //-rayLen, (-0.75+i*1.5)*vesHeight
  }

  //define diagonal proximity detector rays
  sensorPos[8] = new PVector(vesWidth, vesHeight);
  //rayLen, rayLen
  sensorPos[9] = new PVector(vesWidth, -vesHeight);
  //rayLen, -rayLen
}

void rectCoords(int i,int x,float y,int w,int h){
  bricks[i*2] = new PVector(x,y);
  bricks[i*2+1] = new PVector(w,h);
  //print(x,y,"_")
}
