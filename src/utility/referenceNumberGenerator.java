package utility;

import java.util.Random;

// References: https://www.baeldung.com/java-random-string
public class referenceNumberGenerator {
	
    private static int leftLimit = 97; // letter 'a'
    private static int rightLimit = 122; // letter 'z'
	private int StringLength;

	public referenceNumberGenerator(int StringLength) {
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
