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
  LinkedList<Histogram> histograms = new LinkedList<Histogram>();
  
  void push(FPImage img) {
     list.add(img);
     int newY = histogram_pos[1] + histograms.size() * histogram_size[1];
     histograms.add(new Histogram(img.getImg(), new int[]{histogram_pos[0],newY}, histogram_size));
  }
  
  void resetToOrginal(){
    if(!list.isEmpty()){
      list.getLast().resetNode();
      histograms.getLast().update(list.getLast().getImg());
    }
  }
  
  void addAtIndex(int i, FPImage img){
      list.add(i, img);
      int newY = histogram_pos[1] + i * histogram_size[1];
      histograms.add(new Histogram(img.getImg(), new int[]{histogram_pos[0],newY}, histogram_size));
      for (int j = i+1; j<histograms.size(); j++){
        newY = histogram_pos[1] + j * histogram_size[1];
        histograms.get(j).setPos(histogram_pos[0], newY);
      }
    }
    
  PImage getPrevImg(){
    if (list.size() == 1) return peekCurrOrgImg();
    
    int prev_index = list.size() - 2;
    return list.get(prev_index).getImg();
  }
  
  void setChannel(PImage image){
    list.peekLast().setChannel(image);
    histograms.peekLast().update(image);
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
    histograms.pop();
    return list.pop();
  }
  
  void clearLastImg(){
    list.getLast().resetNode();
    histograms.getLast().update(list.getLast().getImg());
  }
  
  void removeAllFilters(){
     FPImage org = list.getFirst();
     list.clear();
     push(org);
     histograms.clear();
     histograms.add(new Histogram(org.getImg(), histogram_pos, histogram_size));
  }
  
  void clearAll(){
    list.clear();
    histograms.clear();
  }
  
  int listSize(){
     return list.size(); 
  }
  
  void HistDraw(){
    for (Histogram H:histograms) H.HistDraw();
  }
  
  void update(){
    for (int i = 0; i < histograms.size(); i++) histograms.get(i).update(list.get(i).getImg());
  }
  
}
