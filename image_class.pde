class Image{
  
  ImageList img_hist = new ImageList();
  FilterApplier filter_applier = new FilterApplier();
  ExtHistogram histogram;
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
    histogram = new ExtHistogram(img);
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
  
  void changeGreyscale(Mode mode){
    filter_applier.setGreyscale(mode);
  }

  void resize_img(int new_width, int new_height){
    img_hist.clearAll();
    setToResize(new_width, new_height);
    addThisImg();
  }
  
  private void setToResize(int new_width, int new_height){
    this.img_width = new_width;
    this.img_height = new_height;
    this.img.resize(img_width, img_height);
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
  
  void changeChannel(Filter new_f, float val){
    img_hist.clearLastImg();
    PImage prev = img_hist.getPrevImg().copy();
    Filter filter = img_hist.getCurrFilter();
    setNewChannel(new_f, filter, val, prev);
    updateHistograms();
  }
  
  private void setNewChannel(Filter new_f, Filter filter, float val, PImage prev){
    PImage channel_img = getChannel(new_f, val, prev);
    channel_img = filter_applier.changeRGBChannels(prev, channels);
    PImage filtered_img = filter_applier.applyFilter(channel_img, filter);
    img_hist.setChannel(filtered_img);
  }
  
  private void updateHistograms(){
    img_hist.update();
    histogram.update(this.getImage());
  }
  
  private PImage getChannel(Filter f, float val, PImage prev){
    PImage channel_img = prev;
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
              channels[3] = (100 - val)/100;
              channel_img = prev;
              break;
    }
    return channel_img;
  }
  
}
