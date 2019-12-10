import controlP5.*;

Image img_gui;
ControlP5 cp5;
DropdownList d1;
DropDownArray ddarray1;
PShape square;
int opacity;

void settings() {
  //image size 1024x1024
  size(800, 600, P3D);
  smooth();
}

//this setup() function runs before anything else               
void setup(){
  img_gui = new Image("sunflower.jpg");
  img_gui.resize_img(600, 600);

  createImageFrame();
  cp5 = new ControlP5(this);
  createDropdownList();
  createSliders();
  
  opacity = 255;
}


//this draw() function is a loop that gets called over and over again
void draw(){
  background(128);
  shape(square, 0,0);
  img_gui.image_loadPixels();
  img_gui.image_updatePixels();
  //tint(255, opacity);
  image(img_gui.getImage(), 0, 0);
}
