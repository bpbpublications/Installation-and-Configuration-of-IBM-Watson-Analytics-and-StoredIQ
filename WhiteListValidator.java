/**
 * 
 */
/**
 * @author Alan S. Bluck
 *
 */
package org.apache.uima.annotator.regex.extension;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
//import org.apache.uima.annotator.regex.extension.Configuration;
public class WhiteListValidator implements org.apache.uima.annotator.regex.extension.Validation{
    private String WhiteList = null;
    //ASB make this available for multiple calls
    private static boolean connect = true;
    private static Connection connection = null;
    private static ResultSet resultRows = null;
    private static PreparedStatement pstmt = null;
    private static final String jdbcDriverClass = "oracle.jdbc.driver.OracleDriver";
	public boolean validate(String coveredText, String ruleID)throws Exception{
       try{
	 //Retrieve rows for testing from the Whitelist Database
        //Load class into memory
        Class.forName(jdbcDriverClass);
        //Establish connection
        if(!(connection != null)){
        	connection = DriverManager.getConnection("jdbc:oracle:thin:@ecmukdemo20:1521:ORCL", "ICAUSER", "filenet");
        }
        if(!(pstmt != null)){
        	pstmt = connection.prepareStatement("Select Distinct LISTVALUE FROM ICAUSER.WHITELIST");
        }
    	resultRows = pstmt.executeQuery();             	
		while (resultRows.next()){
			WhiteList = resultRows.getString(1);
	        if(coveredText.equalsIgnoreCase(WhiteList))
	            return false;
		}
		resultRows.close();
        if(coveredText.equalsIgnoreCase(WhiteList))
            return false;
        else
            return true;
       }catch(Exception sqle){   	   
    	  return true;
       }finally{
    	  if(connection != null) {
    		 // connection.close();
    	  }
    	  if(resultRows != null){
    		 // resultRows.close();
    	  }
       }
