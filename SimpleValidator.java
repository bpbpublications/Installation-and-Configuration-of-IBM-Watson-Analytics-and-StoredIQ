package org.apache.uima.annotator.regex.extension;
	public class SimpleValidator implements org.apache.uima.annotator.regex.extension.Validation {
		
		public boolean validate(String coveredText, String ruleID) throws Exception {
			
			if (coveredText.equals("alan.bluck@asbsoftware.co.uk"))
				return false;
			else
				return true;
		}
		
	}