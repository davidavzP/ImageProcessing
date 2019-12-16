class ExtraWindow extends PApplet{
  
  mainFunctions execute = new mainFunctions(){ void doSettings(){}; void doSetup(){}; void doDraw(){}; };
  
  ExtraWindow(mainFunctions mF){
    super();
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
    execute = mF;
  }
  
  void settings(){
    size(500, 400, P3D);
    smooth();
    //execute.doSettings();
  }
  
  void setup(){
    surface.setTitle("Histogram");
    //execute.doSetup();
  }
  
  void draw(){
    execute.doDraw();
  }
  
}

interface mainFunctions{
  void doSettings();
  void doSetup();
  void doDraw();
}
