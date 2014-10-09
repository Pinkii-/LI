
 
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
 
public class parser
{
    public static void main(String[] args) throws FileNotFoundException, IOException
    {
        InputStream in = new FileInputStream(new File(args[0]));
        BufferedReader reader = new BufferedReader(new InputStreamReader(in));
        String line;
        ArrayList<ArrayList<String> > info = new ArrayList<ArrayList<String> >();
        int n = 0;
        while ((line = reader.readLine()) != null) {
              
            
            String delims = "[ ]+"; // use + to treat consecutive delims as one;
                                 // omit to treat consecutive delims separately
            String[] tokens = line.split(delims);
            for (int i = 0; i < tokens.length; ++i) info[n][i]= tokens[i];
            System.out.println(tokens[0]+" "+tokens[1]+" "+" "+tokens[2]+" "+" "+tokens[3]+" "+" "+tokens[4]+" "+" "+tokens[5]+" ");   //Prints the string content read from input stream      
 
            ++n;            
        }
        
        reader.close();
    }
}
