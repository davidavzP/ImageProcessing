class DropDownArray {
  Filter[] filters = {Filter.GREYSCALE, Filter.CONVOLUTION, Filter.NONE};
  
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
