int mag_x = 50;
int mag_y = 50;
int Player_Discard = 0;
int Computer_Discard = 0;
int Player_Discard_X = 0;
int Player_Discard_Y_1 = -50;
int Player_Discard_Y_2 = 850;
int Computer_Discard_X = 0;
int Computer_Discard_Y_1 = -50;
int Computer_Discard_Y_2 = 850;
double a_S = 0;
double a_E = 0;
char turn = 'C';
int ST_X = 0;
int ST_Y = 0;
int FL_X = 0;
int FL_Y = 0;
int cap_X = 0;
int cap_Y = 0;
byte start = 29;
byte finish = 69;



void setup() {
  // put your setup code here, to run once:
  Serial.begin(57600);
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(7, INPUT_PULLUP);
  pinMode(8, INPUT_PULLUP);
  pinMode(10, OUTPUT);
  pinMode(11, OUTPUT);
  Reset_stepper();
  Serial.println();
  delay(20);
  Serial.println("Program begin");
}
//=========================================================
void loop() {
  // put your main code here, to run repeatedly:
  Initial_Handling();
}
//=========================================================
void Reset_stepper(){
  digitalWrite(10, LOW);
  delay(10);
  digitalWrite(10, HIGH);
}
//=========================================================
void Initial_Handling(){ //byte start, byte finish){
  if (finish == 69){
    if (turn == 'P'){
      Serial.println("Starting player capture sequence");
      Player_Discard++;
      Det_Dir_Pl_Cap(start, Player_Discard);
    }
    if (turn == 'C'){
      Serial.println("Starting computer capture sequence");
      Computer_Discard++;
      Det_Dir_Com_Cap(start, Computer_Discard);
    }
  }else{
    Serial.println("Starting piece movement sequence");
    Det_Dir(start,finish);
  }
}
//=========================================================
void Det_Dir(byte start_loc, byte end_loc){
  Det_XY_S(start_loc);
  Det_XY_E(end_loc);
  Serial.print("start x position is: ");
  Serial.println(ST_X);
  Serial.print("start y position is: ");
  Serial.println(ST_Y);
  Serial.print("final x position is: ");
  Serial.println(FL_X);
  Serial.print("final y position is: ");
  Serial.println(FL_Y);
  move_mag_DE(ST_X, ST_Y);
  Serial.println("Magnet Engaging");
  //engage_mag();
  move_to_p(FL_X, FL_Y);
  Serial.println("move has been completed");
  Serial.println("=========================================");
  Serial.println();
}
//=========================================================
void Det_Dir_Pl_Cap(byte start_loc_cap, int pl_cnt){
  if (pl_cnt <= 8){
    Player_Discard_X = 1150;
    Player_Discard_Y_1 += 100;
    Serial.print("X discard position: ");
    Serial.println(Player_Discard_X);
    Serial.print("Y discard position: ");
    Serial.println(Player_Discard_Y_1);
    Det_XY(start_loc_cap);
    Serial.print("captured piece x location: ");
    Serial.println(cap_X);
    Serial.print("captured piece y location: ");
    Serial.println(cap_Y);
    move_mag_DE(cap_X, cap_Y);
    Serial.println("Magnet Engaging");
    engage_mag();
    move_to_p(Player_Discard_X, Player_Discard_Y_1);
    Serial.println("move has been completed");
  }
  if (pl_cnt >= 9 and pl_cnt <= 16){
    Player_Discard_X = 1050;
    Player_Discard_Y_2 -= 100;
    Serial.print("X discard position: ");
    Serial.println(Player_Discard_X);
    Serial.print("Y discard position: ");
    Serial.println(Player_Discard_Y_2);
    Det_XY(start_loc_cap);
    Serial.print("captured piece x location: ");
    Serial.println(cap_X);
    Serial.print("captured piece y location: ");
    Serial.println(cap_Y);
    move_mag_DE(cap_X, cap_Y);
    Serial.println("Magnet Engaging");
    engage_mag();
    move_to_p(Player_Discard_X, Player_Discard_Y_2);
    Serial.println("move has been completed");
  }
}
//========================================================
void Det_Dir_Com_Cap(byte start_loc_cap, int com_cnt){
  if (com_cnt <= 8){
    Computer_Discard_X = 50;
    Computer_Discard_Y_1 += 100;
    Serial.print("X discard position: ");
    Serial.println(Computer_Discard_X);
    Serial.print("Y discard position: ");
    Serial.println(Computer_Discard_Y_1);
    Det_XY(start_loc_cap);
    Serial.print("captured piece x location: ");
    Serial.println(cap_X);
    Serial.print("captured piece y location: ");
    Serial.println(cap_Y);
    move_mag_DE(cap_X, cap_Y);
    Serial.println("Magnet Engaging");
    engage_mag();
    move_to_p(Computer_Discard_X, Computer_Discard_Y_1);
    Serial.println("move has been completed");
  }
  if (com_cnt >= 9 and com_cnt <= 16){
    Computer_Discard_X = 150;
    Computer_Discard_Y_2 -= 100;
    Serial.print("X discard position: ");
    Serial.println(Computer_Discard_X);
    Serial.print("Y discard position: ");
    Serial.println(Computer_Discard_Y_2);
    Det_XY(start_loc_cap);
    Serial.print("captured piece x location: ");
    Serial.println(cap_X);
    Serial.print("captured piece y location: ");
    Serial.println(cap_Y);
    move_mag_DE(cap_X, cap_Y);
    Serial.println("Magnet Engaging");
    engage_mag();
    move_to_p(Computer_Discard_X, Computer_Discard_Y_2);
    Serial.println("move has been completed");
  }  
}
//========================================================
void Det_XY(byte st_loc){
    
  a_S = st_loc/8;
  int b = st_loc % 8;
  int i = 0;
  if (a_S < 1){
    cap_Y = 50;
    cap_X = (st_loc * 100) + 250;
  }else if (a_S >= 1 and a_S < 2){
    cap_Y = 150;
    while (b != i ){
      i++;
    }
    cap_X = (i * 100) + 250;
  }else if (a_S >= 2 and a_S < 3){
    cap_Y = 250;
    while (b != i ){
      i++;
    }
    cap_X = (i * 100) + 250;
  }else if (a_S >= 3 and a_S < 4){
    cap_Y = 350;
    while (b != i ){
      i++;
    }
    cap_X = (i * 100) + 250;
  }else if (a_S >= 4 and a_S < 5){
    cap_Y = 450;
    while (b != i ){
      i++;
    }
    cap_X = (i * 100) + 250;
  }else if (a_S >= 5 and a_S < 6){
    cap_Y = 550;
    while (b != i ){
      i++;
    }
    cap_X = (i * 100) + 250;
  }else if (a_S >= 6 and a_S < 7){
    cap_Y = 650;
    while (b != i ){
      i++;
    }
    cap_X = (i * 100) + 250;
  }else if (a_S >= 7){
    cap_Y = 750;
    while (b != i ){
      i++;
    }
    cap_X = (i * 100) + 250;
  }
}
//==========================================================
void Det_XY_S(byte st_loc){
    
  a_S = st_loc/8;
  int b = st_loc % 8;
  int i = 0;
  if (a_S < 1){
    ST_Y = 50;
    ST_X = (st_loc * 100) + 250;
  }else if (a_S >= 1 and a_S < 2){
    ST_Y = 150;
    while (b != i ){
      i++;
    }
    ST_X = (i * 100) + 250;
  }else if (a_S >= 2 and a_S < 3){
    ST_Y = 250;
    while (b != i ){
      i++;
    }
    ST_X = (i * 100) + 250;
  }else if (a_S >= 3 and a_S < 4){
    ST_Y = 350;
    while (b != i ){
      i++;
    }
    ST_X = (i * 100) + 250;
  }else if (a_S >= 4 and a_S < 5){
    ST_Y = 450;
    while (b != i ){
      i++;
    }
    ST_X = (i * 100) + 250;
  }else if (a_S >= 5 and a_S < 6){
    ST_Y = 550;
    while (b != i ){
      i++;
    }
    ST_X = (i * 100) + 250;
  }else if (a_S >= 6 and a_S < 7){
    ST_Y = 650;
    while (b != i ){
      i++;
    }
    ST_X = (i * 100) + 250;
  }else if (a_S >= 7){
    ST_Y = 750;
    while (b != i ){
      i++;
    }
    ST_X = (i * 100) + 250;
  }
}
//==========================================================
void Det_XY_E(byte st_loc){
    
  a_E = st_loc/8;
  int b = st_loc % 8;
  int i = 0;
  if (a_E < 1){
    FL_Y = 50;
    FL_X = (st_loc * 100) + 250;
  }else if (a_E >= 1 and a_E < 2){
    FL_Y = 150;
    while (b != i ){
      i++;
    }
    FL_X = (i * 100) + 250;
  }else if (a_E >= 2 and a_E < 3){
    FL_Y = 250;
    while (b != i ){
      i++;
    }
    FL_X = (i * 100) + 250;
  }else if (a_E >= 3 and a_E < 4){
    FL_Y = 350;
    while (b != i ){
      i++;
    }
    FL_X = (i * 100) + 250;
  }else if (a_E >= 4 and a_E < 5){
    FL_Y = 450;
    while (b != i ){
      i++;
    }
    FL_X = (i * 100) + 250;
  }else if (a_E >= 5 and a_E < 6){
    FL_Y = 550;
    while (b != i ){
      i++;
    }
    FL_X = (i * 100) + 250;
  }else if (a_E >= 6 and a_E < 7){
    FL_Y = 650;
    while (b != i ){
      i++;
    }
    FL_X = (i * 100) + 250;
  }else if (a_E >= 7){
    FL_Y = 750;
    while (b != i ){
      i++;
    }
    FL_X = (i * 100) + 250;
  }
}
//==========================================================
void move_mag_DE(int PX, int PY){
  Serial.print("magnet X position is: ");
  Serial.println(mag_x);
  Serial.print("magnet Y position is: ");
  Serial.println(mag_y);
  int dis_x = PX - mag_x;
  Serial.print("The distance difference in the X is: ");
  Serial.println(dis_x);
  if (dis_x > 0){
    X_CW_Stepper(PX);
  }else if(dis_x < 0){
    X_CCW_Stepper(PX);
  }
  //maybe add handler for if = to 0
  int dis_y = PY - mag_y;
  //Serial.println();
  Serial.print("The distance difference in the Y is: ");
  Serial.println(dis_y);
  if (dis_y > 0){
    Y_CCW_Stepper(PY);
  }else if(dis_y < 0){
    Y_CW_Stepper(PY);
  }
  Serial.println("Magnet has gotten to start location");
}
//==========================================================
void engage_mag(){
  //enter servo movement here
}
//==========================================================
void move_to_p(int pmX, int pmY){
  To_Gridline();
  int dis_px = pmX - mag_x;
  Serial.print("The difference in X from start to finish is: ");
  Serial.println(dis_px);
  Serial.println("Starting movement in X direction");
  if (dis_px > 0){
    X_CW_Stepper_P(pmX);
  }else if(dis_px < 0){
    X_CCW_Stepper_P(pmX);
  }

  int dis_py = pmY - mag_y;
  Serial.print("The distance in Y from start to finish is: ");
  Serial.println(dis_py);
  Serial.println("Starting motor movement in Y direction");
  //fix the return to center here
  if (dis_py > 0){
    Y_CCW_Stepper_P(pmY);
    //From_Gridline_L();
  }else if(dis_py < 0){
    Y_CW_Stepper_P(pmY);
    //From_Gridline_R();
  }
  Serial.println("Moving back to the center of the tile");
  if(mag_x < pmX){
    From_Gridline_R();
  }else if(mag_x > pmX){
    From_Gridline_L();
  }
}
//==========================================================
void X_CW_Stepper_P(int DX){
   /*
  digitalWrite(5, HIGH);
  while (x < 11) {
    digitalWrite(4, HIGH);
    delay(50);
    digitalWrite(4, LOW);
    x++;
    delay(200);
  }
  */
  int DL = DX - 50;
  //Serial.println("The gridline distance is: ");
  //Serial.print(DL);
  Serial.println("X stepper toggle clockwise");
  digitalWrite(5, HIGH);
  while (mag_x != DL){
    digitalWrite(4, HIGH);
    delay(20);
    digitalWrite(4, LOW);
    Serial.println(mag_x);
    mag_x = mag_x + 10;
    //send pulse to christian, write via serial ===> Serial.write("X or Y" 0 or 1) to every motion funtion
    delay(50);
  }
  Serial.println(mag_x);
  Serial.println("arrived at desired X location");
}
//==========================================================
void X_CCW_Stepper_P(int DX){
  /*
  digitalWrite(5, LOW);
  while (x > 0) {
    digitalWrite(4, HIGH);
    delay(50);
    digitalWrite(4, LOW);
    x--;
    delay(200);
  }
  */
  int DL = DX + 50;
  //Serial.println("The gridline distance is: ");
  //Serial.print(DL);
  Serial.println("X stepper toggle counter clockwise");
  digitalWrite(5, LOW);
  while (mag_x != DL ) {
    digitalWrite(4, HIGH);
    delay(20);
    digitalWrite(4, LOW);
    Serial.println(mag_x);
    mag_x = mag_x - 10;
    delay(50);
  }
  Serial.println(mag_x);
  Serial.println("arrived at desired X location");
}
//==============================================
void Y_CW_Stepper_P(int DY){
  /*
  digitalWrite(3, HIGH);
  while (x < 11) {
    digitalWrite(2, HIGH);
    delay(50);
    digitalWrite(2, LOW);
    x++;
    delay(200);
  }
  */
  Serial.println("Y stepper toggle clockwise");
  digitalWrite(3, HIGH);
  while (mag_y != DY) {
    digitalWrite(2, HIGH);
    delay(20);
    digitalWrite(2, LOW);
    Serial.println(mag_y);
    mag_y = mag_y - 10;
    delay(50);
  }
  Serial.println(mag_y);
  Serial.println("arrived at desired Y location");
}
//==============================================
void Y_CCW_Stepper_P(int DY){
  /*
  digitalWrite(3, LOW);
  while (x > 0) {
    digitalWrite(2, HIGH);
    delay(50);
    digitalWrite(2, LOW);
    x--;
    delay(200);
    }
  */
  Serial.println("Y stepper toggle counter clockwise");
  digitalWrite(3, LOW);
  while (mag_y != DY) {
    digitalWrite(2, HIGH);
    delay(20);
    digitalWrite(2, LOW);
    Serial.println(mag_y);
    mag_y = mag_y + 10;
    delay(50);
    }
    Serial.println(mag_y);
    Serial.println("arrived at desired Y location");
}
//==========================================================
void X_CW_Stepper(int DX){
   /*
  digitalWrite(5, HIGH);
  while (x < 11) {
    digitalWrite(4, HIGH);
    delay(50);
    digitalWrite(4, LOW);
    x++;
    delay(200);
  }
  */
  Serial.println("X stepper toggle clockwise");
  digitalWrite(5, HIGH);
  while (mag_x != DX){
    digitalWrite(4, HIGH);
    delay(20);
    digitalWrite(4, LOW);
    Serial.println(mag_x);
    mag_x = mag_x + 10;
    delay(50);
  }
  Serial.println(mag_x);
  Serial.println("arrived at desired X location");
}
//==========================================================
void X_CCW_Stepper(int DX){
  /*
  digitalWrite(5, LOW);
  while (x > 0) {
    digitalWrite(4, HIGH);
    delay(50);
    digitalWrite(4, LOW);
    x--;
    delay(200);
  }
  */
  Serial.println("X stepper toggle counter clockwise");
  digitalWrite(5, LOW);
  while (mag_x != DX ) {
    digitalWrite(4, HIGH);
    delay(20);
    digitalWrite(4, LOW);
    Serial.println(mag_x);
    mag_x = mag_x - 10;
    delay(50);
  }
  Serial.println(mag_x);
  Serial.println("arrived at desired X location");
}
//==============================================
void Y_CW_Stepper(int DY){
  /*
  digitalWrite(3, HIGH);
  while (x < 11) {
    digitalWrite(2, HIGH);
    delay(50);
    digitalWrite(2, LOW);
    x++;
    delay(200);
  }
  */
  Serial.println("Y stepper toggle clockwise");
  digitalWrite(3, HIGH);
  while (mag_y != DY) {
    digitalWrite(2, HIGH);
    delay(20);
    digitalWrite(2, LOW);
    Serial.println(mag_y);
    mag_y = mag_y - 10;
    delay(50);
  }
  Serial.println(mag_y);
  Serial.println("arrived at desired Y location");
}
//==============================================
void Y_CCW_Stepper(int DY){
  /*
  digitalWrite(3, LOW);
  while (x > 0) {
    digitalWrite(2, HIGH);
    delay(50);
    digitalWrite(2, LOW);
    x--;
    delay(200);
    }
  */
  Serial.println("Y stepper toggle counter clockwise");
  digitalWrite(3, LOW);
  while (mag_y != DY) {
    digitalWrite(2, HIGH);
    delay(20);
    digitalWrite(2, LOW);
    Serial.println(mag_y);
    mag_y = mag_y + 10;
    delay(50);
    }
    Serial.println(mag_y);
    Serial.println("arrived at desired Y location");
}
//==============================================
void To_Gridline(){
  int h = 0;
  Serial.println("Moving to gridline");
  if (a_S < 4){
    digitalWrite(3, LOW);
    while (h < 50) {
      digitalWrite(2, HIGH);
      delay(20);
      digitalWrite(2, LOW);
      Serial.println(mag_y);
      h = h + 5;
      mag_y = mag_y + 5;
      delay(50);
    }
    Serial.println(mag_y);
  }else if(a_S > 4){
    digitalWrite(3, HIGH);
    while (h < 50) {
      digitalWrite(2, HIGH);
      delay(20);
      digitalWrite(2, LOW);
      Serial.println(mag_y);
      h = h + 5;
      mag_y = mag_y - 5;
      delay(50);
    }
    Serial.println(mag_y);
  }
}
//==============================================
void From_Gridline_R(){
  int g = 0;
  digitalWrite(5, HIGH);
  while (g < 50){
    digitalWrite(4, HIGH);
    delay(20);
    digitalWrite(4, LOW);
    g = g + 5;
    Serial.println(mag_x);
    mag_x = mag_x + 5;
    delay(50);
  }
  Serial.println(mag_x);
}
//==============================================
void From_Gridline_L(){
  int g = 0;
  digitalWrite(5, LOW);
  while (g < 50) {
    digitalWrite(4, HIGH);
    delay(20);
    digitalWrite(4, LOW);
    g = g + 5;
    Serial.println(mag_x);
    mag_x = mag_x - 5;
    delay(50);
  }
  Serial.println(mag_x);
}
