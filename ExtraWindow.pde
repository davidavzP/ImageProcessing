class ExtraWindow extends PApplet{
  
  mainFunctions execute = new mainFunctions(){ void doSettings(){}; void doSetup(){}; void doDraw(){}; };
  
  ExtraWindow(mainFunctions mF){
    super();
    execute = mF;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }
  
  void settings(){
    execute.doSettings();
  }
  
  void setup(){
    execute.doSetup();
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
