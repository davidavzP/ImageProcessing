import java.util.*;

class FilterApplier {
    
  Collection<Filter> applied_filters = new ArrayList<Filter>();
  
  PImage apply(Filter filter, PImage image){
    applied_filters.add(filter);
    
    switch(filter){
      case GREYSCALE:
        return applyGreyscale(image);
      case CONVOLUTION:
        return null;
      case NONE:
        return null;
      default:
        return null;
    }
  }
  
  PImage applyGreyscale(PImage img){
    for(int x = 0; x < img.width; x++){
      for(int y = 0; y < img.height; y++){
        //do image processing
        int pixel_loc = x + y*img.width;
        img.pixels[pixel_loc] = basic_greyscale(img, pixel_loc);
      }
    }
    return img;
  }
 
 color basic_greyscale(PImage img, int pixel_loc){
  //average grey scale
      float pixel_r = red(img.pixels[pixel_loc]);
      float pixel_g = green(img.pixels[pixel_loc]);
      float pixel_b = blue(img.pixels[pixel_loc]);
      float pixel_avg = (pixel_r + pixel_g + pixel_b)/3;
      int pixel_val = int(pixel_avg);
      color pixel_grey = color(pixel_val, pixel_val, pixel_val);
      return pixel_grey;
}

}
