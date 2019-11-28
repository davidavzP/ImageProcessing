import java.util.*;

class FilterApplier {
    
  ArrayList<Filter> applied_filters = new ArrayList<Filter>();
  
  int blur_strength = 2;
  int greyscale_type = 0; // 0 => average, 1 => lightness, 2 => luminosity
  float[][] conv_matrix = { { -1 ,  0 , -1 },
                            {  0 ,  4 ,  0 },
                            { -1 ,  0 , -1 } };
  
  void setConvolutionMatrix(Convolution  conv){
    conv_matrix = conv.getMatrix();
  }
  
  boolean isApplied(Filter filter){
    return applied_filters.contains(filter);
  }
  
  void addFilter(Filter filter){
    applied_filters.add(filter);
  }
  
  void removeFilter(Filter filter){
    applied_filters.remove(filter);
  }
  
  void removeAll(){
    applied_filters.clear();
    addFilter(Filter.REDCHANNEL);
  }
  
  void toggleFilter(Filter filter)
  {
    if (!isApplied(filter)) applied_filters.add(filter);
    else applied_filters.remove(filter);
  }
  
  private FilterApplier(){
     addFilter(Filter.REDCHANNEL);
  }
  
  PImage apply(Image image){
    Image result = image;
    for(Filter filter:applied_filters){
      switch(filter){
        case GREYSCALE:
          result = applyGreyscale(result);
          break;
        case NEGATIVE:
          result = applyNegative(result);
          break;
        case GAUSS:
          result = applyGaussBlur(result, blur_strength);
          break;
        case BOX_BLUR:
          result = applyBoxBlur(result, blur_strength);
          break;
        case SHARP:
          float[][] sharp_matrix = Convolution.SHARP.getMatrix();
          result = applyConvolution(result, new Matrix(sharp_matrix, sharp_matrix.length));
          break;
        case EDGE:
          float[][] edge_matrix = Convolution.EDGE.getMatrix();
          result = applyEdgeDetection(result, new Matrix(edge_matrix, edge_matrix.length));
          break;
        case CONVOLUTION:
          result = applyConvolution(result, new Matrix(conv_matrix, conv_matrix.length));
          break;
        case REDCHANNEL:
          result = changeRedChannel(result, result.getRedChannel());
          break;
        default:
          break;
      }
    }
    return result.getImage();
  }
  
  Image changeRedChannel(Image img, int val){
     for(int x = 0; x < img.getWidth(); x++){
            for(int y = 0; y <  img.getHeight(); y++){
              color original_Color = img.getPixelXY(x,y);
              color new_color;
              float red = red(original_Color);
              float green = green(original_Color);
              float blue = blue(original_Color);
              int added_red = int(red) + val;
              int new_val = constrain(added_red, 0, 255);
              new_color = color(new_val, green, blue);
              img.setPixelXY(x,y, new_color);
            }
     }
     return img;
    
  }
 
  Image applyGreyscale(Image img){
    Image result = new Image(img.getWidth(),img.getHeight());
    for(int x = 0; x < img.getWidth(); x++){
            for(int y = 0; y < img.getHeight(); y++){
              //do image processing
              color original_Color = img.getPixelXY(x,y);
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
              result.setPixelXY(x,y,new_color);
            }
    }
    return result;
  }
  
  Image applyNegative(Image img){
    Image result = new Image(img.getWidth(),img.getHeight());
    for(int x = 0; x < img.getWidth(); x++){
            for(int y = 0; y < img.getHeight(); y++){
              //do image processing
              color original_Color = img.getPixelXY(x,y);
              color new_color = color(255 - red(original_Color), 255 - green(original_Color), 255 - blue(original_Color));
              result.setPixelXY(x,y,new_color);
            }
    }
    return result;
  }
  
  Image applyEdgeDetection(Image img, Matrix matrix){
    Image result = new Image(img.getWidth(),img.getHeight());
    for(int x = 0; x < img.getWidth(); x++){
      for(int y = 0; y < img.getHeight(); y++){
        color conv_color = convoluteAt(img, x, y, matrix);
        float black_white = constrain(red(conv_color) + green(conv_color) + blue(conv_color), 0, 255);
        result.setPixelXY(x, y, color(int(black_white)));
      }
    }
    return result;
  }
  
  Image applyBoxBlur(Image img, int size){
    
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
  
  Image applyGaussBlur(Image img, int size){
    
    float sigma = pow(size,2)/3; //set sigma so that all values are within 3-sigma-environment --> 99,7% of original brightness achieved
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
  
  Image applyConvolution(Image img, Matrix matrix){
    Image result = new Image(img.getWidth(),img.getHeight());
    for(int x = 0; x < img.getWidth(); x++){
      for(int y = 0; y < img.getHeight(); y++){
        color conv_color = convoluteAt(img, x, y, matrix);
        result.setPixelXY(x, y, conv_color);
      }
    }
    return result;
  }

  color convoluteAt(Image img, int x, int y, Matrix matrix){
    if (matrix.getWidth() != matrix.getHeight()) return img.getPixelXY(x,y);
    
    int offset = matrix.getWidth()/2;
    float pixel_val_R = 0;
    float pixel_val_G = 0;
    float pixel_val_B = 0;
      
    //use transposed version of the original matrix
    Matrix trans_matrix = matrix;//.transposed(matrix.getMatrix());
  
    for(int i = 0; i < matrix.getHeight(); i++){
      for(int j = 0; j < matrix.getWidth(); j++){
        
         //gives surrounding pixels of x,y
         int surpix_x = x + j - offset;
         int surpix_y = y + i - offset;
         
         //ensures that if the surrounding pixels are outside the bounds are not calculated
         surpix_x = constrain(surpix_x, 0, img.getWidth());
         surpix_y = constrain(surpix_y, 0, img.getHeight());
         
         //perform convolution
         pixel_val_R += red(img.getPixelXY(surpix_x, surpix_y)) * trans_matrix.getValue(i,j);
         pixel_val_G += green(img.getPixelXY(surpix_x, surpix_y)) * trans_matrix.getValue(i,j);
         pixel_val_B += blue(img.getPixelXY(surpix_x, surpix_y)) * trans_matrix.getValue(i,j);
      }
    }
      
    //makes sure the final value is within the scale 0-255
    pixel_val_R = constrain(pixel_val_R, 0, 255);
    pixel_val_G = constrain(pixel_val_G, 0, 255);
    pixel_val_B = constrain(pixel_val_B, 0, 255);

    return color(pixel_val_R, pixel_val_G, pixel_val_B);
  }
}
