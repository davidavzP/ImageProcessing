import java.util.*;

class FilterApplier {
    
  Collection<Filter> applied_filters = new ArrayList<Filter>();
  
  float[][] conv_matrix = {{-1, -1, -1},
                           {-1, 8, -1},
                           {-1, -1, -1}};
  
  PImage apply(Filter filter, PImage image){
    applied_filters.add(filter);
    
    switch(filter){
      case GREYSCALE:
        return applyGreyscale(image);
      case NEGATIVE:
        return applyNegative(image);
      case CONVOLUTION:
        return applyConvolution(image, conv_matrix);
      case NONE:
        return image;
    }
    
    return image;
  }
  
  PImage applyGreyscale(PImage img){
    for(int x = 0; x < img.width; x++){
      for(int y = 0; y < img.height; y++){
        //do image processing
        int pixel_loc = x + y*img.width;
        img.pixels[pixel_loc] = basicGreyscale(img, pixel_loc);
      }
    }
    return img;
  }
 
  color basicGreyscale(PImage img, int pixel_loc){
  //average grey scale
      float pixel_r = red(img.pixels[pixel_loc]);
      float pixel_g = green(img.pixels[pixel_loc]);
      float pixel_b = blue(img.pixels[pixel_loc]);
      float pixel_avg = (pixel_r + pixel_g + pixel_b)/3;
      int pixel_val = int(pixel_avg);
      color pixel_grey = color(pixel_val, pixel_val, pixel_val);
      return pixel_grey;
  }
  
  PImage applyConvolution(PImage img, float[][] matrix){
    for(int x = 0; x < img.width; x++){
      for(int y = 0; y < img.height; y++){
        int pixel_loc = x + y*img.width;
        img.pixels[pixel_loc] = convolution(img, x, y, matrix);
      }
    }
    return img;
  }

PImage applyNegative(PImage img){
    for(int i = 0; i < img.pixels.length; i++) img.pixels[i] = color(255 - red(img.pixels[i]), 255 - green(img.pixels[i]), 255 - blue(img.pixels[i]));
    return img;
  }

  color convolution(PImage img, int x, int y, float[][] matrix){
    int offset = conv_matrix_size/2;
    float pixel_val_R = 0;
    float pixel_val_G = 0;
    float pixel_val_B = 0;
      
    //use transposed version of the original matrix
    float[][] conv_matrix = transpose_matrix(matrix);
  
    for(int i = 0; i < conv_matrix_size; i++){
      for(int j = 0; j < conv_matrix_size; j++){
        
         //gives surrounding pixels of x,y
         int surpix_x = x + i-offset;
         int surpix_y = y + j-offset;
         int surpix_loc = surpix_x + surpix_y*img.width;
         
         //insures that if the surrounding pixels are outside the bounds are not calculated
         surpix_loc = constrain(surpix_loc, 0, img.pixels.length - 1);
         
         //preform convolution
         pixel_val_R += red(img.pixels[surpix_loc]) * conv_matrix[i][j];
         pixel_val_G += green(img.pixels[surpix_loc]) * conv_matrix[i][j];
         pixel_val_B += blue(img.pixels[surpix_loc]) * conv_matrix[i][j];
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

  float[][] transpose_matrix(float[][] matrix){
    float[][] t_matrix = new float[conv_matrix_size][];
    for(int i = 0; i < conv_matrix_size; i++){
      t_matrix[i] = new float[conv_matrix_size];
      for(int j = 0; j < conv_matrix_size; j++){
        t_matrix[i][j] = matrix [j][i];
      }
    }
    return t_matrix;
  }

}
