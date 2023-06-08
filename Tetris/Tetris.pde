import java.util.Arrays;
import java.io.File;
import java.io.IOException;
import java.util.Scanner;
import java.io.FileWriter; 

  
class Tetris{
  boolean pause;
  String name;
  String path;
  int speed;
  int score;
  int linesCleared;
  int lastCollisionTime;
  boolean held;
  ArrayList<Character> bag;
  Piece curPiece;
  Piece nextPiece;
  Piece hPiece;
  ArrayList<boolean[]> board;
  ArrayList<int[]> colors;
  boolean firstTouch;
  int highScore;
  final ArrayList<Character> shapes = new ArrayList<Character>(Arrays.asList('I','J','L','O','S','Z','T'));
  
  
  public Tetris(String path, boolean started){
    this.path = path;
    score = 0;
    linesCleared = 0;
    board = new ArrayList<boolean[]>();
    colors = new ArrayList<int[]>();
    highScore = 0;
    for(int i = 0;i < 24;i++){
      board.add(i,new boolean[14]);
      colors.add(i,new int[14]);
    }
    for(int i = 0;i<2;i++){
      boolean[] temp = new boolean[14];
      for(int j = 0;j<14;j++){
        temp[j] = true;
      }
      board.add(temp);
    }
    speed = 1;
    firstTouch = false;
    startGame();
    if(!started){
      startScreen();
      pause = true;
    }
    else{
      pause = false;
    }
  }
  
  void unpause(){
    pause = false;
  }
  
  void startGame(){
    try{
      File file = new File(path + "/highScores.txt");
      Scanner scanner = new Scanner(file);
      highScore = Integer.parseInt(scanner.nextLine().trim());
      scanner.close();
    }
    catch(Exception e){
      System.out.println(e);
    }
    newBag();
    curPiece = new Piece(bag.remove((int)(Math.random() * bag.size())));
    nextPiece = new Piece(bag.remove((int)(Math.random() * bag.size())));
  }
  
  void updateBoard(){
    int prevOrientation = game.curPiece.orientation;
    int x = game.curPiece.getX();
    int y = game.curPiece.getY();
    curPiece.moveDown();
    if(checkCollision()){
      if(!firstTouch){
        lastCollisionTime = millis();
        firstTouch = true;
      }
      game.curPiece.orientation = prevOrientation;
      game.curPiece.setX(x);
      game.curPiece.setY(y);
      if(millis() - lastCollisionTime >= 1500){
        placePiece();
        ArrayList<Integer> lines = checkLines();
        clearLines(lines);
        if(lines.size() > 0){
          increaseScore(lines.size());
        }
        newPiece();
      }
    }
  }
  
  void newBag(){
    bag = new ArrayList<Character>(shapes);
  }
  
  void newPiece(){
    if(bag.size() == 0){
      newBag();
    }
    curPiece = nextPiece;
    nextPiece = new Piece(bag.remove((int)(Math.random() * bag.size())));
  }
  
  void holdPiece(){
    if(hPiece == null){
      hPiece = new Piece(curPiece.getShape());
      newPiece();
      held = true;
    }
    else{
      if(!held){
        Piece piece = new Piece(curPiece.getShape());
        curPiece = new Piece(hPiece.getShape());
        hPiece = piece;
        held = true;
      }
    }
  }
  
  void hardDrop(){
    while(!checkCollision()){
      curPiece.moveDown();
    }
    curPiece.setY(curPiece.getY()-1);
    placePiece();
    ArrayList<Integer> lines = checkLines();
    clearLines(lines);
    if(lines.size() > 0){
      increaseScore(lines.size());
    }
    newPiece();
  }
  
  int getHeight(){
    for(int i = 2;i < board.size()-2;i++){
      for(int j = 2;j < board.get(0).length-2;j++){
        if(board.get(i)[j]){
          return (24 - i);
        }
      }
    }
    return 0;
  }
  
  void drawBoard(){
     stroke(0);
    strokeWeight(2);
    fill(200,200,200);
      rect(400,0,400,960);
    fill(255,255- 96*(float)getHeight()/20,159);
      rect(0,0,400,960);
      rect(470,250,160,160);
      rect(470,500,160,160);
      strokeWeight(1);
    stroke(#FF0000);
      strokeWeight(8);
      line(5, 160, 395, 160);
      strokeWeight(1);
    stroke(0);
    fill(0);
    text("Hold",500,230);
    text("Next Piece",445,480);
    for(int i = 0;i < curPiece.getSize(); i++){
      for(int j = 0;j < curPiece.getSize(); j++){
        if(curPiece.getCell(i,j)){
          fill(curPiece.getColor());
          square((curPiece.getX() + j)*40+2,(curPiece.getY() + i)*40-2,36);
          fill(0);
        }
      }
    }
    
    for(int i = 0;i < board.size()-2;i++){
      for(int j = 2;j < board.get(0).length-2;j++){
        if(board.get(i)[j]){
          fill(colors.get(i)[j]);
          square((j-2) * 40+2,i * 40-2,36);
        }
      }
    }
     for(int i = 0;i < nextPiece.getSize(); i++){
      for(int j = 0;j < nextPiece.getSize(); j++){
        if(nextPiece.getCell(i,j)){
          int offset = 20;
          if(nextPiece.shape == 'O' || nextPiece.shape == 'I'){
            offset = 0;
          }
          fill(nextPiece.getColor());
          square(offset + 470 + j*40+2,500+i*40-2,36);
          fill(0);
        }
      }
    }
    if(hPiece != null){
      for(int i = 0;i < hPiece.getSize(); i++){
        for(int j = 0;j < hPiece.getSize(); j++){
          if(hPiece.getCell(i,j)){
            int offset = 20;
            if(hPiece.shape == 'O' || hPiece.shape == 'I'){
              offset = 0;
            }
            fill(hPiece.getColor());
            square(offset + 470 + j*40+2,250+i*40-2,36);
            fill(0);
          }
        }
    }
    }
  }
  
  
  boolean isGameOver(){
    if(score > highScore){
      highScore = score;
      try{
       FileWriter myWriter = new FileWriter(path + "/highScores.txt");
       myWriter.write(score + "");
       myWriter.close();
      }
      catch(Exception e){
        System.out.println(e);
      }
    }
    if(getHeight() >= 20){
      return true;
    }
    return false;
  }
  /* CLASSIC TETRIS
Controls
A         move left
D         move right
spacebar  hard drop
J         rotate counterclockwise
K         rotate clockwise
l         hold piece
*/
  void startScreen(){
    textSize(104); 
    fill(#000000);
    text("Tetris",230,190);
    textSize(30); 
    text("Controls",230,240);
    text("A         move left",230,280);
    text("D         move right",230,320);
    text("spacebar  hard drop",230,360);
    text("J         rotate counterclockwise",230,400);
    text("K         rotate clockwise",230,440);
    text("L         hold piece",230,480);
    textSize(50); 
    text("Press Enter to play", 150, 550);
  }
  
  void gameOverScreen(){
    pause = true;
    fill(#A9A9A9);
    rect(0,0,700,960);
    strokeWeight(10);
    fill(0);
    text("Game Over!",230,200);
    text("Score: " + score,270,270);
    text("Total Lines: " + linesCleared,220,340);
    text("Press Enter to play again!", 95, 410);
    text("Highest Score: ",200,500);
    text(highScore,200,570);
    fill(0);
  }
 
  
  ArrayList<Integer> checkLines(){
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
      colors.remove(line);
      colors.add(0,new int[14]);
    }
  }
  
  
  void placePiece(){
    firstTouch = false;
    for(int i = 0;i < curPiece.getSize(); i++){
      for(int j = 0;j < curPiece.getSize(); j++){
        if(curPiece.getCell(i,j)){
          board.get(i + curPiece.getY())[j + curPiece.getX()+2] = true;
          colors.get(i + curPiece.getY())[j + curPiece.getX()+2] = curPiece.getColor();
        }
      }
    }
  }
  
  
  boolean checkCollision(){
    for(int i = 0;i < curPiece.getSize(); i++){
      for(int j = 0;j < curPiece.getSize(); j++){
        if(board.get(curPiece.getY()+i)[curPiece.getX()+j+2] && curPiece.getCell(i,j)){
          held = false;
          return true;
        }
      }
    }
    return false;
  }
  
  
  void increaseScore(int lines){
     if(lines == 1){
       score += 40 * game.speed;
     }
     else if(lines == 2){
       score += 100 * game.speed;
     }
     else if(lines == 3){
       score += 300 * game.speed;
     }
     else{
       score += 1200 * game.speed;
     }
     if(speed < 9){
        speed = 1 + linesCleared / 5;
     }
  }
  
  void showScore(){
    textSize(50);
    fill(0);
    text("Score",494,60);
    text(score, 430, 120); 
    
  }
  
  
  void tick(){
    if(!pause){
        fill(255,255,255);
      updateBoard();
      drawBoard();
      showScore();
      if(isGameOver()){
        gameOverScreen();
    }
    else{
    }
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
