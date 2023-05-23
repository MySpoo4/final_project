class Piece{
  char shape;
  boolean[][] pos;
  int x;
  int y;
  public Piece(){
    char[] shapes = new char[]{'I','J','L','O','S','Z','T'};
    shape = shapes[(int) random(shapes.length)];
  }
  // swap bol arrays with an int of 1 and 0s
  void createPiece(char shape){
    if(shape == 'I'){}
    else if(shape == 'L'){
      pos = new boolean[][]{
        {false,false,false,false},
        {false,false,false,false},
        {true,true,true,true},
        {false,false,false,false}
      };
    }
      
      pos = new boolean[][]{
        {false,false,false},
        {true,true,true},
        {true,false,false}
      };
    }
    else if(shape == 'J'){
      pos = new boolean[][]{
        {false,false,false},
        {true,true,true},
        {false,false,true}
      };
    }
    else if(shape == 'T'){
      pos = new boolean[][]{
        {false,false,false},
        {true,true,true},
        {false,true,false}
      };
    }
    else if(shape == 'S'){
      pos = new boolean[][]{
        {false,false,false},
        {false,true,true},
        {true,true,false}
      };
    }
    else if(shape == 'Z'){
      pos = new boolean[][]{
        {false,false,false},
        {true,true,false},
        {false,true,true}
      };
    }
    else{
      pos = new boolean[][]{
        {false,false,false,false},
        {false,true,true,false},
        {false,true,true,false},
        {false,false,false,false}
      };
    }
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
