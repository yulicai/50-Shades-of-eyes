

String macbook_yuli = "192.168.0.7";

//setup loop
void setup() {
  frameRate(30);
  //canvas 200 px wide x 200 px high
  //3D renderer
  size(200, 200, P3D);

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
    trailingJointPositions.get(i).x *=kinectScaling; 
    trailingJointPositions.get(i).x /=trailingJointPositions.get(i).z;
    trailingJointPositions.get(i).x = (int)trailingJointPositions.get(i).x;
  }
  println(trailingJointPositions);
  textSize(32);
  fill(255, 0, 0);
  strokeWeight(3);
  text(usersNum, 10, 30);


  sendToYuli();
}