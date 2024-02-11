import controlP5.*;
import processing.net.*;
Client KalkClient;
ControlP5 cp5;
Textarea chat;
Textfield chatmsg,InputFormula,ServerFormula,nickname;
int keypadX = 3,keypadY = 205;
boolean ready = false,klRUN = false;
String[] IP;
String baseFont = "Hack";

void setup() {
  windowTitle("УЛЬТРАМЕГА КРУТОЙ КАЛЬКУЛЯТОР ПО СЕТИ!!111");
  size(600,300);
  cp5 = new ControlP5(this);
  createKeypad();
  createGUI();
  ready = true;
}

void draw() {
  background(200);
}

void mouseClicked(){
  //print(mouseX,mouseY);
}

public void controlEvent(ControlEvent ButtEvent) {
  char ButtType = ButtEvent.getController().getName().charAt(0);
  char ButtDigit = ButtEvent.getController().getName().charAt(1);
  if(ButtType == 'B') {
    InputFormula.setText(InputFormula.getText() + ButtDigit);
  }
  
}

void CSend(String input){KalkClient.write(input); InputFormula.setText("");}
void OPlus(){CSend("P#"+InputFormula.getText() + "#;"); InputFormula.setText("");}
void OMinus(){CSend("M#"+InputFormula.getText() + "#;"); InputFormula.setText("");}
void ODivide(){CSend("D#"+InputFormula.getText() + "#;"); InputFormula.setText("");}
void OMultiply(){CSend("m#"+InputFormula.getText() + "#;"); InputFormula.setText("");}

void keyPressed(KeyEvent chatMSG) {//отправка в чат по кликанью на Enter
  if(chatMSG.getKeyCode() == 10 & klRUN) {
    CSend("M#"+nickname.getText()+">"+chatmsg.getText()+"#;");
}}

void connect() {
  if(ready) {
  IP = split(cp5.get(Textfield.class,"server ip").getText(),":");
  KalkClient = new Client(this,IP[0],int(IP[1]));
  if(KalkClient.active()) klRUN = true; else chat.setText("АШИПКА 0х00000ФБББВЫБ НЕ УДАЛОСЬ ПОДКЛЮЧИЦА11!!!!1!!!!");
  }
}

void disconnect() {
  if(klRUN) {
  KalkClient.stop();
  klRUN = false;
  }
}

void createKeypad() {
  cp5.addButton("B1").setPosition(keypadX,keypadY).setLabel("1").setSize(35,20);
  cp5.addButton("B2").setPosition(keypadX+35,keypadY).setLabel("2").setSize(35,20);
  cp5.addButton("B3").setPosition(keypadX+70,keypadY).setLabel("3").setSize(35,20);
  cp5.addButton("B4").setPosition(keypadX,keypadY+25).setLabel("4").setSize(35,20);
  cp5.addButton("B5").setPosition(keypadX+35,keypadY+25).setLabel("5").setSize(35,20);
  cp5.addButton("B6").setPosition(keypadX+70,keypadY+25).setLabel("6").setSize(35,20);
  cp5.addButton("B7").setPosition(keypadX,keypadY+50).setLabel("7").setSize(35,20);
  cp5.addButton("B8").setPosition(keypadX+35,keypadY+50).setLabel("8").setSize(35,20);
  cp5.addButton("B9").setPosition(keypadX+70,keypadY+50).setLabel("9").setSize(35,20);
  cp5.addButton("B0").setPosition(keypadX+35,keypadY+72).setLabel("0").setSize(35,20);
  
  cp5.addButton("OPlus").setPosition(keypadX+107,keypadY).setLabel("+").setSize(35,20);
  cp5.addButton("OMinus").setPosition(keypadX+107,keypadY+25).setLabel("-").setSize(35,20);
  cp5.addButton("ODivide").setPosition(keypadX+107,keypadY+50).setLabel("/").setSize(35,20);
  cp5.addButton("OMultiply").setPosition(keypadX+107,keypadY+72).setLabel("*").setSize(35,20);
  InputFormula = cp5.addTextfield("InputFormula").setLabel("").setPosition(keypadX,keypadY-22).setSize(141,20);
  ServerFormula = cp5.addTextfield("ServerFormula").setLabel("").setPosition(keypadX,keypadY-45).setSize(141,20);
}

void createGUI() {
  chat = cp5.addTextarea("Chat").setFont(createFont(baseFont,10)).setPosition(155,3).setColorBackground(0).setSize(440,270);
  chatmsg = cp5.addTextfield("chatmsg").setFont(createFont(baseFont,10)).setPosition(155,275).setSize(440,20).setLabel("");
  nickname = cp5.addTextfield("nickname").setFont(createFont(baseFont,10)).setPosition(0,4).setSize(150,20).setLabel("").setText("coolname2930");
  cp5.addButton("connect").setValue(0).setPosition(0,50).setSize(50,20);
  cp5.addButton("disconnect").setValue(0).setPosition(52,50).setSize(60,20);
  cp5.addTextfield("server ip").setLabel("IP").setFont(createFont(baseFont,12)).setColorLabel(0).setPosition(0,26).setText("127.0.0.1:5510").setSize(150,20).setLabel("");
  cp5.addTextlabel("promo").setPosition(0,80).setText("Сделал некий NAAIN \nИз недокомпании \nООО 'аутизм инк' \nt.me/CHvK_NAAIN \n1209-2030 Все права \nотданы арабам").setColor(0).setFont(createFont(baseFont,12));
}
