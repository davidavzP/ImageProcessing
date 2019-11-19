class ApplyFilter {
    
    color basic_greyscale(Image img, int pixel_loc){
      float pixel_r = red(img.getImage().pixels[pixel_loc]);
      float pixel_g = green(img.getImage().pixels[pixel_loc]);
      float pixel_b = blue(img.getImage().pixels[pixel_loc]);
      float pixel_avg = (pixel_r + pixel_g + pixel_b)/3;
      int pixel_val = int(pixel_avg);
      color pixel_grey = color(pixel_val, pixel_val, pixel_val);
      return pixel_grey;
}
  
  
}
