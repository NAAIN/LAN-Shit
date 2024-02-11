import controlP5.*;
import processing.net.*;
Client KalkClient;
ControlP5 cp5;
Textfield InputFormula;
int keypadX = 3,keypadY = 168;

void setup() {
  windowTitle("УЛЬТРАМЕГА КРУТОЙ КАЛЬКУЛЯТОР ПО СЕТИ!!111");
  size(600,700);
  cp5 = new ControlP5(this);
  createKeypad();
  createGUI();
}

void draw() {
  
}

void mouseClicked(){print(mouseX,mouseY);}
void CSend(String input){KalkClient.write(input);}
void BPlus(){CSend("P#"+InputFormula.getText());}

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
  
  cp5.addButton("BPlus").setPosition(keypadX+107,keypadY).setLabel("+").setSize(35,20);
  cp5.addButton("BMinus").setPosition(keypadX+107,keypadY+25).setLabel("-").setSize(35,20);
  cp5.addButton("BDivide").setPosition(keypadX+107,keypadY+50).setLabel("/").setSize(35,20);
  cp5.addButton("BMultiply").setPosition(keypadX+107,keypadY+72).setLabel("*").setSize(35,20);
}

void createGUI() {
  InputFormula = cp5.addTextfield("InputFormula").setLabel("").setPosition(keypadX,keypadY-25).setSize(141,20);
}
