class Image{
  
  ImageList img_hist = new ImageList();
  FilterApplier filter_applier = new FilterApplier();
  
  PImage img;
  int img_width;
  int img_height;

  
  // unused code
  //int refreshrate = 60; //every x frames filters are reapplied

 
  //loads an Image from a file
  Image(String file){
    img = loadImage(file);
    this.img_width = img.width;
    this.img_height = img.height;
    addThisImg();
  }
  
  private void addThisImg(){
    FPImage fpimg = new FPImage(this.img, Filter.NONE);
    img_hist.push(fpimg);
  }
  
  
  //creates an Emtpy Image
  Image(int img_width, int img_height){
    img = createImage(img_width, img_height, RGB);
    this.img_width = img.width;
    this.img_height = img.height;
  }
  
  void newFilter(Filter filter){
    //apply filter to last thing in the linked then append new img then apply any red blue or green values
    //need to check the Linked list to see if the filter already exists to not have overlaps...maybe 
    //add some order to ensure that negative is the last thing applied 
    //then make logic for applying the rbg values on top
    if (filter != Filter.NONE){
      img_hist.clearLastImg();
      PImage curr_img = img_hist.peekCurrOrgImg().copy();
      PImage filtered_img = filter_applier.applyFilter(curr_img, filter); 
      FPImage fpimg = new FPImage(filtered_img, filter);
      img_hist.push(fpimg);
    }
    else {
      img_hist.removeAllFilters(); 
    }
    changeChannel(Filter.NONE, 0);
  }
  
  void resize_img(int new_width, int new_height){
    img_hist.clearAll();
    this.img_width = new_width;
    this.img_height = new_height;
    this.img.resize(img_width, img_height);
    addThisImg();
    
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
    
    img_hist.clearLastImg();
    PImage prev = img_hist.getPrevImg().copy();
    Filter filter = img_hist.getCurrFilter();
    PImage channel_img;
    
    switch(f){
      case REDCHANNEL:
              channel_img = filter_applier.changeRedChannel(prev, val);
              break;
      case GREENCHANNEL:
              channel_img = filter_applier.changeGreenChannel(prev, val);
              break;
      case BLUECHANNEL:
              channel_img = filter_applier.changeBlueChannel(prev, val);
              break;
      case ALPHACHANNEL:
              channel_img = filter_applier.changeAlphaChannel(prev, val);
              break;
      default:
              channel_img = prev;
              break;
    }
    
    PImage filtered_img = filter_applier.applyFilter(channel_img, filter);
    img_hist.setChannel(filtered_img);
  }
  
}
