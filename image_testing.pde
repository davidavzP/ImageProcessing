import controlP5.*;


Image img;
Image output_img;
Image conv_img;
Image conv_img_2;

Image img_gui;

ControlP5 cp5;

DropdownList d1;
DropDownArray ddarray1;
PShape square;  

//convolution matrix
int conv_matrix_size = 3;
//this can be changed to anything
//below is an edge detection filter
float[][] conv_matrix = {{0, 0, 0},
                         {-1, 1, 0},
                         {0, 0, 0}};
                         
float[][] conv_matrix_2 = {{0, -1, -1},
                           {0, 5, -1},
                           {0, -1, -1}};

               
//this setup() function runs before anything else               
void setup(){
  //image size 1024x1024
  size(800, 600, P3D);
  img_gui = new Image("sunflower.jpg");
  img_gui.resize_img(600, 600);
  
  
  
  createImageFrame();
  cp5 = new ControlP5(this);
  createDropdownList();
  //createImages();
}

void createImages(){
  img = new Image("sunflower.jpg");
  img.resize_img(300, 300);
  output_img = new Image(img.getWidth(), img.getHeight());
  conv_img = new Image(img.getWidth(), img.getHeight());
  conv_img_2 = new Image(img.getWidth(), img.getHeight());
}


//this draw() function is a loop that gets called over and over again
void draw(){
  background(128);
  shape(square, 0,0);
  img_gui.image_loadPixels();
  img_gui.filterChanged();
  img_gui.image_updatePixels();
  image(img_gui.getImage(), 0,0);
  //drawImages();
  
  
}

void drawImages(){
  img.image_loadPixels();
  image(img.getImage(), 0, 0);
  
  output_img.image_loadPixels();
  apply_greyscale();
  output_img.image_updatePixels();
  image(output_img.getImage(), 300, 0);
  
  conv_img.image_loadPixels();
  preform_convolution(conv_img, conv_matrix);
  image(conv_img.getImage(), 0, 300);
  
  conv_img_2.image_loadPixels();
  preform_convolution(conv_img_2, conv_matrix_2);
  image(conv_img_2.getImage(), 300, 300);
  
}
