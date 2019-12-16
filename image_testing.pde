
import controlP5.*;

Image img_gui;
ControlP5 cp5;
DropdownList d1;
DropDownArray ddarray1;
DropdownList d2;
DropDownArray2 ddarray2;
color alpha_color = color(140,180,240);
int[] image_size = new int[]{1000, 1000};
PShape square;
ConvolutionGUI convgui;



void settings() {
  //image size 1024x1024
  size(image_size[0]+900, image_size[1], P3D);
  smooth();
  
}

//this setup() function runs before anything else               
void setup(){
  img_gui = new Image("butterfly.jpg");
  img_gui.resize_img(image_size[0], image_size[1]);

  createImageFrame();
  cp5 = new ControlP5(this);
  createDropdownList();
  createSliders();
  convgui = new ConvolutionGUI();
}


//this draw() function is a loop that gets called over and over again
void draw(){
  background(128);
  shape(square, 0,0);
  fill(0);
  textSize(10);
  text("Alpha Color:", image_size[0] + 20, 300);
  fill(alpha_color);
  rect(image_size[0] + 90, 285, 20, 20, 5);
  img_gui.image_loadPixels();
  img_gui.image_updatePixels();
  //tint(255, opacity);
  image(img_gui.getImage(), 0, 0);

}

void mouseClicked(){
  if (min(mouseX,mouseY) >0 && mouseX < image_size[0] && mouseY < image_size[1]){
    alpha_color = img_gui.getCurrPixelXY(mouseX, mouseY);
  }
}

void stop(){
  exit();
}
