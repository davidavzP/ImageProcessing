import java.util.*;

class FPImage {
  PImage img;
  PImage orginal_img;
  Filter filter;
  Histogram histogram;
  
  FPImage(PImage img, Filter filter){
    this.img = img;
    this.orginal_img = img.copy();
    this.filter = filter;
    histogram = new Histogram(img, filter.asString());
  }
  
  void adjustHistogram(int[] pos, int[] size){
     histogram.setPos(pos);
     histogram.setSize(size);
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
    updateHistogram();
  }
  
  void resetNode(){
    this.img = orginal_img.copy();
    updateHistogram();
  }
  
  void HistDraw(){
    histogram.HistDraw();  
  }
  
  void updateHistogram(){
    histogram.update(img);  
  }
  
}


class ImageList{
  LinkedList<FPImage> list = new LinkedList<FPImage>();
  int[] histogram_start_pos = new int[]{800, 0};
  int[] histogram_size = new int[]{100,100};
  
  void push(FPImage img) {
     list.add(img);
     arrangeHists();
  }
  
  void resetToOrginal(){
    if(!list.isEmpty()){
      list.getLast().resetNode();
    }
  }
  
  void addAtIndex(int i, FPImage img){
      list.add(i, img);
      arrangeHists();
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
    FPImage result = list.pop();
    arrangeHists();
    return result;
  }
  
  void clearLastImg(){
    list.getLast().resetNode();
  }
  
  void removeAllFilters(){
     FPImage org = list.getFirst();
     list.clear();
     push(org);
     arrangeHists();
  }
  
  void clearAll(){
    list.clear();
  }
  
  int listSize(){
     return list.size(); 
  }
  
  void update(){
    for (FPImage FP:list) FP.updateHistogram();
  }
  
  void arrangeHists(){
    int maxWidth = width - histogram_start_pos[0];
    int maxHeight = height - histogram_start_pos[1];
    int size_x = maxWidth;
    int size_y = size_x * histogram_size[1]/histogram_size[0];
    int vert_amount = int(maxHeight/size_y);
    int hor_amount = int(maxWidth/size_x);
    
    while (vert_amount * hor_amount < list.size()){
      if ((hor_amount+1) * size_y * histogram_size[0]/histogram_size[1] <= maxWidth) hor_amount++;
      else vert_amount++;
      size_x = int(maxWidth/hor_amount);
      size_y = int(maxHeight/vert_amount); 
    }
    /*
    while (hor_amount * size_x > width - histogram_start_pos[0]){
      size_x--;
      size_y -= round(size_y/(size_x+1));
      vert_amount = int(height/size_y);
      hor_amount = int(list.size()/vert_amount)+1;
      if (list.size()%vert_amount != 0 && list.size() > vert_amount) hor_amount++;
    }
    */
    for (int i = 0; i < list.size(); i++){
      int pos_x = histogram_start_pos[0] + size_x * int(i / vert_amount);
      int pos_y =  histogram_start_pos[1] + size_y * (i % vert_amount);
      list.get(i).adjustHistogram(new int[]{pos_x, pos_y}, new int[]{size_x-1, size_y-1});
    }
    stroke(255);
    for (int x = histogram_start_pos[0]-1; x < width; x += size_x) line(x, histogram_start_pos[1], x, height);      
    for (int y = histogram_start_pos[1]+size_y; y < height; y += size_y) line(histogram_start_pos[0], y, width, y);      
        
  }
  
  void HistDraw(){
    arrangeHists();
    for (FPImage FP:list) FP.HistDraw();
  }
  
}
