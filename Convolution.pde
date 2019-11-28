enum Convolution{
  EDGE{
        public float[][] getMatrix(){
          return new float[][]{ { -1 , -1 , -1 },
                                { -1 ,  8 , -1 },
                                { -1 , -1 , -1 } };
        }
  },
  SHARP{
        public float[][] getMatrix(){
          return new float[][]{ {  0 , -1 ,  0 },
                                { -1 ,  5 , -1 },
                                {  0 , -1 ,  0 } };
        }
  };
  
  public abstract float[][] getMatrix();
}
