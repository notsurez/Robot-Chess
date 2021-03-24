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
  
  Written by: Christian Brazeau
  Other Contributers:
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
    String returnString = "";
    try{
      while(( i = reader.read()) != 10) {
        if( i > 0) {
          returnString += (char) i;
        }
      }
      println(returnString);
    }catch(Exception e) {
      e.printStackTrace();
      println("failed to read");
    }
    
    if(returnString != null) {
      return returnString;
    }else{
       return null; 
    }
    
  }
  
  
}// end of class
