class Histogram extends PApplet {
  
  PImage image;
  int[] reds;
  int[] greens;
  int[] blues;
  int[] red_h;
  int[] green_h;
  int[] blue_h;
  
  public Histogram(PImage image) {
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
    frameRate(1);
  }
  
  public void draw() {
    
    background(0);
    
    for (int i = 0; i < width; i++) {
      stroke(255, 0, 0, 110);
      line(i, height, i, red_h[i]);
      stroke(255, 0, 0);
      if (i > 0) line(i-1, red_h[i-1], i, red_h[i]);
      
      stroke(0, 255, 0, 80);
      line(i, height, i, green_h[i]);
      stroke(0, 255, 0);
      if (i > 0) line(i-1, green_h[i-1], i, green_h[i]);
      
      stroke(0, 0, 255, 100);
      line(i, height, i, blue_h[i]);
      stroke(0, 0, 255);
      if (i > 0) line(i-1, blue_h[i-1], i, blue_h[i]);
    }
    
  }
  
  void update(PImage image) {
    //if (this.image == image) { return; }
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
        int loc = x + y*image.width;
        int r = int(red(image.pixels[loc]));
        int g = int(green(image.pixels[loc]));
        int b = int(blue(image.pixels[loc]));
        reds[r]++;
        greens[g]++;
        blues[b]++;
        
      }
    }
    
    for (int i = 0; i < width; i++) {
      // Map i (from 0..width) to a location in the histogram (0..255)
      int which = int(map(i, 0, width, 0, 255));
      
      int max_h = max( max(reds), max(greens), max(blues) );
      max_h = constrain(max_h, 0, 45000);// 1/8 of maximum value (600^2)

      // Convert the histogram value to a location between 
      // the bottom and the top of the picture
      red_h[i] = int(map(reds[which], 0, max_h, height, 0));
      green_h[i] = int(map(greens[which], 0, max_h, height, 0));
      blue_h[i] = int(map(blues[which], 0, max_h, height, 0));
    }

  }
  
}
