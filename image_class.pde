class Image{
  
  PImage img;
  PImage original_img;
  int img_width;
  int img_height;
  FilterApplier filter_applier = new FilterApplier();
  Filter next_filter = Filter.NONE;
  int[] channels = {0,0,0,1};


  
  
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
    if (filter != Filter.NONE) filter_applier.toggleFilter(filter);
    else filter_applier.removeAll();
    img.copy(original_img, 0, 0, img_width, img_height, 0, 0, img_width, img_height);
   img = filter_applier.apply(this);
  }
  
  void filterChanged(){
   
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
  
  void setPixelXY(int x, int y, color c){
    img.set(x,y,c);
  }
  
  color getPixelXY(int x, int y){
    return img.get(x,y);
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
  
  void changeChannel(Filter f, int val){
    switch(f){
      case REDCHANNEL:
              channels[0] = val;
              break;
      case GREENCHANNEL:
              channels[1] = val;
              break;
      case BLUECHANNEL:
              channels[2] = val;
              break;
      case ALPHACHANNEL:
              channels[3] = val;
              break;
    }
    
  }
  
  int getRedChannel(){
     return this.channels[0];
  }
  
  int getGreenChannel(){
     return this.channels[1];
  }
  
  int getBlueChannel(){
     return this.channels[2];
  }
  
  int getAlphaChannel(){
     return this.channels[3];
  }
  
}
