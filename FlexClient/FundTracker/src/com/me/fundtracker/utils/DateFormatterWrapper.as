 package com.me.fundtracker.utils
{
	import mx.formatters.DateFormatter;
	
	public class DateFormatterWrapper extends DateFormatter
	{
		/**
		 * Constructor 
		 * 
		 */		
		public function DateFormatterWrapper()
		{
			super();
		}
		
		/**
		 * Parse Date string to Date object. 
		 * @param value
		 * @return 
		 * 
		 */		
		public function parseDateStringToDate( value : String ) : Date
		{
			return parseDateString( value );
		} 
	}
}