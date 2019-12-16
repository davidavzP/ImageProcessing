class ExtHistogram extends PApplet {
  
  PImage image;
  int[] reds;
  int[] greens;
  int[] blues;
  int[] red_h;
  int[] green_h;
  int[] blue_h;
  
  public ExtHistogram(PImage image) {
    super();
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
    reds = new int[256];
    greens = new int[256];
    blues = new int[256];
    red_h = new int[width];
    green_h = new int[width];
    blue_h = new int[width];
    update(image);
  }
  
  public void settings() {
    size(500, 400, P3D);
    smooth();
  }
  
  public void setup() {
    surface.setTitle("Histogram");
  
  }
  
  public void draw() {
    background(0);
    
    for (int i = 0; i < width; i++) {
      int loc_i = i;
      stroke(255, 0, 0, 110);
      line(loc_i, height, loc_i, height - red_h[i]);
      stroke(255, 0, 0);
      if (i > 0) line(loc_i-1, height - red_h[i-1], loc_i, height - red_h[i]);
      
      stroke(0, 255, 0, 80);
      line(loc_i, height, loc_i, height - green_h[i]);
      stroke(0, 255, 0);
      if (i > 0) line(loc_i-1, height - green_h[i-1], loc_i, height - green_h[i]);
      
      stroke(0, 0, 255, 100);
      line(loc_i, height, loc_i, height - blue_h[i]);
      stroke(0, 0, 255);
      if (i > 0) line(loc_i-1, height - blue_h[i-1], loc_i, height - blue_h[i]);
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
    int max_h = max( max(reds) , max(greens) , max(blues) );
    
    for (int i = 0; i < width; i++) {
      // Map i (from 0..width) to a location in the histogram (0..255)
      int index = int(255 * i/width);
      // Convert the histogram value to a location between 
      // the bottom and the top of the picture

     //logarithmic scale
      red_h[i] = round(height * log(reds[index] + 1)/log(max_h + 1));
      green_h[i] = round(height * log(greens[index] + 1)/log(max_h + 1));
      blue_h[i] = round(height * log(blues[index] + 1)/log(max_h + 1));
    
/*
      //linear scale with constrains
      red_h[i] = int(map(reds[which], 0, max_h, height, 0)); //<>//
      green_h[i] = int(map(greens[which], 0, max_h, height, 0));
      blue_h[i] = int(map(blues[which], 0, max_h, height, 0));
*/
    }
  }
  
  void stop(){
    exit();
  }
  void exit()
  {
    dispose();
    //object = null;
  }
}
