
import controlP5.*;

Image img_gui;
ControlP5 cp5;
DropdownList d1;
DropDownArray ddarray1;
DropdownList d2;
DropDownArray2 ddarray2;
color alpha_color = color(140,180,240);
int[] image_size = new int[]{600, 600};
PShape square;
ConvolutionGUI convgui;



void settings() {
  //image size 1024x1024
  size(image_size[0]+600, image_size[1], P3D);
  smooth();
  
}

//this setup() function runs before anything else               
void setup(){
  img_gui = new Image("butterfly.jpg");
  img_gui.resize_img(image_size[0], image_size[1]);
  buildGUI();
  createConvolWindow();
}

public void createConvolWindow(){
  convgui = new ConvolutionGUI();
}

public void buildGUI(){
  cp5 = new ControlP5(this);
  createGUIComponents();
}

public void createGUIComponents(){
  
  createImageFrame();
  createDropdownList();
  createSliders();
}

//this draw() function is a loop that gets called over and over again
void draw(){
  background(128);
  drawColorBox();
  getImagePixels();
  drawImagetoScreen(0,0);
}

public void drawImagetoScreen(float x,float y){
  image(img_gui.getImage(), x,y);
  
}

public void getImagePixels(){
  img_gui.image_loadPixels();
  img_gui.image_updatePixels();
}

public void drawColorBox(){
  shape(square, 0,0);
  fill(0);
  textSize(10);
  text("Alpha Color:", image_size[0] + 20, 300);
  fill(alpha_color);
  rect(image_size[0] + 90, 285, 20, 20, 5);
}

void mouseClicked(){
  if (min(mouseX,mouseY) >0 && mouseX < image_size[0] && mouseY < image_size[1]){
    alpha_color = img_gui.getCurrPixelXY(mouseX, mouseY);
  }
}

void stop(){
  exit();
}
