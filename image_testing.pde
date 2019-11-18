

//create images


Image img;
Image output_img;
Image conv_img;
Image conv_img_2;

//convolution matrix
int conv_matrix_size = 3;
//this can be changed to anything
//below is an edge detection filter
float[][] conv_matrix = {{-1, -1, 0},
                         {-1, 5, 0},
                         {-1, -1, 0}};
                         
float[][] conv_matrix_2 = {{0, -1, -1},
                           {0, 5, -1},
                           {0, -1, -1}};

               
//this setup() function runs before anything else               
void setup(){
  //image size 1024x1024
  size(600, 600);
  
  img = new Image("sunflower.jpg");
  img.resize_img(300, 300);
  output_img = new Image(img.getWidth(), img.getHeight());
  conv_img = new Image(img.getWidth(), img.getHeight());
  conv_img_2 = new Image(img.getWidth(), img.getHeight());
}


//this draw() function is a loop that gets called over and over again
void draw(){
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

void apply_greyscale(){
  for(int x = 0; x < img.getWidth(); x++){
    for(int y = 0; y < img.getHeight(); y++){
      //do image processing
      int pixel_loc = img.getPixelLocation(x,y);
      color pixel_new = basic_greyscale(pixel_loc);
      output_img.setPixel(pixel_loc, pixel_new); 

    }
  }
}

void preform_convolution(Image image, float[][] matrix){
  for(int x = 0; x < img.getWidth(); x++){
    for(int y = 0; y < img.getHeight(); y++){
      color c = convolution(x, y, matrix);
      image.setPixelxy(x, y, c);
    }
  }
}

color basic_greyscale(int pixel_loc){
  //average grey scale
      float pixel_r = red(img.getImage().pixels[pixel_loc]);
      float pixel_g = green(img.getImage().pixels[pixel_loc]);
      float pixel_b = blue(img.getImage().pixels[pixel_loc]);
      float pixel_avg = (pixel_r + pixel_g + pixel_b)/3;
      int pixel_val = int(pixel_avg);
      color pixel_grey = color(pixel_val, pixel_val, pixel_val);
      return pixel_grey;
}

color convolution(int x, int y, float[][] conv_matrix){
    int offset = conv_matrix_size/2;
    float pixel_val_R = 0;
    float pixel_val_G = 0;
    float pixel_val_B = 0;
  
    for(int i = 0; i < conv_matrix_size; i++){
      for(int j = 0; j < conv_matrix_size; j++){
        
           //gives surrounding pixels of x,y
           int surpix_x = x + i-offset;
           int surpix_y = y + j-offset;
           int surpix_loc = surpix_x + surpix_y*img.getWidth();
           
           //insures that if the surrounding pixels are outside the bounds are not calculated
           surpix_loc = constrain(surpix_loc, 0, img.getImage().pixels.length - 1);
           
           //preform convolution
           pixel_val_R += red(img.getImage().pixels[surpix_loc]) * conv_matrix[i][j];
           pixel_val_G += green(img.getImage().pixels[surpix_loc]) * conv_matrix[i][j];
           pixel_val_B += blue(img.getImage().pixels[surpix_loc]) * conv_matrix[i][j];
      }
    }
    
    //makes sure the final value is within the scale 0-255
    pixel_val_R = constrain(pixel_val_R, 0, 255);
    pixel_val_G = constrain(pixel_val_G, 0, 255);
    pixel_val_B = constrain(pixel_val_B, 0, 255);
    
    float pixel_val = (pixel_val_R + pixel_val_G + pixel_val_B);
    pixel_val = constrain(pixel_val, 0, 255);
  
    return color(pixel_val);
}
