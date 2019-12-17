
class ConvolutionGUI extends PApplet {
  ControlP5 cp5_conv;
  float[][] testing = new float[][]{ { -1 , -1 , -1 },
                                { -1 ,  8 , -1 },
                                { -1 , -1 , -1 } };
  Matrix myMatrix = new Matrix(testing, 3,3);
  
  
        
 
  
  public ConvolutionGUI(){
    super();
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
    
  }
  
   public void settings() {
    size(400, 400, P3D);
    smooth();
  }
  
  public void setup() {
    surface.setTitle("Convolution");
    cp5_conv = new ControlP5(this);
    buildGUI();
    
  }
  
  private void buildGUI(){
    buildTextFieldMatrix();
    createConvolButton();
  }
  
  private void buildTextFieldMatrix(){
    PFont font = createFont("arial",20);
    createTextFieldMatrix(74, 100);
    textFont(font); 
  }
  
  private void createConvolButton(){
        cp5_conv.addBang("convolve")
   .setPosition(150,25)
   .setSize(100,50)
   .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
   ;    
  }
  
  
  private void createTextFieldMatrix(int x, int y){
     int posx = x;
     for(int i = 0; i < 3;i++){
        int posy = y;
      for(int j = 0; j < 3;j++){
         println("x: " + x + " y: " + y);
         createTextField("convMatrixVal" + i + j , posx,posy, i, j);
         posy += 100;
        }
        posx += 100;
     }
  }
  
  private void createTextField(String name, int x, int y, int i, int j){
    cp5_conv.addTextfield(name)
     .setPosition(x,y)
     .setSize(50,40)
     .setText(str(myMatrix.getValue(i,j)))
     .setCaptionLabel("")
     .setFont(createFont("arial",20))
     .setAutoClear(false)
     ;
  }
  
  public void draw(){
    background(0);
  }
  
  void stop(){
    exit();
  }
  
  public void convolve() {
    getMatrixValues();
    Filter filter = Filter.USRCONVOLUTION;
    filter.setMatrix(myMatrix);
    img_gui.newFilter(filter);
    
  }
  
  private void getMatrixValues(){
    for(int i = 0; i < 3;i++){
      for(int j = 0; j < 3;j++){
        String input = cp5_conv.get(Textfield.class,"convMatrixVal"+i+j).getText();
        float f = toNumeric(input);
        print("val: " + f); 
        myMatrix.setValue(i,j,f);
      }
    }
  }
  
  public float toNumeric(String strNum) {
        float d = 0.0;
      if (strNum == null) {
          return 0.0;
      }
      try {
           d = Float.parseFloat(strNum);
      } catch (NumberFormatException nfe) {
          return 0.0;
      }
      return d;
  }
 
  void close(){
    exit();
  }
}
