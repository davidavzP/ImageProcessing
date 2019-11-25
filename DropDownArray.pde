class DropDownArray {
  Filter[] filters = {Filter.NONE, Filter.GREYSCALE, Filter.NEGATIVE, Filter.EDGE, Filter.GAUSS, Filter.BOX_BLUR, Filter.SHARP, Filter.CONVOLUTION};
  
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
