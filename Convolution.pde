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
  },
  BOX_BLUR{
        public float[][] getMatrix(){
          return new float[][]{ {  1/9 , 1/9 , 1/9 },
                                {  1/9 , 1/9 , 1/9 },
                                {  1/9 , 1/9 , 1/9 } };
        }
  },
  GAUSS{
        public float[][] getMatrix(){
          return new float[][]{ { 1/16 , 2/16 , 1/16 },
                                { 2/16 , 4/16 , 2/16 },
                                { 1/16 , 2/16 , 1/16 } };
        }
  };
  
  public abstract float[][] getMatrix();
}
