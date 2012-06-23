/**
 * Chat Server 
 * by Tom Igoe. 
 * 
 * Press the mouse to stop the server.
 */
 

import processing.net.*;

int port = 8888;
boolean myServerRunning = true;
int bgColor = 0;
int direction = 1;
int textLine = 60;
String list_of_tags[] = { "1S4", "1A25", "1A23", "1A21", "1A20", "1A18", "1A12", "1A3", "1S1"};

Server myServer;

void setup()
{
  size(400, 400);
  textFont(createFont("SanSerif", 16));
  myServer = new Server(this, port); // Starts a myServer on port 10002
  background(0);
}

void mousePressed()
{
  myServer.write("OK\r\n"); 
}

void draw()
{
  if (myServerRunning == true)
  {
    text("server", 15, 45);
    Client thisClient = myServer.available();
    if (thisClient != null) {
      if (thisClient.available() > 0) {
        String message = thisClient.readString();
        
        // Look for OK commands
        for (int i = (list_of_tags.length -1); i>=0; i--) {
          String[] tag = match(message, list_of_tags [i]);
          if (tag != null) {
            send_ok (); 
            print(list_of_tags [i]);
            println(" - OK!");
          } 
        }
        
        String[] tagC = match(message, "1C");
        if (tagC != null) {
            send_configurtion ();
            print("1C*");
            println(" - OK!");
        } 
        String[] tagP = match(message, "1P");
        if (tagP != null) {
            send_positions ();
            print("1P*");
            println(" - OK!");
        } 
        
        //text("mesage from: " + thisClient.ip() + message " : " + , 10, textLine);
        textLine = textLine + 20;
      }
    }
  } 
  else 
  {
    text("server", 15, 45);
    text("stopped", 15, 65);
  }
}

void send_ok () {
  myServer.write("OK\r\n"); 
}

void send_configurtion () {
  myServer.write("C1\r\n");
  myServer.write("250\r\n");
  myServer.write("C2\r\n");
  myServer.write("250\r\n");
  send_ok ();
}

void send_positions () {
  for (int i = 0; i <= 40; i++) {
    String[] temp_text = new String[3];
    temp_text [0] = "P" ;
    temp_text [1] = nf(i,2) ;
    temp_text [2] = "\r\n" ;
    String joinedTemp = join(temp_text, ""); 
    myServer.write(joinedTemp);
    myServer.write("123\r\n");
    myServer.write("234\r\n");
    myServer.write("456\r\n");
    myServer.write("567\r\n");
    print(joinedTemp);
  }
  send_ok ();
}




