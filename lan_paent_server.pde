import processing.net.*;

int port = 5510;
boolean paentServerRun = true;
int bgColor = 0;
int direction = 1;
int textLine = 60;
String msg = "";

Server paentServer;

void setup()
{
  size(400, 400);
  textFont(createFont("SanSerif", 16));
  paentServer = new Server(this, port); // Starts a paentServer on port 10002
  background(0);
}

void mousePressed()
{
paentServer.write("M#SERVER> ROT EBAL");
}

void draw()
{
  if (paentServerRun == true)
  {
    //text("server", 15, 45);
    Client thisClient = paentServer.available();
    if (thisClient != null) {
      if (thisClient.available() > 0) {
        msg = thisClient.readString();
        paentServer.write(msg);
        background(0);
        text(msg,20,20);
        
      }
    }
  } 
  else 
  {
    //text("server", 15, 45);
    //text("stopped", 15, 65);
  }
}
