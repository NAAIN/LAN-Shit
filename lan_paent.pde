import processing.net.*;
import controlP5.*;
ControlP5 cp5;
Textlabel posText;
ColorPicker cp;
Slider s;
Client paentClient;
//ConnectBut = Button;
PGraphics pg;
int BColor = 200,port = 5510,x,y,Color;
color col = color(255,255,255,255);
Float Size;
Boolean clRUN = false;
String[] IP = new String[2],nefor = new String[4];

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
    
  pg.beginDraw();
  pg.background(color(255,255,255,255));
  pg.endDraw();
  pg.noStroke();
  image(pg, 10, 10);
  
  //chat.setText("123");
}

void draw() {
  background(200);
  image(pg, 10, 10);
  if(clRUN ==  true){
  if(paentClient.active()) {
  if(mousePressed == true) {
    if (mouseX > 10 & mouseX < 579+10 & mouseY > 10 & mouseY < 551+10) {
      paentClient.write("DRAW#"+(mouseX - 10)+"#"+(mouseY - 10)+"#"+cp.getColorValue()+"#"+s.getValue()+"\n");
    }
  }
  
  if(paentClient.available() > 0) {
    nefor = split(paentClient.readString(),'#');
    pg.beginDraw();
    pg.fill(int(nefor[3]));
    pg.rectMode(CENTER);
    pg.square(float(nefor[1]),float(nefor[2]),float(nefor[4]));
    pg.endDraw();
    image(pg, 10, 10);
  }
}else {
  clRUN = false;
}
}
}
void mouseClicked() {
  println(mouseX,mouseY);
}

void connect() {
  IP = split(cp5.get(Textfield.class,"server ip").getText(),":");
  paentClient = new Client(this,IP[0],int(IP[1]));
  clRUN = true;
}
