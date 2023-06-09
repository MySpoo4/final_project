Tetris game;
String path;
/* CLASSIC TETRIS
Controls
A         move left
D         move right
spacebar  hard drop
J         rotate counterclockwise
K         rotate clockwise
l         hold piece
*/



  void setup(){
    path = sketchPath("");
    game = new Tetris(path,started);
    size(700,960);
  }
  boolean started = false;
  boolean a;
  boolean d;
   void draw(){
     game.tick();
    if(frameCount % (15 - game.speed) == 0){
      game.tick();
    }
    if(frameCount % 5 == 0){
      if(a){
        game.curPiece.moveLeft();
        
        if(game.checkCollision()){
          game.curPiece.moveRight();
        }
      }
      else if(d){
        game.curPiece.moveRight();
        if(game.checkCollision()){
          game.curPiece.moveLeft();
        }
      }
    }
  }
  
void keyPressed() {
  
  int prevOrientation = game.curPiece.orientation;
  int x = game.curPiece.getX();
  int y = game.curPiece.getY();
    
  if(key == 'a'){
    a = true;
  }
  else if(key == 'd'){
    d = true;
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
  else if(key == 'l'){
    game.holdPiece();
  }
  else if(keyCode == ENTER){
    if(!started){
      game.unpause();
      started = true;
    }
    game = new Tetris(path,started);
  }
}

void keyReleased(){
  if(key == 'a'){
    a = false;
  }
  else if(key == 'd'){
    d = false;
  }
}
