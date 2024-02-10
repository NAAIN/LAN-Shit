import controlP5.*;
import processing.net.*;

int port = 5510,bgColor = 0,direction = 1;
int textLine = 60;
String msg = "";
boolean paentServerRun = true;
PGraphics pg;
String[] packet = new String[5];
char a;

Server paentServer;
Textarea chatArea;
ControlP5 cp5;

void setup()
{
  windowTitle("УЛЬТРА МЕГА КРУТОЙ СЕРВЕР PAINTа ПО СЕТИ111!!!!");
  size(1000, 800);
  textFont(createFont("Hack", 16));
  paentServer = new Server(this, port);
  pg = createGraphics(579, 551);
  cp5 = new ControlP5(this);    
  background(0);
  pg.beginDraw();
  pg.background(color(255,255,255,255));
  pg.endDraw();
  pg.noStroke();
  image(pg, 10, 20);
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
        text(msg,20,15);
        image(pg, 10, 20);
        
        packet = split(msg,'#');
        switch(char(packet[0].charAt(0))) {
          case 'D':
            DrawDot(int(packet[1]),int(packet[2]),int(packet[3]),float(packet[4]));
            break;
          case 'C':
            chatArea.setText(chatArea.getText() + packet[1] + "\n");
            break;
        }
}}}}

void DrawDot(int x,int y,int Size,float IColor) {
    pg.beginDraw();
    pg.fill(Size);
    pg.rectMode(CENTER);
    pg.square(x,y,IColor);
    pg.endDraw();
    //image(pg, 10, 20);
}
