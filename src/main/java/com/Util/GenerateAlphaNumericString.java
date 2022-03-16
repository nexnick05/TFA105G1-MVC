package com.Util;

import java.nio.charset.*;
import java.util.*;

public class GenerateAlphaNumericString {

	public  String getRandomString(int chars) {  

		// bind the length
		byte[] bytearray = new byte[256];		
		String mystring;
		StringBuffer thebuffer;
		String theAlphaNumericS;

		new Random().nextBytes(bytearray);

		mystring = new String(bytearray, Charset.forName("UTF-8"));

		thebuffer = new StringBuffer();

		// remove all spacial char
		theAlphaNumericS = mystring.replaceAll("[^A-Z0-9]", "");

		// random selection
		for (int i = 0; i < theAlphaNumericS.length(); i++) {

			if (Character.isLetter(theAlphaNumericS.charAt(i)) && (chars > 0)
					|| Character.isDigit(theAlphaNumericS.charAt(i)) && (chars > 0)) {

				thebuffer.append(theAlphaNumericS.charAt(i));
				chars--;
			}
		}

		// the resulting string
		return thebuffer.toString();
	}

}
