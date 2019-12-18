enum Filter{
  GREYSCALE{
  @Override
        public String asString() {
            return GREYSCALE.toString();
        }
        
  @Override    
        public void setMatrix(Matrix x){
          m = x;
        }
  @Override   
        public Matrix getMatrix(){
            return m;
        }
  },
  NEGATIVE{
    @Override
          public String asString() {
              return NEGATIVE.toString();
          }
    @Override    
        public void setMatrix(Matrix x){
          m = x;
        }
    @Override   
        public Matrix getMatrix(){
            return m;
        }
  },
  CONVOLUTION{
    @Override
        public String asString() {
            return CONVOLUTION.toString();
        }
     @Override    
        public void setMatrix(Matrix x){
          m = x;
        }
    @Override   
        public Matrix getMatrix(){
            return m;
        }
  },
  USRCONVOLUTION{
    
    @Override
        public String asString() {
            return USRCONVOLUTION.toString();
        }
    @Override    
        public void setMatrix(Matrix x){
          m = x;
        }
    @Override   
        public Matrix getMatrix(){
            return m;
        }
        
        
        
  },
  GAUSS{
    @Override
        public String asString() {
            return GAUSS.toString();
        }
          @Override    
        public void setMatrix(Matrix x){
          m = x;
        }
    @Override   
        public Matrix getMatrix(){
            return m;
        }
  },
  BOX_BLUR{
    @Override
        public String asString() {
            return BOX_BLUR.toString();
        }
         @Override    
        public void setMatrix(Matrix x){
          m = x;
        }
    @Override   
        public Matrix getMatrix(){
            return m;
        }
  },
  SHARP{
    @Override
        public String asString() {
            return SHARP.toString();
        }
        
         @Override    
        public void setMatrix(Matrix x){
          m = x;
        }
    @Override   
        public Matrix getMatrix(){
            return m;
        }
  },
  EDGE{
    @Override
        public String asString() {
            return EDGE.toString();
        }
        
         @Override    
        public void setMatrix(Matrix x){
          m = x;
        }
    @Override   
        public Matrix getMatrix(){
            return m;
        }
  },
  REDCHANNEL{
    @Override
        public String asString() {
            return REDCHANNEL.toString();
        }
        
          @Override    
        public void setMatrix(Matrix x){
          m = x;
        }
    @Override   
        public Matrix getMatrix(){
            return m;
        }
  },
  GREENCHANNEL{
    @Override
        public String asString() {
            return GREENCHANNEL.toString();
        }
        
          @Override    
        public void setMatrix(Matrix x){
          m = x;
        }
    @Override   
        public Matrix getMatrix(){
            return m;
        }
  },
  BLUECHANNEL{
    @Override
        public String asString() {
            return BLUECHANNEL.toString();
        }
          @Override    
        public void setMatrix(Matrix x){
          m = x;
        }
    @Override   
        public Matrix getMatrix(){
            return m;
        }
  },
  ALPHACHANNEL{
    @Override
        public String asString() {
            return ALPHACHANNEL.toString();
        }
          @Override    
        public void setMatrix(Matrix x){
          m = x;
        }
    @Override   
        public Matrix getMatrix(){
            return m;
        }
  },
  COLORTOALPHA{
    @Override
        public String asString() {
            return COLORTOALPHA.toString();
        }
          @Override    
        public void setMatrix(Matrix x){
          m = x;
        }
    @Override   
        public Matrix getMatrix(){
            return m;
        }
  },
  MANDEL{
    @Override
        public String asString() {
            return MANDEL.toString();
        }
          @Override    
        public void setMatrix(Matrix x){
          m = x;
        }
    @Override   
        public Matrix getMatrix(){
            return m;
        }
  },
  NONE{
    @Override
        public String asString() {
            return NONE.toString();
        }
         @Override    
        public void setMatrix(Matrix x){
          m = x;
        }
    @Override   
        public Matrix getMatrix(){
            return m;
        }
  };
  
 
  public abstract String asString();
  public abstract Matrix getMatrix();
  public abstract void setMatrix(Matrix m);
  public Matrix m;
  
}


enum Mode{
  AVERAGE{
  @Override
        public String asString() {
            return AVERAGE.toString();
        }
  },
  LIGHTNESS{
  @Override
        public String asString() {
            return LIGHTNESS.toString();
        }
  },
  LUMINOSITY{
  @Override
        public String asString() {
            return LUMINOSITY.toString();
        }
  },
  SEPIA{
  @Override
        public String asString() {
            return SEPIA.toString();
        }
  };
 
  public abstract String asString();
  
}
