 
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
 
public class ReadStreamIntoStringUsingReader
{
    public static void main(String[] args) throws FileNotFoundException, IOException
    {
        InputStream in = new FileInputStream(new File(args[0]));
        BufferedReader reader = new BufferedReader(new InputStreamReader(in));
        String line;
        while ((line = reader.readLine()) != null) {
            System.out.println(line);   //Prints the string content read from input stream            
            //out.append(line);
        }
        
        reader.close();
    }
}
