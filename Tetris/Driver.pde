Tetris game = new Tetris();

/* CLASSIC TETRIS
Controls
A         move left
D         move right
spacebar  hard drop
J         rotate counterclockwise
K         rotate clockwise

*/



  void setup(){
    size(700,960);
  }
  
   void draw(){
    if(frameCount % (11 - game.speed) == 0){
      game.tick();
    }
  }
  
void keyPressed() {
  
  int prevOrientation = game.curPiece.orientation;
  int x = game.curPiece.getX();
  int y = game.curPiece.getY();
    
  if(key == 'a'){
    game.curPiece.moveLeft();
    
    if(game.checkCollision()){
      game.curPiece.moveRight();
    }
  }
  else if(key == 'd'){
    game.curPiece.moveRight();
    if(game.checkCollision()){
      game.curPiece.moveLeft();
    }
  }
  else if(key == 'j'){
    game.curPiece.rotateLeft();
    if(game.checkCollision()){
      game.curPiece.orientation = prevOrientation;
      game.curPiece.setX(x);
      game.curPiece.setY(y);
    }

  }
  else if(key == 'k'){
    game.curPiece.rotateRight();
    if(game.checkCollision()){
      game.curPiece.orientation = prevOrientation;
      game.curPiece.setX(x);
      game.curPiece.setY(y);
    }
  }
  else if(key == ' '){
    game.hardDrop();
  }
  else if(keyCode == ENTER){
    game = new Tetris();
  }
}
