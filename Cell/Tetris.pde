
void setup(){
  size(400,880);
  
}

class Tetris{
  private int score;
  private int level;
  private int linesCleared;
  private Piece curPiece;
  private boolean gameOver;
  private boolean[][] board;
  public Tetris(){
    score = 0;
    level = 0;
    linesCleared = 0;
    gameOver = false;
    board = new boolean[22][10];
    startGame();
    
  }
  
  public void startGame(){
    curPiece = new Piece();
  }
  
  public boolean isGameOver(){
    return gameOver;
  }
  
  public void checkLines(){
  }
  
  public void updateBoard(){
  }
  
  public void clearLines(int row){
  }
  
  public void increaseScore(int points){
  }
  
  public void increaseLevel(){
  }
  
  boolean checkCollision(){
    return false;
  }
  
}
  
  void draw(){}
  
  void keyPressed(){
}
