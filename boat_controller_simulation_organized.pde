//position and rotation
float yPos = 500.0;
float xPos = 100.0;
float rota = 0.0;
//replace rota with rVal

//velocity
float yVel = 0.0;
float xVel = 0.0;
float rVel = 0.0;

//acceleration
float Acc = 0.0;
float sAcc = 0.0;
float pAcc = 0.0;
float xAcc = 0.0;
float yAcc = 0.0;
float rAcc = 0.0;

float sAccTest = 0.0;
float rAccTest = 0.0;

//memorized position and rotation
float xMemR = 0.0;
float yMemF = 0.0;
float yMemB = 0.0;
float rMem = 0.0;
float yLen = 0.0;

float rVelMeasure = 0.0;
float sVelMeasure = 0.0;
float pVelMeasure = 0.0;

float rPrev = 0.0;
float sPrev = 0.0;
float pPrev = 0.0;

//sync status
int noSync = 4;
int angSync = 0;
int rSync = 0;
int fSync = 0;
int bSync = 0;

//robot control mode
int mode = 0;
int wall = 0;

//constants
int rDir = 1;

int rayLen = 10000;
int vesWidth = 20;
int vesHeight = 20;

float waterDrag = 0.5;

int blockWidth = 20;
int blockHeight = 40;
int block2Width = 100;
int block2Height = 50;

int ballDiameter = 8;
int fDetectorSpacing = 5;
int border = 10;

//software variables
int wallDist = 150;
boolean FrontOrBack = true;
boolean neutral = false;
int validSensors = 0;

//first loop (to define local variables, this seems like the only way to do it once)
//set calibration to "not completed yet"
boolean firstFrame = true;

//arrays

//unused array for ball coordinates (but will be used)
//int[] balls = new int[1,9];
//temporary array for ball coordinates
PVector[] vectors = new PVector[9];
//array for brick coordinates
PVector[] bricks = new PVector[18];//used to be 11
//array that holds the distance values measured by the sensors
float[] sensors = new float[10];
//array for the rotations of the sensors relative to the vessel
int[] sensorAng = { 0,0,0, 90,90,90, 180,180, 0,0 };
//array for the sensor positions relative to the vessel
PVector[] sensorPos = new PVector[10];
//array for the pre processed distance values measured by the sensors
PVector[] sample = new PVector[10];
//
//ArrayList<float> preSensors = new ArrayList<float>();
FloatList preSensors = new FloatList();
