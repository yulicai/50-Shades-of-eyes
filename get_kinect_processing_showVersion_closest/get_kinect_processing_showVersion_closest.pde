

String macbook_yuli = "172.16.248.241";

//setup loop
void setup() {
  frameRate(30);
  //canvas 200 px wide x 200 px high
  //3D renderer
  size(800, 800, P3D);

  //function for setting up the kinect
  setupKinect();

  //setup OSC communication
  setupOSC();
}

//draw loop
void draw() {
  //green background
  background(0, 255, 0);
  //get data from Kinect
  getKinectData();
  for (int i = 0; i<trailingJointPositions.size(); i++) {
    closestSkeletonPositions.x *=kinectScaling; 
    closestSkeletonPositions.x /=closestSkeletonPositions.z;
    closestSkeletonPositions.x = (int)closestSkeletonPositions.x;
  }
  println(closestSkeletonPositions);
  textSize(64);
  fill(255, 0, 0);
  strokeWeight(3);
  text(usersNum, 30, 60);


  sendToYuli();
}