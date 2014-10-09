
 
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Enumeration;
 

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
		
       	//System.out.print(info.get(n).get(i)+" ");   //Prints the string content read from input stream   
      }	   
 	    //System.out.println();
      ++n;            
      }
      
      reader.close();

      for(int i = 1; i < info.size(); ++i) {
        System.out.println("----------------------------------------------------------------------------------");
        double espacios=0;
        String aux = ""; if (info.get(i).get(0).length()+2 < 13) espacios = (13-info.get(i).get(0).length()+2)/2;
        String aux1 = ""; for (int x = 0; x < Math.floor(espacios); ++x) aux += " "; for (int x = 0; x < Math.ceil(espacios); ++x) aux1 += " ";
        String aux2 =""; for (int x = 4+aux.length()+info.get(i).get(0).length()+aux1.length(); x<81; ++x) aux2 += " "; aux2 += "|";
        System.out.println("| "+aux+info.get(i).get(0)+aux1+" |"+aux2);
        aux = "-"; for (int x = 0; x < Math.max(info.get(i).get(0).length()+1,15); ++x) aux += "-";
        aux += "|"; for (int x = 0; aux.length()<21; ++x) aux += " ";
        System.out.println("|"+aux+"  Mi SatSolver          |            PicoSat               |");

        aux = ""; for (int x = 14; x<info.get(i).get(0).length(); ++x) aux += " ";
        aux1 = ""; for (int x = 21+aux.length()+info.get(i).get(/*5*/2).length(); x<46; ++x) aux1 += " "; aux1 += "|";
        aux2= ""; for (int x = 50+info.get(i).get(2).length(); x<81; ++x) aux2 += " "; aux2 += "|";
        System.out.println("| Tiempo:        "+aux+"|   "+info.get(i).get(/*5*/2)+aux1+"   "+info.get(i).get(2)+aux2);

        aux = ""; for (int x = 14; x<info.get(i).get(0).length(); ++x) aux += " ";
        aux1 = ""; for (int x = 21+aux.length()+info.get(i).get(/*6*/3).length(); x<46; ++x) aux1 += " "; aux1 += "|";
        aux2= ""; for (int x = 50+info.get(i).get(3).length(); x<81; ++x) aux2 += " "; aux2 += "|";
        System.out.println("| Propagaciones: "+aux+"|   "+info.get(i).get(/*6*/3)+aux1+"   "+info.get(i).get(3)+aux2);
        
        aux = ""; for (int x = 14; x<info.get(i).get(0).length(); ++x) aux += " ";
        aux1 = ""; for (int x = 21+aux.length()+info.get(i).get(/*7*/4).length(); x<46; ++x) aux1 += " "; aux1 += "|";
        aux2= ""; for (int x = 50+info.get(i).get(4).length(); x<81; ++x) aux2 += " "; aux2 += "|";
        System.out.println("| Decisiones/seg:"+aux+"|   "+info.get(i).get(/*7*/4)+aux1+"   "+info.get(i).get(4)+aux2);
        System.out.println();
        
        
      } 
        
     
    }
}
