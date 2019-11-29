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
  REDCHANNEL{
    @Override
        public String asString() {
            return REDCHANNEL.toString();
        }
  },
  GREENCHANNEL{
    @Override
        public String asString() {
            return GREENCHANNEL.toString();
        }
  },
  BLUECHANNEL{
    @Override
        public String asString() {
            return BLUECHANNEL.toString();
        }
  },
  ALPHACHANNEL{
    @Override
        public String asString() {
            return ALPHACHANNEL.toString();
        }
  },
  COLORTOALPHA{
    @Override
        public String asString() {
            return COLORTOALPHA.toString();
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
