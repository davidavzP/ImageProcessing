enum Filter{
  GREYSCALE{
  @Override
        public String asString() {
            return GREYSCALE.toString();
        }
      
  },
  NEGATIVE{
  @Override
        public String asString() {
            return NEGATIVE.toString();
        }
      
  },
  CONVOLUTION{
    @Override
        public String asString() {
            return CONVOLUTION.toString();
        }
  
  },
  NONE{
    @Override
        public String asString() {
            return NONE.toString();
        }
  };
  
 
  public abstract String asString();

  
}
