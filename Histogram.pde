class Histogram{ //extends PApplet {
  
  PImage image;
  String title;
  int[] position = new int[]{600,0};
  int h_width = 200;   // histogram height
  int h_height = 200;  // histogram width
  int[] reds;    //amount of pixels with their red value = index
  int[] greens;
  int[] blues;
  int[] red_h;  //height of the histogram graph
  int[] green_h;
  int[] blue_h;
  
  public Histogram(PImage image, String title) {
    //super();
    //PApplet.runSketch(new String[]{this.getClass().getName()}, this);
    this.title = title;
    reds = new int[256];
    greens = new int[256];
    blues = new int[256];
    red_h = new int[h_width];
    green_h = new int[h_width];
    blue_h = new int[h_width];
    update(image);
  }
  
  void setPos(int[] pos){
    position = pos;
  }
  
  void setSize(int[] size){
    h_width = size[0];
    h_height = size[1];
    red_h = new int[h_width];
    green_h = new int[h_width];
    blue_h = new int[h_width];
    update(image);
  }
  
  public void HistDraw() {
    
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

    fill(0);
    stroke(0);
    int txtSize = h_height/20;
    textSize(txtSize);
    int max_h = max( max(reds) , max(greens) , max(blues) );
    
    for (float pos = 1; pos > 0; pos -= 0.25){
      int value = round(pow(max_h+1, pos)-1);  
      text(value, position[0]+1, position[1]+txtSize+(1-pos)*h_height);
      line(position[0], position[1]+(1-pos)*h_height, position[0]+txtSize, position[1]+(1-pos)*h_height);
    }
    
    text(0, position[0], position[1]+h_height-txtSize/8);
    text(255, position[0]+h_width-2*txtSize, position[1]+h_height-txtSize/8);
    
    text(title, position[0]+h_width/2, position[1]+txtSize);
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
    int max_h = max( max(reds) , max(greens) , max(blues) );
    
    for (int i = 0; i < h_width; i++) {
      // Map i (from 0..width) to a location in the histogram (0..255)
      int index = int(255 * i/h_width);
      // Convert the histogram value to a location between 
      // the bottom and the top of the picture
      
     //logarithmic scale
      red_h[i] = round(h_height * log(reds[index] + 1)/log(max_h + 1));
      green_h[i] = round(h_height * log(greens[index] + 1)/log(max_h + 1));
      blue_h[i] = round(h_height * log(blues[index] + 1)/log(max_h + 1));
    
    }

  }
  
}
