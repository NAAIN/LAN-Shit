import processing.net.*;

int port = 5510,bgColor = 0,direction = 1;
int textLine = 60;
String msg = "";
boolean paentServerRun = true;
PGraphics pg;

Server paentServer;

void setup()
{
  size(1000, 800);
  textFont(createFont("SanSerif", 16));
  paentServer = new Server(this, port);
  background(0);
}

void mousePressed()
{
paentServer.write("M#SERVER>ROT EBAL");
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
