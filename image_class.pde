class Image{
  
  PImage img;
  PImage original_img;
  int img_width;
  int img_height;
  FilterApplier filter_applier = new FilterApplier();
  Filter next_filter = Filter.NONE;
  
   //loads an Image from a file
  Image(String file){
    img = loadImage(file);
    original_img = loadImage(file);
    this.img_width = img.width;
    this.img_height = img.height;
  }
  
  //creates an Emtpy Image
  Image(int img_width, int img_height){
    img = createImage(img_width, img_height, RGB);
    original_img = createImage(img_width, img_height, RGB);
    this.img_width = img.width;
    this.img_height = img.height;
  }
  
  void newFilter(Filter filter){
    next_filter = filter;
  }
  
  void filterChanged(){
    img.copy(original_img, 0, 0, img_width, img_height, 0, 0, img_width, img_height);
    
    if(next_filter != Filter.NONE){
      apply_filter();
    }
  }
  
  void apply_filter(){
    img = filter_applier.apply(next_filter, img);
  }
  
  void resize_img(int new_width, int new_height){
    this.img_width = new_width;
    this.img_height = new_height;
    this.img.resize(img_width, img_height);
    this.original_img.resize(img_width, img_height);
  }
  
  void setPixel(int pixel_loc, color c){
    img.pixels[pixel_loc] = c;
  }
  
  void setPixelxy(int x, int y, color c){
    int pixel_loc = getPixelLocation(x,y);
    img.pixels[pixel_loc] = c;
  }
  
  int getPixelLocation(int x, int y){
    return x + y*img_width;
  }
  
  PImage getImage(){
    return this.img;
  }
  
  void image_updatePixels(){
    this.img.updatePixels();
  }
  
  void image_loadPixels(){
    this.img.loadPixels();
  }
  
  int getWidth(){
    return img_width;
  }
  
  int getHeight(){
    return img_height;
  }
  
}
