import processing.net.*;
import controlP5.*;
ControlP5 cp5;
Textarea BrushMode,chatArea;
Textfield chatMSG;
ColorPicker cp;
Slider s;
Client paentClient;

PGraphics pg;
int BColor = 200,port = 5510,x,y,Color,brushMode = 1;
Float Size;
Boolean clRUN = false,needPing = false;
String[] IP = new String[2],packet = new String[4];
char a;
String baseFont = "Hack";

void setup() {//создание гуи дравбокса и всей нечесиэ
  windowTitle("УЛЬТРА МЕГА КРУТОЙ PAINT ПО СЕТИ111!!!!");
  background(BColor);
  size(1250,600);
  pg = createGraphics(579, 551);
  cp5 = new ControlP5(this);        
  CreateGUI();
  CreateBrushModes();
  pg.beginDraw();
  pg.background(color(255,255,255,255));
  pg.endDraw();
  pg.noStroke();
  image(pg, 10, 10);
}
void draw() {
  background(200);
  image(pg, 10, 10);
  if (mouseX > 10 & mouseX < 579+10 & mouseY > 10 & mouseY < 551+10 & mousePressed == true & clRUN == true) {//начало дрочилова при нажатии в дравбоксе
    paentClient.write("D#"+(mouseX - 10)+"#"+(mouseY - 10)+"#"+cp.getColorValue()+"#"+s.getValue()+"#"+str(brushMode)+"#;");
  }
  if(clRUN == true) {
   if(paentClient.available() > 0) {
    packet = split(paentClient.readStringUntil(byte(';')),'#');
    char a = packet[0].charAt(0);
    switch(a) {
      case 'D':
        DrawDot(int(packet[1]),int(packet[2]),int(packet[3]),float(packet[4]));
        break;
      case 'M':
        chatArea.setText(chatArea.getText() + packet[1] + "\n");
        break;
}}}}


void connect() {
  IP = split(cp5.get(Textfield.class,"server ip").getText(),":");
  paentClient = new Client(this,IP[0],int(IP[1]));
  clRUN = true;
}

void disconnect() {
  paentClient.stop();
  clRUN = false;
}

void DrawDot(int x,int y,int Size,float IColor) {
    pg.beginDraw();
    pg.fill(Size);
    pg.rectMode(CENTER);
    pg.square(x,y,IColor);
    pg.endDraw();
    image(pg, 10, 10);
}

void keyPressed(KeyEvent chatMSG) {//отправка в чат по кликанью на Enter
  if(chatMSG.getKeyCode() == 10) {
    paentClient.write("M#"+cp5.get(Textfield.class,"Nickname").getText()+">"+cp5.get(Textfield.class,"ChatMSG").getText()+"#;");
}}

void mouseClicked() {
  println(mouseX,mouseY);
}

void CreateGUI() {//жоское создание всего ГУИ
  cp = cp5.addColorPicker("picker")
  .setPosition(920,10)
  .setColorValue(color(0, 0, 0, 255))
  .setSize(240,100);
          
  s = cp5.addSlider("Brush Size")
  .setPosition(920,70)
  .setRange(0,100)
  .setSize(240,20)
  .setValue(5)
  .setArrayValue(new float[] {50, 50});   
  
  cp5.addButton("connect")
  .setValue(0)
  .setPosition(1020,475)
  .setSize(50,20);
  cp5.addButton("disconnect")
  .setValue(0)
  .setPosition(1065,475)
  .setSize(60,20);
  cp5.addTextfield("server ip")
  .setPosition(917,435)
  .setText("127.0.0.1:5510")
  .setSize(105,20);
  
  cp5.addTextlabel("promo")
  .setPosition(590,525)
  .setText("Сделал некий NAAIN \nИз недокомпании ООО 'аутизм инк' \nt.me/CHvK_NAAIN \n1209-2030 Все права отданы арабам")
  .setColor(0)
  .setFont(createFont(baseFont,12));
  
  chatArea = cp5.addTextarea("chat")
  .setPosition(591,10)
  .setSize(325,468)
  .showScrollbar()
  .scroll(1) 
  .setColorBackground(0)
  .setFont(createFont(baseFont,12)); 
  chatMSG = cp5.addTextfield("ChatMSG")
  .setPosition(592,475)
  .setFont(createFont(baseFont,10))
  .setText("")
  .setSize(324,20);
  cp5.addTextfield("Nickname")
  .setPosition(918,475)
  .setFont(createFont(baseFont,10))
  .setText("")
  .setSize(100,20);
}

void CreateBrushModes() {
  BrushMode = cp5.addTextarea("BrushMode")
  .setPosition(1030,95)
  .setFont(createFont(baseFont,12))
  .setText("Режим:Кисть")
  .setColor(0);
  cp5.addButton("Brush")
  .setLabel("Кисть")
  .setFont(createFont(baseFont,10))
  .setValue(0)
  .setPosition(920,95)
  .setSize(50,20);
  cp5.addButton("Picker")
  .setFont(createFont(baseFont,10))
  .setValue(0)
  .setLabel("Пипетка")
  .setPosition(975,95)
  .setSize(50,20);
}

void Brush() {
  brushMode = 1;
}
void Picker() {
  brushMode = 2;
}
