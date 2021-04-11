import java.lang.ProcessBuilder;
import java.io.*;

/*
  Class to handle the communication between the GUI and any
  chess engine using UCI (universal chess engine)
  
  Functions
  -Init
      *
  - Listen
      * WIP
  -Say
      * Sends a string to the engine using process builder io streams
  
  Written by: Christian Brazeau, Timothy Reichert, and Peter Taranto
  Last modified: 03/12/2021
*/



class Engine {
  ProcessBuilder pb;
  Process p = null;
 
  InputStream in    = null; 
  OutputStream out  = null;
  BufferedReader reader;
  
  Engine(String path) {
    
    pb = new ProcessBuilder(path);
  
    
  }
  
  void init() {
    try {
      p = pb.start();
      println("engine was sucessfully initialized");
    }catch(Exception e) {
        println("An error has occured while attempting to start the engine");
    }
    
    in = p.getInputStream();
    out = p.getOutputStream();
    if(in == null || out == null) {
        println("error in creating input/output streams");
    }else {
       println("sucessfully initialized output/input streams"); 
    }
    
    
  }
  
  /*
    Say function sends a message to the output stream of the process builder process 
    running the UCI chess engine. It first converts a given string to
  */
  void say(String message) {
    println("saying:", message);
    out = p.getOutputStream();
    try {
      byte buf[] = message.getBytes();
      out.write(buf);
      out.write(10);
    }catch(Exception e) {
      println("failed to write");
    }
    
    try {
      out.flush();
    }catch(Exception e) {
      println("failed to flush");
    }
    
  }
  
  String listen() {
    reader = new BufferedReader(new InputStreamReader(p.getInputStream()));
    int i;
    String returnString = " ";
    
    try{
      while(( i = reader.read()) != 13) {
        print(i, " ");
        if( i > 0) {
          returnString += (char) i;
        }
      }
      
    }catch(Exception e) {
      e.printStackTrace();
      println("failed to read");
    }
    println(returnString);
    if(returnString != " ") {
      return returnString;
    }else{
       return null; 
    }
    
  }
  
  String listen2() {
 
  // gui gets from engine
 
  int c;
  String inputStr = "";
  char stop1 = (char) char(13); 
 
  try {
 
    // http : // stackoverflow.com/questions/22563986/understanding-getinputstream-and-getoutputstream
 
    // while ((c=in.read()) != -1)
    while ((c=in.read()) != 13)
    {
      //  print((char) c);
      inputStr += (char) c;
    }
 
    // println (inputStr);
  }
  catch (Exception e) {
    println("Can't read");
  }
 
  if (inputStr != null && !inputStr.equals("")) {
    return inputStr ;
  } else {
    println("inputStr is null");
    return null;
  }
}
  
  void send_config() {
    String stringToSend;
    stringToSend = "setoption name UCI_Elo value " + str(cpu_diff);
    this.listen();
    delay(20);
    this.say(stringToSend);
    delay(20);
    this.say("isready");
    delay(20);
    this.listen();
    delay(20);
    this.say("ucinewgame");
    delay(20);
    this.say("d");
    delay(20);
    this.listen();
  }
  
}// end of class
