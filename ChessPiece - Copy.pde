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
  byte BitBoard[] = new byte[64]; 
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
  
  //Tim, put your logic in here
  boolean isLegal(byte From, byte To){
    DefaultBoard();
    boolean IsitLegal = false;
    byte PlayersPiece = BitBoard[From];
    switch(PlayersPiece){
      case 'p':
      if(From >= 8 && From < 16){
        if(To-From == 16 || To-From == 8){
          IsitLegal = true;
        }
                
      else{
        return false;
            }
          }

      if(To == 'r' ||To =='n'||To == 'b'||To =='q'||To =='k'||To == 'p'){
        return false;
      }
      if((To-From == 7||To-From == 9) && (To == 'P'||To =='Q'||To =='B'||To == 'N'||To == 'R')){
        IsitLegal = true;
      }
      if(To > 63){
        return false;
      }
      break;
      
      case 'r': //Black Rook
        
      break;
            
      case 'n': //Black Knight
       
      break;      
      
      case 'b': //Black Bishop
       
      break;
      
      case 'q': //Black Queen
       
      break;
      
      case 'k': //Black King
       
      break;
      
      case 'P': // White Pawn
        if(From >= 48 && From < 56){
          if(To-From == -16 || To-From == -8){
          IsitLegal = true;
        }
                
          else{
            return false;
            }
          }

      if(To == 'R' ||To =='N'||To == 'B'||To =='Q'||To =='K'||To == 'P'){
        return false;
      }
      if((To-From == -7||To-From == -9) && (To == 'p'||To =='q'||To =='b'||To == 'n'||To == 'r')){
        IsitLegal = true;
      }
      if(To < 0){
        return false;
      }
      break;
           
      case 'R': //White Rook
       
      break;     
      
      case 'N': //White Knight
        
      break;      
      
      case 'B': //White Bishop
       
      break;
      
      case 'Q': //White Queen
        
      break;
      
      case 'K': //White King
        
      break;
      
    }
    
    return IsitLegal;
  }
  

  
  boolean MouseIsOver() {
    if (mouseX > x-(size/2) && mouseX < x+(size/2) && mouseY > y-(size/2) && mouseY < y+(size/2)) {
        println(pieceType, bbIndex);
      return true;
    }
    return false;
  }
}
