import java.util.*;

class FilterApplier {
  PImage background;
  int blur_strength = 2;
  color alpha_color = color(255,0,0);
  int greyscale_type = 0; // 0 => average, 1 => lightness, 2 => luminosity
  float[][] conv_matrix = { { -1 ,  0 , -1 },
                            {  0 ,  4 ,  0 },
                            { -1 ,  0 , -1 } };
  
  void setConvolutionMatrix(Convolution  conv){
    conv_matrix = conv.getMatrix();
  }
 
  void setBackground(PImage back_img){
    background = back_img;
  }
 
 
  PImage applyFilter(PImage image, Filter filter){
    switch(filter){
      case GREYSCALE:
          image = applyGreyscale(image);
          break;
       case NEGATIVE:
          image = applyNegative(image);
          break;
       case GAUSS:
          image = applyGaussBlur(image, blur_strength);
          break;
       case BOX_BLUR:
          image = applyBoxBlur(image, blur_strength);
          break;
       case SHARP:
          float[][] sharp_matrix = Convolution.SHARP.getMatrix();
          image = applyConvolution(image, new Matrix(sharp_matrix, sharp_matrix.length));
          break;
        case EDGE:
          float[][] edge_matrix = Convolution.EDGE.getMatrix();
          image = applyEdgeDetection(image, new Matrix(edge_matrix, edge_matrix.length));
          break;
        case CONVOLUTION:
          image = applyConvolution(image, new Matrix(conv_matrix, conv_matrix.length));
          break;
    }
    return image; 
  }
  
  PImage changeRGBChannels(PImage img, int[] vals){
     for(int x = 0; x < img.width; x++){
            for(int y = 0; y <  img.height; y++){
              color original_Color = img.get(x,y);
              float r = red(original_Color) + vals[0];
              float g = green(original_Color) + vals[1];
              float b = blue(original_Color) + vals[2];
              r = constrain(r, 0, 255);
              g = constrain(g, 0, 255);
              b = constrain(b, 0, 255);
              color new_color = color(r, g, b);
              img.set(x,y, new_color);
            }
     }
     return img;
  }

  //These are not used
  //
  //PImage changeRedChannel(PImage img, int val){
  //   for(int x = 0; x < img.width; x++){
  //          for(int y = 0; y <  img.height; y++){
  //            color original_Color = img.get(x,y);
  //            color new_color;
  //            float red = red(original_Color);
  //            float green = green(original_Color);
  //            float blue = blue(original_Color);
  //            int added_red = int(red) + val;
  //            int new_val = constrain(added_red, 0, 255);
  //            new_color = color(new_val, green, blue);
  //            img.set(x,y, new_color);
  //          }
  //   }
  //   return img;
  //}
  
  //PImage changeGreenChannel(PImage img, int val){
  //   for(int x = 0; x < img.width; x++){
  //          for(int y = 0; y <  img.height; y++){
  //            color original_Color = img.get(x,y);
  //            color new_color;
  //            float red = red(original_Color);
  //            float green = green(original_Color);
  //            float blue = blue(original_Color);
  //            int added_green = int(green) + val;
  //            int new_val = constrain(added_green, 0, 255);
  //            new_color = color(red, new_val, blue);
  //            img.set(x,y, new_color);
  //          }
  //   }
  //   return img;
  //}
  
  //PImage changeBlueChannel(PImage img, int val){
  //   for(int x = 0; x < img.width; x++){
  //          for(int y = 0; y <  img.height; y++){
  //            color original_Color = img.get(x,y);
  //            color new_color;
  //            float red = red(original_Color);
  //            float green = green(original_Color);
  //            float blue = blue(original_Color);
  //            //this makes something pretty int added_blue = int(green) + val;
  //            int added_blue = int(blue) + val;
  //            int new_val = constrain(added_blue, 0, 255);
  //            new_color = color(red, green, new_val);
  //            img.set(x,y, new_color);
  //          }
  //   }
  //   return img;
  //}
  
  color blendWithBackImg(color org, int x, int y, float val){
    int new_X = (x % background.width) + 1;
    int new_Y = (y % background.height) + 1;
    color merge_Col = background.get(new_X,new_Y);
    float red = red(org) + val * (red(merge_Col)-red(org));
    float green = green(org) + val * (green(merge_Col)-green(org));
    float blue = blue(org) + val * (blue(merge_Col)-blue(org));
    constrain(red,0,255);
    constrain(green,0,255);
    constrain(blue,0,255);
    return color(red,green,blue);
  }
  
  PImage changeAlphaChannel(PImage img, int val){
    println("alpha val is " + val);
    for(int x = 0; x < img.width; x++){
        for(int y = 0; y <  img.height; y++){
        color original_Color = img.get(x,y);
        //float red = red(original_Color);
        //float green = green(original_Color);
        //float blue = blue(original_Color);
        //val = int(map(new_val, 1, 0, 255, 0));
        color new_color = blendWithBackImg(original_Color, x, y, val);
        img.set(x,y, new_color);
      }
     }
     return img;
  }
 
  PImage applyGreyscale(PImage img){
    for(int x = 0; x < img.width; x++){
            for(int y = 0; y < img.height; y++){
              //do image processing
              color original_Color = img.get(x,y);
              color new_color;
              float red = red(original_Color);
              float green = green(original_Color);
              float blue = blue(original_Color);
              switch(greyscale_type){
                case 0:
                  new_color = color(int(red + green + blue)/3);
                  break;
                case 1:
                  new_color = color(int(max(red,blue,green) + min(red,green,blue))/2);
                  break;
                case 2:
                  new_color = color(int(0.21 * red + 0.72 * green + 0.07 * blue));
                  break;
                default:
                  new_color = color(int(red + green + blue)/3);
                  break;
              }
              img.set(x,y,new_color);
            }
    }
    return img;
  }
  
  Image applyColorToAlpha(Image img, color col){
    Image result = img;
    for(int x = 0; x < img.getWidth(); x++){
            for(int y = 0; y < img.getHeight(); y++){
              //do image processing
              color prev_col = img.getPixelXY(x,y);
              float red_difference = abs(red(col)-red(prev_col));
              float green_difference = abs(green(col)-green(prev_col));
              float blue_difference = abs(blue(col)-blue(prev_col));
              int difference = constrain(round(red_difference + green_difference + blue_difference), 0, 255);
              color new_color = blendWithBackImg(prev_col, x, y, difference);
              result.setPixelXY(x,y,new_color);
            }
    }
    return result;
  }
  
  PImage applyNegative(PImage img){
 
    for(int x = 0; x < img.width; x++){
            for(int y = 0; y < img.height; y++){
              //do image processing
              color original_Color = img.get(x,y);
              color new_color = color(255 - red(original_Color), 255 - green(original_Color), 255 - blue(original_Color));
              img.set(x,y,new_color);
            }
    }
    return img;
  }
  
  PImage applyEdgeDetection(PImage img, Matrix matrix){
    PImage result = new PImage(img.width, img.height);
    for(int x = 0; x < img.width; x++){
      for(int y = 0; y < img.height; y++){
        color conv_color = convoluteAt(img, x, y, matrix);
        float black_white = constrain(red(conv_color) + green(conv_color) + blue(conv_color), 0, 255);
        result.set(x, y, color(black_white));
      }
    }
    return result;
  }
  
  PImage applyBoxBlur(PImage img, int size){
    
    float[][] mat = new float[2*size+1][2*size+1]; 
    for (int i = 0; i < 2 * size + 1; i++){
      for (int j = 0; j < 2 * size + 1; j++){
        //mat[i][j] = factor*(1/PI) * exp( -factor * (pow(i-size,2) + pow(j-size,2)) );
        mat[i][j] = 1/pow(2*size+1,2);
      }
    }
    Matrix blur_matrix = new Matrix(mat, 2*size+1);
    return applyConvolution(img, blur_matrix);
  }
  
  PImage applyGaussBlur(PImage img, int size){
    
    float sigma = sqrt(2)*size/3; //set sigma so that all values are within 3-sigma-environment --> 99,7% of original brightness achieved
    float total = 0;
    float[][] mat = new float[2*size+1][2*size+1];
    for (int i = 0; i < 2 * size + 1; i++){
      for (int j = 0; j < 2 * size + 1; j++){
        float sqr_dist = pow(i-size,2) + pow(j-size,2);
        total += mat[i][j] = exp( -sqr_dist / (2 * pow(sigma,2) )) / (2 * pow(sigma,2) * PI);
      }
    }
    mat[size][size] += 1 - total; //add missing brightness to main pixel (ideally 0.3% but rounding makes it worse)
    Matrix gauss_matrix = new Matrix(mat, 2*size+1);
    return applyConvolution(img, gauss_matrix);
  }
  
  PImage applyConvolution(PImage img, Matrix matrix){
    PImage result = new PImage(img.width, img.height);
    for(int x = 0; x < img.width; x++){
      for(int y = 0; y < img.height; y++){
        int pixel_loc = x + y*img.width;
        color conv_color = convoluteAt(img, x, y, matrix);
        result.pixels[pixel_loc] = conv_color;
      }
    }
    return result;
  }

  color convoluteAt(PImage img, int x, int y, Matrix matrix){
    //if (matrix.getWidth() != matrix.getHeight()) return img.get(x,y);
    
    int offset = matrix.getWidth()/2;
    
    float pixel_val_R = 0;
    float pixel_val_G = 0;
    float pixel_val_B = 0;
      
    //use transposed version of the original matrix
    Matrix trans_matrix = matrix.transposed();
    for(int i = 0; i < matrix.getWidth(); i++){
      for(int j = 0; j < matrix.getWidth(); j++){
        
         //gives surrounding pixels of x,y
         int surpix_x = x + i - offset;
         int surpix_y = y + j - offset;
    
         int surpix_loc = surpix_x + surpix_y*img.width;
         
         //ensures that if the surrounding pixels are outside the bounds are not calculated
         surpix_loc = constrain(surpix_loc, 0, img.pixels.length - 1);
         
         //perform convolution
         color curr_color = img.pixels[surpix_loc];
         pixel_val_R += (red(curr_color) * trans_matrix.getValue(i,j));
         pixel_val_G += (green(curr_color) * trans_matrix.getValue(i,j));
         pixel_val_B += (blue(curr_color) * trans_matrix.getValue(i,j));
      }
    }
      
    //makes sure the final value is within the scale 0-255
    pixel_val_R = constrain(pixel_val_R, 0, 255);
    pixel_val_G = constrain(pixel_val_G, 0, 255);
    pixel_val_B = constrain(pixel_val_B, 0, 255);

    return color(pixel_val_R, pixel_val_G, pixel_val_B);
  }
}
