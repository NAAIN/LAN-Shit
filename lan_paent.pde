import processing.net.*;
import controlP5.*;
ControlP5 cp5;
Textlabel posText;
ColorPicker cp;
Slider s;
Client paentClient;
Textarea chatArea;
//ConnectBut = Button;
PGraphics pg;
int BColor = 200,port = 5510,x,y,Color;
color col = color(255,255,255,255);
Float Size;
Boolean clRUN = false;
String[] IP = new String[2],packet = {"a","","","",""};
char a;
String chat;

void setup() {
  background(BColor);
  size(1000,600);
  pg = createGraphics(579, 551);
  cp5 = new ControlP5(this);        
  
  cp = cp5.addColorPicker("picker")
  .setPosition(656,55)
  .setColorValue(color(0, 0, 0, 255))
  .setSize(240,100);
          
  s = cp5.addSlider("Brush Size")
  .setPosition(656,118)
  .setRange(0,100)
  .setSize(240,20)
  .setValue(5)
  .setArrayValue(new float[] {50, 50});   
  
  cp5.addButton("connect")
  .setValue(0)
  .setPosition(656,140)
  .setSize(40,20);
  
  cp5.addTextfield("server ip")
  .setPosition(706,140)
  .setText("127.0.0.1:5510")
  .setSize(100,20);
  
  cp5.addTextlabel("promo")
    .setPosition(598,504)
    .setText("Сделал некий NAAIN \nИз недокомпании ООО 'аутизм инк' \nt.me/CHvK_NAAIN \n1209-2030 Все права отданы арабам")
    .setFont(createFont("arial",12))
    ;
    
  chatArea = cp5.addTextarea("chat")
    .setPosition(658,169)
    .setSize(300,300)
    .showScrollbar()
    .scroll(1) 
    .setFont(createFont("arial",12));
  
  pg.beginDraw();
  pg.background(color(255,255,255,255));
  pg.endDraw();
  pg.noStroke();
  image(pg, 10, 10);
}

void draw() {
  background(200);
  image(pg, 10, 10);
  if(clRUN ==  true){
    if (mouseX > 10 & mouseX < 579+10 & mouseY > 10 & mouseY < 551+10 & mousePressed == true) {
     paentClient.write("D#"+(mouseX - 10)+"#"+(mouseY - 10)+"#"+cp.getColorValue()+"#"+s.getValue()+"#;");
    }
  
  if(paentClient.active() == true & paentClient.available() > 0) {  
    packet = split(paentClient.readString(),'#');
    char a = packet[0].charAt(0);
    println(a);
    if(a == 'D') {
        DrawDot(float(packet[1]),float(packet[2]),float(packet[4]),int(packet[3]));
    }
    if(a == 'M') {
        chat = chat + packet[1] + "\n";
        chatArea.setText(chat);
    }
}}}

void connect() {
  IP = split(cp5.get(Textfield.class,"server ip").getText(),":");
  paentClient = new Client(this,IP[0],int(IP[1]));
  clRUN = true;
}

void mouseClicked() {
  println(mouseX,mouseY);
}

void DrawDot(float x,float y,float IColor,int Size) {
    pg.beginDraw();
    pg.fill(Size);
    pg.rectMode(CENTER);
    pg.square(x,y,IColor);
    pg.endDraw();
    image(pg, 10, 10);
}
