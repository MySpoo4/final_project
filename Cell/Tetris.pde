
void setup(){
  size(500,1000);
  
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
    board = new boolean[20][10];
    
    
  }
  
  public void startGame(){
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
  
}
  
  void draw(){}
  
  void keyPressed(){
}
