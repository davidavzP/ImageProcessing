import java.util.*;

class FPImage {
  PImage img;
  Filter filter;
  
  FPImage(PImage img, Filter filter){
    this.img = img;
    this.filter = filter;
  }
  
  PImage getImg(){
   return img; 
  }
  
   Filter getFilter(){
   return filter; 
  }
  
}

class ImageList{
  LinkedList<FPImage> list = new LinkedList<FPImage>();
  
  void push(FPImage img) {
     list.add(img);
  }
  
  void addAtIndex(int i, FPImage img){
      list.add(i, img);
  }
  
  PImage peekCurrImg(){
    return list.peekLast().getImg();
  }
  
  Filter peekCurrFilter(){
    return list.peekLast().getFilter(); 
  }
  
  PImage peekOrgImg(){
    return list.peek().getImg();
  }
  
  
}
