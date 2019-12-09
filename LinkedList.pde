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
  
   Filter getFilter(){
   return filter; 
  }
  
  PImage getOrgImg(){
    return orginal_img;
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
