void createDropdownList(){
  ddarray1 = new DropDownArray();
  // cp5 is the gui
  d1 = cp5.addDropdownList("Filter List")
          .setPosition(620, 50);
  customize(d1);
}

void createImageFrame(){
  square = createShape(RECT, 1, 1, 600, 598);
  square.setFill(false);
  square.setStroke(color(0, 0,0));
}

void customize(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(180));
  ddl.setWidth(160);
  ddl.setItemHeight(25);
  ddl.setBarHeight(25);
  for (int i=0; i < ddarray1.getSize(); i++) {
    ddl.addItem("Filter "+ddarray1.display(i), i);
  }
  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isGroup()) {
    println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
  } 
  else if (theEvent.isController()) {
    println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
    int clicked = int(theEvent.getController().getValue()); 
    Filter filter = ddarray1.fromIndex(clicked);
    println(" Filter: " + filter.asString());
    img_gui.newFilter(filter);
    
  }
}
