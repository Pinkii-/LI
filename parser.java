
 
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
 
public enum Line {
  NAME,PTIME,PDEC,PPROPAG,
       MTIME,MDEC,MPROPAG
};

public class parser
{
  public static void main(String[] args) throws FileNotFoundException, IOException  {
    InputStream in = new FileInputStream(new File(args[0]));
    BufferedReader reader = new BufferedReader(new InputStreamReader(in));
    String line;
    ArrayList<ArrayList<String>> info = new ArrayList<ArrayList<String>>();
    int n = 0;
    while ((line = reader.readLine()) != null) {
      info.add(new ArrayList<String>());
         
      String delims = "[ ]+"; // use + to treat consecutive delims as one;
                                 // omit to treat consecutive delims separately
      String[] tokens = line.split(delims);
      for (int i = 0; i < tokens.length; ++i) { 
		    info.get(n).add(tokens[i]);
		
       	System.out.print(info.get(n).get(i)+" ");   //Prints the string content read from input stream   
      }	   
 	    System.out.println();
      ++n;            
      }

      for(int i = 0; i < info.size(); ++i) {
        System.out.println("----------------------------------------------------------------------------------");
        System.out.println(info.get(i).get(NAME));
        System.out.println();
      } 
        
      reader.close();
    }
}
