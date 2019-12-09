import java.util.*;

class FPImage {
  PImage img;
  PImage orginal_img;
  Filter filter;
  
  FPImage(PImage img, Filter filter){
    this.img = img;
    this.orginal_img = img.copy();
    this.filter = filter;
  }
  
  PImage getImg(){
   return img; 
  }
  
  PImage getOrgImg(){
    return orginal_img;
  }
  
   Filter getFilter(){
   return filter; 
  }
  
  void setChannel(PImage image){
    this.img = image;
  }
  
  void resetNode(){
    this.img = orginal_img.copy();
  }
  
}


class ImageList{
  LinkedList<FPImage> list = new LinkedList<FPImage>();
  
  void push(FPImage img) {
     list.add(img);
  }
  
  void resetToOrginal(){
    if(!list.isEmpty()){
      list.getLast().resetNode();
    }
  }
  
  void addAtIndex(int i, FPImage img){
      list.add(i, img);
    }
    
  PImage getPrevImg(){
    if (list.size() == 1) return peekCurrOrgImg();
    
    int prev_index = list.size() - 2;
    return list.get(prev_index).getImg();
  }
  
  void setChannel(PImage image){
    list.peekLast().setChannel(image);
  }
  
  PImage peekFirst(){
    return list.peekFirst().getImg();
  }
  
  PImage peekCurrOrgImg(){
    return list.peekLast().getOrgImg();
  }
  
  PImage peekCurrImg(){
    return list.peekLast().getImg();
  }
  
  PImage peekOrgImg(){
    return list.peek().getImg();
  }
  
  Filter getCurrFilter(){
    return list.peekLast().getFilter();
  }
  
  FPImage popCurrImg(){
    return list.pop();
  }
  
  void clearLastImg(){
    list.getLast().resetNode();
  }
  
  void removeAllFilters(){
     FPImage org = list.getFirst();
     list.clear();
     push(org);
  }
  
  void clearAll(){
    list.clear();
  }
  
  int listSize(){
     return list.size(); 
  }
  
}
