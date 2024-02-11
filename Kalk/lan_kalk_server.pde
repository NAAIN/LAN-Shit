import controlP5.*;
import processing.net.*;

int port = 5510;
float Result = 0;
String msg = "";
boolean KalkServerRun = true;
String[] packet = new String[5];
char a;

Server KalkServer;
Textarea chatArea;
ControlP5 cp5;
Textlabel ServerFormula;

void setup()
{
  windowTitle("УЛЬТРА МЕГА КРУТОЙ СЕРВЕР КАЛЬКА ПО СЕТИ111!!!!");
  size(1200, 800);
  textFont(createFont("Hack", 16));
  KalkServer = new Server(this, port);
  cp5 = new ControlP5(this);
  background(200);
  createGUI();
}

void mousePressed()
{
KalkServer.write("M#SERVER>ROT EBAL");
}

void draw()
{
  background(200);
  if (KalkServerRun == true)
  {
    //text("server", 15, 45);
    Client thisClient = KalkServer.available();
    if (thisClient != null) {
      if (thisClient.available() > 0) {
        msg = thisClient.readString();
        //KalkServer.write(msg);
        background(200);
        text(msg,20,15);
        packet = split(msg,'#');
    char a = packet[0].charAt(0);
    switch(a) {
      case 'M':
        chatArea.setText(chatArea.getText() + packet[1] + "\n");
        break;
      case 'P':
        Result += float(packet[1]);
        ServerFormula.setText(str(Result));
        KalkServer.write("F#"+str(Result)+"#;");
        break;
      case 'D':
        Result -= float(packet[1]);
        ServerFormula.setText(str(Result));
        KalkServer.write("F#"+str(Result)+"#;");
        break;
      case 'd':
        Result /= float(packet[1]);
        ServerFormula.setText(str(Result));
        KalkServer.write("F#"+str(Result)+"#;");
        break;
      case 'm':
        Result *= float(packet[1]);
        ServerFormula.setText(str(Result));
        KalkServer.write("F#"+str(Result)+"#;");
        break;
    }
}}}}

void createGUI() {
  chatArea = cp5.addTextarea("chat")
  .setPosition(20,40)
  .setSize(1170,750)
  .showScrollbar()
  .scroll(1) 
  .setColorBackground(0)
  .setFont(createFont("Hack",12)); 
  ServerFormula = cp5.addTextlabel("ServerFormula")
  .setText("0")
  .setPosition(20,20)
  .setColorForeground(color(255,255,255))
  .setFont(createFont("Hack",15));
}
