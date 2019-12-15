void createDropdownList(){
  ddarray1 = new DropDownArray();
  ddarray2 = new DropDownArray2();
  // cp5 is the gui
  d1 = cp5.addDropdownList("Filter List")
          .setPosition(image_size[0]+20, 50);
  customize(d1);
  d2 = cp5.addDropdownList("Greyscale Mode")
          .setPosition(image_size[0] + 20, 320);
          customize2(d2);
}

void createImageFrame(){
  square = createShape(RECT, 1, 1, image_size[0], image_size[1]-2);
  square.setFill(false);
  square.setStroke(color(0, 0, 0));
}

void customize(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(180));
  ddl.setWidth(160);
  ddl.setItemHeight(25);
  ddl.setBarHeight(25);
  ddl.setHeight(150);
  for (int i=0; i < ddarray1.getSize(); i++) {
    ddl.addItem("Filter "+ddarray1.display(i), i);
  }
  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}

void customize2(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(180));
  ddl.setWidth(160);
  ddl.setItemHeight(25);
  ddl.setBarHeight(25);
  ddl.setHeight(50);
  for (int i=0; i < ddarray2.getSize(); i++) {
    ddl.addItem("Grayscale Mode "+ddarray2.display(i), i);
  }
  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}

void createSliders(){
  createRedSlider();
  createGreenSlider();
  createBlueSlider();
  createAlphaSlider();
}

void createRedSlider(){
  cp5.addSlider("Red Slider")
     .setPosition(image_size[0] + 20,400)
     .setSize(100,20)
     .setRange(-255,255)
     .setValue(0)
     .setNumberOfTickMarks(103).setColorForeground(color(255, 0,0)).setColorActive(color(255, 0,0))
     ;
}

void createGreenSlider(){
  cp5.addSlider("Green Slider")
     .setPosition(image_size[0] + 20,450)
     .setSize(100,20)
     .setRange(-255,255)
     .setValue(0)
     .setNumberOfTickMarks(103).setColorForeground(color(0, 255,0)).setColorActive(color(0, 255,0))
     ;
}

void createBlueSlider(){
  cp5.addSlider("Blue Slider")
     .setPosition(image_size[0] + 20,500)
     .setSize(100,20)
     .setRange(-255,255)
     .setValue(0)
     .setNumberOfTickMarks(103).setColorForeground(color(0, 0,255)).setColorActive(color(0, 0,255))
     ;
}

void createAlphaSlider(){
  cp5.addSlider("Alpha Slider")
     .setPosition(image_size[0] + 20,550)
     .setSize(100,20)
     .setRange(-100, 100)
     .setValue(100)
     .setNumberOfTickMarks(21).setColorForeground(color(255, 0,255)).setColorActive(color(255, 0,255))
     ;
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isGroup()) {
    println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
  } 
  else if (theEvent.isController()) {
      if (theEvent.isFrom(cp5.getController("Filter List"))) {
        println("this event was triggered by Controller Fitler");
        println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
        int clicked = int(theEvent.getController().getValue()); 
        Filter filter = ddarray1.fromIndex(clicked);
        println(" Filter: " + filter.asString());
        img_gui.newFilter(filter);
      } else if(theEvent.isFrom(cp5.getController("Red Slider"))){
           setChannelValue(theEvent, Filter.REDCHANNEL);
      }else if(theEvent.isFrom(cp5.getController("Green Slider"))){
          setChannelValue(theEvent, Filter.GREENCHANNEL);
      }else if(theEvent.isFrom(cp5.getController("Blue Slider"))){
          setChannelValue(theEvent, Filter.BLUECHANNEL);
      }else if(theEvent.isFrom(cp5.getController("Alpha Slider"))){
          setChannelValue(theEvent, Filter.ALPHACHANNEL);
      }else if (theEvent.isFrom(cp5.getController("Greyscale Mode"))){
        int clicked = int(theEvent.getController().getValue()); 
        Mode mode = ddarray2.fromIndex(clicked);
        img_gui.changGreyscale(mode);
      }
     
  }
}

void setChannelValue(ControlEvent theEvent, Filter f){
         println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
         int clicked = int(theEvent.getController().getValue());
         //if (f == Filter.ALPHACHANNEL) opacity = int(map(clicked, 0, 100, 0, 255));
         img_gui.changeChannel(f, clicked);
}
