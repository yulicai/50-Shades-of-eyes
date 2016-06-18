
//import libraries for kinect2
import KinectPV2.KJoint;
import KinectPV2.*;

//declare new kinect object
KinectPV2 kinect;

//declare new array for joints
KJoint[] joints;
//declare new int for index of current joint
int trailingJointIndex;
//declare array for storing the skeletons
ArrayList<KSkeleton> skeletonArray = new ArrayList<KSkeleton>();
//declare array for storing the joint positions
ArrayList<PVector> trailingJointPositions = new ArrayList<PVector>();
// factor for scaling measures
int kinectScaling = 500;


boolean foundUsers = false;
int usersNum = 0;

//function for setting up the kinect
void setupKinect() {
  //constructor method of KinectPV2 class
  kinect = new KinectPV2(this);
  //enable 3D skeleton
  kinect.enableSkeleton3DMap(true);
  kinect.enableBodyTrackImg(true);
  kinect.enableDepthMaskImg(true);
  //initialize the streaming of data
  kinect.init();
}

//get data from Kinect
void getKinectData() {
  usersNum = kinect.getNumOfUsers();
  //translate coordinate system
  pushMatrix();
  translate(width/2, height/2, 0);
  //scale measures
  scale(kinectScaling, kinectScaling, 1);
  rotateX(PI);
  //flip the x positions, so we can perform in between the Kinect and the wall
  rotateY(PI);

  skeletonArray = kinect.getSkeleton3d();
  if (skeletonArray.size() > 0) {
    for (int i = 0; i< skeletonArray.size(); i++) {
      KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
      if (skeleton.isTracked()) {
        joints = skeleton.getJoints();      
        // Get the index number for the joint
        //each index represents one joint
        int trailingJointIndex = getTrailingJointIndex();
        // Retrieve the joint using the index number
        KJoint trailingJoint = joints[trailingJointIndex];
        // Get the PVector containing the xyz position of the joint
        trailingJointPositions.add(trailingJoint.getPosition().copy());
      }
      //keep only the current frame of joints in storage
      while (trailingJointPositions.size()>usersNum) {
        trailingJointPositions.remove(0);
      }
    }
  }


  popMatrix();
}

int getTrailingJointIndex() {

  return KinectPV2.JointType_Head;
}