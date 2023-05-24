class Piece{
  int orientation; //the current orientation based on the allPos array
  char shape;
  String[] allPos; //All the possible orientations of each piece
                   // all the orientations are stored as strings to save memory
  int x; //top left corner of the grid
  int y;
  public Piece(){
    char[] shapes = new char[]{'I','J','L','O','S','Z','T'};
    orientation = 0;
    x = 3;
    y = 0;
    shape = shapes[(int) random(shapes.length)];
    createPiece();
  }
  // swapped bol arrays with a string of 1 and 0s
  void createPiece(){
    if(shape == 'I'){
      allPos = new String[]{
        "0000000011110000",
        "0100010001000100",
        "0000111100000000",
        "0010001000100010"
      };
     }
     else if(shape == 'O'){
       allPos = new String[]{
         "0000011001100000",
         "0000011001100000",
         "0000011001100000",
         "0000011001100000"
       };
     }
     else if(shape == 'L'){
       allPos = new String[]{
         "000111100",
         "110010010",
         "001111000",
         "010010011"
       };
     }
     else if(shape == 'J'){
       allPos = new String[]{
         "000111001",
         "010010110",
         "100111000",
         "011010010"
       };
     }
     else if(shape == 'S'){
       allPos = new String[]{
         "000011110",
         "100110010",
         "011110000",
         "010011001"
       };
     }
     else if(shape == 'Z'){
       allPos = new String[]{
         "000110011",
         "010110100",
         "110011000",
         "001011010"
       };
     }
     else{
       allPos = new String[]{
         "000111010",
         "010110010",
         "010111000",
         "010011010"
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
  
  void moveDown(){
    y++;
  }
  
  void moveLeft(){
    x--;
  }
  
  void moveRight(){
    x++;
  }
  
  void rotateRight(){
    ++orientation;
    if(orientation >= allPos.length){
      orientation = 0;
    }
  }
  
  void rotateLeft(){
    --orientation;
    if(orientation < 0){
      orientation = allPos.length - 1;
    }
  }
  
  String getOrientation(){
    return allPos[orientation];
  }
}
