class Image{
  
  ImageList img_hist = new ImageList();
  FilterApplier filter_applier = new FilterApplier();
  Histogram histogram;
  PImage img;
  int img_width;
  int img_height;
  
  float[] channels = {0, 0, 0 , 1};

 
  //loads an Image from a file
  Image(String file){
    img = loadImage(file);
    this.img_width = img.width;
    this.img_height = img.height;
    addThisImg();
    filter_applier.setBackground(loadImage("transparencySquare.jpg"));
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
    histogram = new Histogram(img);
  }
  
  void newFilter(Filter filter){
    //apply filter to last thing in the linked then append new img then apply any red blue or green values
    //need to check the Linked list to see if the filter already exists to not have overlaps...maybe 
    if (filter != Filter.NONE){
      addFilter(filter);
    } else {
      img_hist.removeAllFilters();
    }
    changeChannel(Filter.NONE, 0);
  }
  
  void addFilter(Filter filter){
      img_hist.clearLastImg();
      PImage curr_img = img_hist.peekCurrOrgImg().copy();
      PImage filtered_img = filter_applier.applyFilter(curr_img, filter); 
      FPImage fpimg = new FPImage(filtered_img, filter);
      if (filter == Filter.GREYSCALE) fpimg.setTitle(filter_applier.getGreyscale().asString()); 
      img_hist.push(fpimg);
  }
  

  void changGreyscale(Mode mode){
    filter_applier.setGreyscale(mode);
  }

  void resize_img(int new_width, int new_height){
    img_hist.clearAll();
    this.img_width = new_width;
    this.img_height = new_height;
    this.img.resize(img_width, img_height);
     //this should do resizing
    addThisImg();
    
  }
  
  void setPixelXY(int x, int y, color c){
    img.set(x,y,c);
  }
  
  color getPixelXY(int x, int y){
    return img.get(x,y);
  }
  
  color getCurrPixelXY(int x, int y){
    return img_hist.peekCurrImg().get(x,y);
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
    img_hist.HistDraw();
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
  void changeChannel(Filter f, float val){
    
    img_hist.clearLastImg();
    PImage prev = img_hist.getPrevImg().copy();
    Filter filter = img_hist.getCurrFilter();
    PImage channel_img;
    
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
      // to be fixed
              channels[3] = (100 - val)/100;
              channel_img = prev;
              break;
      default:
              channel_img = prev;
              break;
    }
    
    channel_img = filter_applier.changeRGBChannels(prev, channels);
    PImage filtered_img = filter_applier.applyFilter(channel_img, filter);
    img_hist.setChannel(filtered_img);
    img_hist.update();
    histogram.update(this.getImage());
  }
  
}
