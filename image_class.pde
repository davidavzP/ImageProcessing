class Image{
  
  ImageList img_hist = new ImageList();
  
  PImage img;
  PImage original_img;
  int img_width;
  int img_height;
  FilterApplier filter_applier = new FilterApplier();
  int[] channels = {0,0,0,1};
  int refreshrate = 60; //every x frames filters are reapplied


  
  
   //loads an Image from a file
  Image(String file){
    img = loadImage(file);
    original_img = loadImage(file);
    this.img_width = img.width;
    this.img_height = img.height;
    
    FPImage fpimg = new FPImage(img, Filter.NONE);
    img_hist.push(fpimg);
  }
  
  //creates an Emtpy Image
  Image(int img_width, int img_height){
    img = createImage(img_width, img_height, RGB);
    original_img = createImage(img_width, img_height, RGB);
    this.img_width = img.width;
    this.img_height = img.height;
  }
  
  
  void newFilter(Filter filter){
    //apply filter to last thing in the linked then append new img then apply any red blue or green values
    //need to check the Linked list to see if the filter already exists to not have overlaps...maybe 
    //add some order to ensure that negative is the last thing applied 
    //then make logic for applying the rbg values on top
    if (filter != Filter.NONE){
      PImage curr_img = img_hist.peekCurrImg().copy();
      PImage filtered_img = filter_applier.applyFilter(curr_img, filter); 
      FPImage fpimg = new FPImage(filtered_img, filter);
      img_hist.push(fpimg);
    }
    else {
      img_hist.removeFilters(); 
      
    }
  }
  
  void resize_img(int new_width, int new_height){
    this.img_width = new_width;
    this.img_height = new_height;
    this.img.resize(img_width, img_height);
    this.original_img.resize(img_width, img_height);
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
    //return this.img;
    return img_hist.peekCurrImg();
  }
  
  void image_updatePixels(){
    img_hist.peekCurrImg().updatePixels();
  }
  
  void image_loadPixels(){
    img_hist.peekCurrImg().loadPixels();
  }
  
  int getWidth(){
    return img_width;
  }
  
  int getHeight(){
    return img_height;
  }
  
  //this will actually change the last img value to be the new rgb value
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
