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
  GAUSS{
    @Override
        public String asString() {
            return GAUSS.toString();
        }
  },
  BOX_BLUR{
    @Override
        public String asString() {
            return BOX_BLUR.toString();
        }
  },
  SHARP{
    @Override
        public String asString() {
            return SHARP.toString();
        }
  },
  EDGE{
    @Override
        public String asString() {
            return EDGE.toString();
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
