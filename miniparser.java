import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Enumeration;

public class miniparser{
  public static void main(String[] args) throws FileNotFoundException, IOException  {
    InputStream in = new FileInputStream(new File(args[0]));
    BufferedReader reader = new BufferedReader(new InputStreamReader(in));
    String line;
    ArrayList<String> info = new ArrayList<String>();
    while ((line = reader.readLine()) != null) {
      String delims = "[ ]+"; 
      String[] tokens = line.split(delims);
      info.add(tokens[1]);
    }	
    reader.close();
    System.out.println(info.get(0) + " " + info.get(1) + " " + info.get(2));    
    }
}
