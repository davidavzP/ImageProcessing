class Histogram{ //extends PApplet {
  
  PImage image;
  int[] position;
  int h_width;   // histogram height
  int h_height;  // histogram width
  int[] reds;    //amount of pixels with their red value = index
  int[] greens;
  int[] blues;
  int[] red_h;  //height of the histogram graph
  int[] green_h;
  int[] blue_h;
  
  public Histogram(PImage image, int[] pos, int[] size) {
    //super();
    //PApplet.runSketch(new String[]{this.getClass().getName()}, this);
    h_width = size[0];
    h_height = size[1];
    position = pos;
    reds = new int[256];
    greens = new int[256];
    blues = new int[256];
    red_h = new int[h_width];
    green_h = new int[h_width];
    blue_h = new int[h_width];
    update(image);
  }
  
  void setPos(int X, int Y){
    position = new int[]{X,Y};
  }
  
  
  public void HistDraw() {
    
    //draw black frame around histogram
    stroke(0);
    line(position[0]           , position[1]            , position[0] + h_width , position[1]);
    line(position[0] + h_width , position[1]            , position[0] + h_width , position[1] + h_height);
    line(position[0] + h_width , position[1] + h_height , position[0]           , position[1] + h_height);
    line(position[0]           , position[1] + h_height , position[0]           , position[1]);
    
    
    for (int i = 0; i < h_width; i++) {
      int loc_i = i + position[0];
      int loc_height = h_height + position[1];
      stroke(255, 0, 0, 110);
      line(loc_i, loc_height, loc_i, loc_height - red_h[i]);
      stroke(255, 0, 0);
      if (i > 0) line(loc_i-1, loc_height - red_h[i-1], loc_i, loc_height - red_h[i]);
      
      stroke(0, 255, 0, 80);
      line(loc_i, loc_height, loc_i, loc_height - green_h[i]);
      stroke(0, 255, 0);
      if (i > 0) line(loc_i-1, loc_height - green_h[i-1], loc_i, loc_height - green_h[i]);
      
      stroke(0, 0, 255, 100);
      line(loc_i, loc_height, loc_i, loc_height - blue_h[i]);
      stroke(0, 0, 255);
      if (i > 0) line(loc_i-1, loc_height - blue_h[i-1], loc_i, loc_height - blue_h[i]);
    }
    
  }
  
  void update(PImage image) {
    this.image = image;  
    
    //clear values of the previous picture
    for (int i = 0; i < 256; i++) {
      reds[i] = 0;
      greens[i] = 0;
      blues[i] = 0;
    }
    
    //calculate values
    for (int x = 0; x < image.width; x++) {
      for (int y = 0; y < image.height; y++) {
        color col = image.get(x,y);
        int r = int(red(col));
        int g = int(green(col));
        int b = int(blue(col));
        reds[r]++;
        greens[g]++;
        blues[b]++;
      }
    }
    int max_h = max( max(reds) / 10, max(greens) / 10, max(blues) / 10 ); //<>//
    constrain(max_h, 0, int(image.width*image.height/8));
    
    
    
    for (int i = 0; i < h_width; i++) {
      // Map i (from 0..width) to a location in the histogram (0..255)
      int index = int(255 * i/h_width);
      // Convert the histogram value to a location between 
      // the bottom and the top of the picture
      

      red_h[i] = int(h_height * reds[index]/max_h);
      green_h[i] = int(h_height * greens[index]/max_h);
      blue_h[i] = int(h_height * blues[index]/max_h);
      constrain(red_h[i], 0, int(image.width*image.height/8));
      constrain(green_h[i], 0, int(image.width*image.height/8));
      constrain(blue_h[i], 0, int(image.width*image.height/8));
      
     
     //logarithmic scale, but processing is bad at small numbers and makes them zero which breaks it
      //red_h[i] = h_height * round(log((h_height * float(reds[index])/(max_h)) + 1)/log(h_height+1));
      //green_h[i] = h_height * round(log((h_height * float(greens[index])/(max_h)) + 1)/log(h_height+1));
      //blue_h[i] = h_height * round(log((h_height * float(blues[index])/(max_h)) + 1)/log(h_height+1));
    
    }

  }
  
}
