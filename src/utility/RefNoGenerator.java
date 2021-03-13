package utility;

import java.util.Random;

/**
* RefNoGenerator randomly generates reference number for 
* the unique identification of receipts in the database.
* 
* Reference: https://www.baeldung.com/java-random-string
* 
* @author  Yap Jheng Khin
* @version 1.0
* @since   2021-03-12 
*/
public class RefNoGenerator {
	
    private static int leftLimit = 97; // letter 'a'
    private static int rightLimit = 122; // letter 'z'
	private int StringLength;

	public RefNoGenerator(int StringLength) {
		this.StringLength = StringLength;
	}
	
	public String generate() {
	    Random random = new Random();
	    StringBuilder buffer = new StringBuilder(StringLength);
	    
	    for (int i = 0; i < StringLength; i++) {
	        int randomLimitedInt = leftLimit + (int) 
	          (random.nextFloat() * (rightLimit - leftLimit + 1));
	        buffer.append((char) randomLimitedInt);
	    }
	    
	    String generatedString = buffer.toString();

	    return generatedString.toUpperCase();
	}

}
