class DropDownArray {
  Filter[] filters = {Filter.NONE, Filter.GREYSCALE, 
                      Filter.NEGATIVE, Filter.EDGE, 
                      Filter.GAUSS, Filter.BOX_BLUR, 
                      Filter.SHARP, Filter.CONVOLUTION, Filter.COLORTOALPHA};
  
  int getSize(){
    return filters.length;
  }
  
  Filter fromIndex(int i){
    return filters[i];
  }
  
  String display(int i){
    return filters[i].asString();    
  }
  
}

class DropDownArray2 {
  

  Mode[] modes = {Mode.AVERAGE,Mode.LIGHTNESS,Mode.LUMINOSITY,Mode.SEPIA};
  
  int getSize(){
    return modes.length;
  }
  
  Mode fromIndex(int i){
    return modes[i];
  }
  
  String display(int i){
    return modes[i].asString();    
  }
  
}
