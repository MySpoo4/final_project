class Piece{
  String shape;
  Cell[][] pos;
  int x;
  int y;
  public Piece(){
    char[] shapes = new char[]{'I','J','L','O','S','Z','T'};
    shape = shapes[random(shapes.length)];
  }
  
  void createPiece(String shape){
    
  }
  
  int getX(){
    return x;
  }
  
  int getY(){
    return y;
  }
  
  void drop(){}
  
  void moveDown(){}
  
  void moveLeft(){}
  
  void moveRight(){}
  
  void rotateLeft(){}
  
  void rotateRight(){}
}
