//import osc libraries for communication
import oscP5.*;
import netP5.*;

//declare objects for communication
OscP5 oscP5;
NetAddress oscToYuli;
NetAddress oscToProcessing;



//declare strings for sending messages
String[] oscPos = {
  "/x", 

};

void setupOSC() {

  //receive
  //start oscP5, listening for incoming messages at port 5555
  oscP5 = new OscP5(this, 5555);

  /* myRemoteLocation is a NetAddress. a NetAddress  takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  //send
  oscToYuli = new NetAddress(macbook_yuli, 1993);
}

//master function to send OSC to macbook
//send as many OSC messages as users present
void sendToYuli() {

  String header = "/userIndex";

  //send the total number of users
  OscMessage totalNumber = new OscMessage("/userNumber");
  totalNumber.add(usersNum);
  oscP5.send(totalNumber, oscToYuli);
  //send message just if there are users
  if (usersNum > 0) {
    //send as many OSC messages as users presents
    for (int i = 0; i<usersNum; i++) {

      //usersNumber tag to signal how many users are present
      OscMessage sendingMessage = new OscMessage(header);

      //append the user number +1
      //to count from 1 not from 0
      sendingMessage.add(i+1);
      //append the users x position
      sendingMessage.add(trailingJointPositions.get(i).x);
   
      //send the message
      oscP5.send(sendingMessage, oscToYuli);
    }
  } 

}