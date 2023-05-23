class Box{
  boolean occupied;
  public Box(){
    occupied = false;
  }
  
  public Box(boolean bol){
    occupied = bol;
  }
  
  boolean isOccupied(){
    return occupied;
  }
  
  void setOccupied(boolean occupy){
    occupied = occupy;
  }
}
