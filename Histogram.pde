class Histogram extends PApplet {
  
  PImage image;
  int[] red_h;
  int[] green_h;
  int[] blue_h;
  
  public Histogram(PImage image) {
    super();
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
    red_h = new int[256];
    green_h = new int[256];
    blue_h = new int[256];
    update(image);
  }
  
  public void settings() {
    size(600, 400, P3D);
    smooth();
  }
  
  public void setup() {
    surface.setTitle("Histogram");
  }
  
  public void draw() {
    
    if (frameCount % 60 == 0) {
    background(0);
    
    //calculate values
    for (int x = 0; x < image.width; x++) {
      for (int y = 0; y < image.height; y++) {
        int loc = x + y*image.width;
        int r = int(red(image.pixels[loc]));
        int g = int(green(image.pixels[loc]));
        int b = int(blue(image.pixels[loc]));
        red_h[r]++;
        green_h[g]++;
        blue_h[b]++;
        
      }
      
      // Map x (from 0..image.width) to a location in the histogram (0..255)
      int which = int(map(x, 0, width, 0, 255));
      
      int max_h = max( max(red_h), max(green_h), max(blue_h) );
      
      // Convert the histogram value to a location between 
      // the bottom and the top of the picture
      int r = int(map(red_h[which], 0, max_h, height, 0));
      int g = int(map(green_h[which], 0, max_h, height, 0));
      int b = int(map(blue_h[which], 0, max_h, height, 0));
      
      stroke(255, 0, 0, 120);
      line(x, height, x, r);
      set(x, r, color(255, 0, 0));
      
      stroke(0, 255, 0, 120);
      line(x, height, x, g);
      set(x, g, color(0, 255, 0));
      
      stroke(0, 0, 255, 120);
      line(x, height, x, b);
      set(x, b, color(0, 0, 255));
    }
    
    }
  }
  
  void update(PImage image) {
    this.image = image;  
  }
  
}
