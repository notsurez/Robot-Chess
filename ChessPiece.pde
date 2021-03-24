/*
  Class for the chess piece object. The object will contain all the information used to display each chess piece
  determine legal moves, and allow the user to select pieces
  
  Written by: Christian Brazeau
  Other Contributers: 
    Timothy Reichert (legal move logic)
  Last modified: 03/12/2021
*/

import java.lang.Object;
import java.util.BitSet;

  boolean bqsc = true;
  boolean bksc = true;
  
  boolean wqsc = true;
  boolean wksc = true;
  
class ChessPiece {
  
  PImage wp, wr, wn, wb, wq, wk, bp, br, bn, bb, bq, bk; //Initialize individual PImages for each piece
  float x, y, size;
  int bbIndex; //Variable to store the bit board index of each piece (0-63)
  char pieceType; 
  Boolean selected = false;
  boolean firstMove = false;
  

  
  
    void DefaultBoard(){
    int z = 0;
    BitBoard[0] = 'r';
    BitBoard[1] = 'n';
    BitBoard[2] = 'b';
    BitBoard[3] = 'q';
    BitBoard[4] = 'k';
    BitBoard[5] = 'b';
    BitBoard[6] = 'n';
    BitBoard[7] = 'r';
    for(z = 8; z < 16; z++){
      BitBoard[z] = 'p';
    }
    for(z = 16; z < 48; z++){
      BitBoard[z] = ' ';
    }
    for(z = 48; z < 56; z++){
      BitBoard[z] = 'P';
    }
    BitBoard[56] = 'R';
    BitBoard[57] = 'N';
    BitBoard[58] = 'B';
    BitBoard[59] = 'Q';
    BitBoard[60] = 'K';
    BitBoard[61] = 'B';
    BitBoard[62] = 'N';
    BitBoard[63] = 'R';
  }
  
  
  ChessPiece(char pt, float xpos, float ypos,float s, int bitBI){
    imageMode(CENTER);
    wp = loadImage("wp.png");
    wr = loadImage("wr.png");
    wn = loadImage("wn.png");
    wb = loadImage("wb.png");
    wk = loadImage("wk.png");
    wq = loadImage("wq.png");
    bp = loadImage("bp.png");
    br = loadImage("br.png");
    bn = loadImage("bn.png");
    bb = loadImage("bb.png");
    bq = loadImage("bq.png");
    bk = loadImage("bk.png");
    
    wp.resize(pieceSize, pieceSize);
    wr.resize(pieceSize, pieceSize);
    wn.resize(pieceSize, pieceSize);
    wb.resize(pieceSize, pieceSize);
    wk.resize(pieceSize, pieceSize);
    wq.resize(pieceSize, pieceSize);
    bp.resize(pieceSize, pieceSize);
    br.resize(pieceSize, pieceSize);
    bn.resize(pieceSize, pieceSize);
    bb.resize(pieceSize, pieceSize);
    bq.resize(pieceSize, pieceSize);
    bk.resize(pieceSize, pieceSize);
    
    x = xpos;
    y = ypos;
    size = s;
    pieceType = pt;
    bbIndex = bitBI;
  }
  
  void move() {
    //x++;
  }
  
  void display() {
    switch(pieceType){
      case 'p':
        image(bp, x,y);
      break;
      
      case 'r': //Black Rook
        image(br, x,y);
      break;
            
      case 'n': //Black Knight
        image(bn, x,y);
      break;      
      
      case 'b': //Black Bishop
        image(bb, x,y);
      break;
      
      case 'q': //Black Queen
        image(bq, x,y);
      break;
      
      case 'k': //Black King
        image(bk, x,y);
      break;
      
      case 'P': // White Pawn
        image(wp, x,y);
      break;
           
      case 'R': //White Rook
       image(wr, x,y);
      break;     
      
      case 'N': //White Knight
        image(wn, x,y);
      break;      
      
      case 'B': //White Bishop
        image(wb, x,y);
      break;
      
      case 'Q': //White Queen
        image(wq, x,y);
      break;
      
      case 'K': //White King
        image(wk, x,y);
      break;
    }
    
    if(selected) {
     x = mouseX;
     y = mouseY;
    }
  }
  
  void updateBB() {
    BitBoard[bbIndex] = ' ';
    bbIndex = (int) floor(x/(int)gridSize)+floor(y/(int)gridSize)*8;
    BitBoard[bbIndex] = (byte)pieceType;
  }
  
  void highlightLegal() {
    if(selected){
      println(pieceType, " on ",bbIndex);
      for(int i = 0; i < 64; i++) {
        if(isLegal(bbIndex,i)){
          fill(40, 40, 80);
          println(bbIndex, " => ", i);
          ellipse(gridSize/2 + (i%8)*(gridSize),gridSize/2 + (floor(i/8))*(gridSize),gridSize/4,gridSize/4);
        }
      }
    }
  }
  
  //Tim, put your logic in here
  boolean isLegal(int From, int To){
    boolean IsitLegal = false;
    byte PlayersPiece = BitBoard[From];
    switch(PlayersPiece){
      case 'p':
      if(From >= 8 && From < 16){ //Condition for testing if the pawn is on the 2nd rank and can move two squares
        if(To-From == 16 || To-From == 8){
          IsitLegal = true;
        }
      }
                
      if(To-From == 8){ //Condition for testing if the pawn is moving one square
        IsitLegal = true;
            }
          
      if(BitBoard[To] == 'r' ||BitBoard[To] =='n'||BitBoard[To] == 'b'||BitBoard[To] =='q'||BitBoard[To] =='k'||BitBoard[To] == 'p'){ // Condition to test if the pawn is trying to move to a square occupied by a friendly piece
        return false;
      }
      if((To-From == 7||To-From == 9) && (BitBoard[To] == 'P'||BitBoard[To] =='Q'||BitBoard[To] =='B'||BitBoard[To] == 'N'||BitBoard[To] == 'R')){ // Condition to test if the pawn is making a capture
        IsitLegal = true;
      }

      if(To > 63|| To < 0){ //returns false if move is off the board
        return false;
        }
      
      break;
      
      case 'r': //Black Rook
        
      break;
            
      case 'n': //Black Knight
       if(To-From == 17 ||To-From == 15 ||To-From == 10 ||To-From == 6 ||To-From == -6 ||To-From ==-10 ||To-From == -15||To-From == -17){ //Tests to make sure a knight is moved to a square that is available to it 
         IsitLegal = true;
       }
       else{ // returns false if the knight is not moved to a legal square 
         return false;
       }
       if(BitBoard[To] == 'r' ||BitBoard[To] =='n'||BitBoard[To] == 'b'||BitBoard[To] =='q'||BitBoard[To] =='k'||BitBoard[To] == 'p'){ // Condition to test if the knight is trying to move to a square occupied by a friendly piece
        return false;
      }
      if(BitBoard[To] == 'P'||BitBoard[To] =='Q'||BitBoard[To] =='B'||BitBoard[To] == 'N'||BitBoard[To] == 'R'){ //Condition to allow a knight to capture if it is trying to move to a square
        IsitLegal = true;
      }
      if(To > 63 ||To < 0){ //Returns false if the knight is moved off the board
        return false;
      }
       
       
      break;      
      
      case 'b': //Black Bishop
      
       
      break;
      
      case 'q': //Black Queen
       
      break;
      
      case 'k': //Black King
      if(To-From == 9||To-From == 8||To-From == 7||To-From == 1||To-From == -1||To-From == -7||To-From == -8||To-From == -9){
        IsitLegal = true;
      }
      else{
        return false;
      }
   
        if(BitBoard[To] == 'r' ||BitBoard[To] =='n'||BitBoard[To] == 'b'||BitBoard[To] =='q'||BitBoard[To] == 'p'||BitBoard[To] == 'k'){  // Condition to test if the king is trying to move to a square occupied by a friendly piece
         return false;
      }
      if(BitBoard[To] == 'P'||BitBoard[To] =='Q'||BitBoard[To] =='B'||BitBoard[To] == 'N'||BitBoard[To] == 'R'){ //Condition to allow the king to capture an enemy piece
     IsitLegal = true;
      }
      if(To > 63 ||To < 0){ //Returns false if the king is moved off the board
        return false;
      }
      
       
       
      break;
      
      case 'P': // White Pawn
        if(From >= 48 && From < 56){//Condition for testing if the pawn is on the 2nd rank and can move two squares
          if(To-From == -16 || To-From == -8){
          IsitLegal = true;
          }
        }
                
      if(To-From == -8){ //Condition for testing if the pawn is moving one square
        IsitLegal = true;
            }

      if(BitBoard[To] == 'R' ||BitBoard[To] =='N'||BitBoard[To] == 'B'||BitBoard[To] =='Q'||BitBoard[To] =='K'||BitBoard[To] == 'P'){ // Condition to test if the pawn is trying to move to a square occupied by a friendly piece
        return false;
      }
      if((To-From == -7||To-From == -9) && (BitBoard[To] == 'p'||BitBoard[To] =='q'||BitBoard[To] =='b'||BitBoard[To] == 'n'||BitBoard[To] == 'r')){ // Condition to test if the pawn is making a capture
        IsitLegal = true;
      }

      if(To < 0|| To > 63){ //returns false if move is off the board
        return false;
      }

      break;
           
      case 'R': //White Rook
       
      break;     
      
      case 'N': //White Knight
             if(To-From == 17 ||To-From == 15 ||To-From == 10 ||To-From == 6 ||To-From == -6 ||To-From ==-10 ||To-From == -15||To-From == -17){ //Tests to make sure a knight is moved to a square that is available to it 
         IsitLegal = true;
       }
       else{ // returns false if the knight is not moved to a legal square 
         return false;
       }
       if(BitBoard[To] == 'r' ||BitBoard[To] =='n'||BitBoard[To] == 'b'||BitBoard[To] =='q'||BitBoard[To] == 'p'){ //Condition to allow a knight to capture if it is trying to move to a square
         IsitLegal = true;
      }
      if(BitBoard[To] == 'P'||BitBoard[To] =='Q'||BitBoard[To] =='B'||BitBoard[To] == 'N'||BitBoard[To] == 'R'||BitBoard[To] == 'K'){ // Condition to test if the knight is trying to move to a square occupied by a friendly piece
       return false;
      }
      if(To > 63 ||To < 0){ //Returns false if the knight is moved off the board
        return false;
      }
        
      break;      
      
      case 'B': //White Bishop// 
       
      break;
      
      case 'Q': //White Queen
        
      break;
      
      case 'K': //White King
         if(To-From == 9||To-From == 8||To-From == 7||To-From == 1||To-From == -1||To-From == -7||To-From == -8||To-From == -9){
        IsitLegal = true;
      }
      else{
        return false;
      }
        if(BitBoard[To] == 'r' ||BitBoard[To] =='n'||BitBoard[To] == 'b'||BitBoard[To] =='q'||BitBoard[To] == 'p'){ //Condition to allow a king to capture if it is trying to move to a square
         IsitLegal = true;
      }
      if(BitBoard[To] == 'P'||BitBoard[To] =='Q'||BitBoard[To] =='B'||BitBoard[To] == 'N'||BitBoard[To] == 'R'||BitBoard[To]== 'K'){ // Condition to test if the king is trying to move to a square occupied by a friendly piece
       return false;
      }
      if(To > 63 ||To < 0){ //Returns false if the king is moved off the board
        return false;
      }
      
      
        
      break;
      
      }
    
    return IsitLegal;
  }
  

  
  boolean MouseIsOver() {
    if (mouseX > x-(size/2) && mouseX < x+(size/2) && mouseY > y-(size/2) && mouseY < y+(size/2)) {
        //println(pieceType, bbIndex);
      return true;
    }
    return false;
  }
}
