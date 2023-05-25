import java.util.ArrayList;
Tetris game = new Tetris();

boolean stop = true;
// fix I piece collision
// rotating right when the block is about the be placed


  void setup(){
    size(800,880);
    game.startGame();
  }
  
class Tetris{
  int speed;
  int score;
  int level;
  int linesCleared;
  int lastCollisionTime;
  Piece curPiece;
  Piece nextPiece;
  ArrayList<boolean[]> board;
  
  
  public Tetris(){
    score = 0;
    level = 0;
    linesCleared = 0;
    board = new ArrayList<boolean[]>();
    for(int i = 0;i < 22;i++){
      board.add(i,new boolean[14]);
    }
    for(int i = 0;i<2;i++){
      boolean[] temp = new boolean[14];
      for(int j = 0;j<14;j++){
        temp[j] = true;
      }
      board.add(temp);
    }
    speed = 10;
    startGame();
  }
  
  public void startGame(){
    curPiece = new Piece();
    nextPiece = new Piece();
    lastCollisionTime = millis();
  }
  public void updateBoard(){
    System.out.println(stop);
    boolean stop = true;
    if(checkCollision(1)){
      if(millis() - lastCollisionTime >= 5000){
        placePiece();
        ArrayList<Integer> lines = checkLines();
        clearLines(lines);
        increaseScore(lines.size());
        curPiece = nextPiece;
        nextPiece = new Piece();
        lastCollisionTime = millis();
        stop = true;
      }
      else{
        stop = false;
      }
    }
    else{
      curPiece.moveDown();
    }
  }
  
  void drawBoard(){
    fill(255,255,255);
    for(int i = 0;i < curPiece.getSize(); i++){
      for(int j = 0;j < curPiece.getSize(); j++){
        if(curPiece.getCell(i,j)){
          square((curPiece.getX() + j)*40+2,(curPiece.getY() + i)*40-2,36);
        }
      }
    }
    for(int i = 0;i < board.size()-2;i++){
      for(int j = 2;j < board.get(0).length-2;j++){
        if(board.get(i)[j]){
          square((j-2) * 40+2,i * 40-2,36);
        }
      }
    }
  }
  
  
  public boolean isGameOver(){
    boolean gameState = false;
    for(int i = 2;i < 12;i++){
      gameState = gameState || board.get(2)[i];
    }
    return gameState;
  }
  
  public ArrayList<Integer> checkLines(){
    ArrayList<Integer> lines = new ArrayList<Integer>();
    for(int i = 1; i < board.size() - 2;i++){
      boolean temp = true;
      for(int j = 2; j < board.get(0).length-2;j++){
        temp = temp && board.get(i)[j];

      }
      if(temp){
        lines.add(i);
      }
    }
    return lines;
  }
  
  void clearLines(ArrayList<Integer> lines){
    for(int line: lines){
      board.remove(line);
      board.add(0,new boolean[14]);
      linesCleared++;
    }
  }
  
  
  void placePiece(){
    for(int i = 0;i < curPiece.getSize(); i++){
      for(int j = 0;j < curPiece.getSize(); j++){
        if(curPiece.getCell(i,j)){
          board.get(i + curPiece.getY())[j + curPiece.getX()+2] = true;
        }
      }
    }
  }
  
  boolean checkCollision(int a){
    for(int i = 0;i < curPiece.getSize(); i++){
      for(int j = 0;j < curPiece.getSize(); j++){
        if(board.get(curPiece.getY()+i+a)[curPiece.getX()+j+2] && curPiece.getCell(i,j)){
          return true;
        }
      }
    }
    return false;
  }
  
  
   public void increaseScore(int lines){
     score += lines * 100;
     speed = 10 - (linesCleared / 5);
  }
  
  void showScore(){
    textSize(100);
    text(score, 450, 100); 
  }
  
  public void increaseLevel(){
  }
  
  void tick(){
    System.out.println(stop);
    updateBoard();
    drawBoard();
    showScore();
    if(isGameOver()){
      game = new Tetris();
    }
  }
  
  
  // used for testing
  void board(){
    for(boolean[] row: board){
      for(boolean bol: row){
        System.out.print(bol + " ");
      }
      System.out.println();
    }
    System.out.println();
    System.out.println();
    System.out.println();
  }
  
}
 void draw(){
    if(frameCount % game.speed == 0){
      fill(150,150,150);
      rect(0,0,400,880);
      fill(200,200,200);
      rect(400,0,400,880);
      game.tick();
    }
  }
  
void keyPressed() {
  
  int prevOrientation = game.curPiece.orientation;
  int x = game.curPiece.getX();
  int y = game.curPiece.getY();
    
  if(key == 'a'){
    game.curPiece.moveLeft();
    
    if(game.checkCollision(1)){
      System.out.println(game.checkCollision(1));
      game.curPiece.moveRight();
    }
  }
  else if(key == 'd'){
    game.curPiece.moveRight();
    if(game.checkCollision(1) && stop){
      game.curPiece.moveLeft();
    }
  }
  else if(key == 'j'){
    game.curPiece.rotateLeft();
    System.out.println(game.curPiece.orientation);
    if(game.checkCollision(1)){
      game.curPiece.orientation = prevOrientation;
      game.curPiece.setX(x);
      game.curPiece.setY(y);
    }

  }
  else if(key == 'k'){
    game.curPiece.rotateRight();
    if(game.checkCollision(1)){
      game.curPiece.orientation = prevOrientation;
      game.curPiece.setX(x);
      game.curPiece.setY(y);
    }
  }
}
