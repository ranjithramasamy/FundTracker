package com.me.fundtracker.components
{
	import spark.components.CheckBox;
	
	public class GenericCheckbox extends CheckBox
	{
		/**
		 * Public member to keep custom values. 
		 */		
		public var data : Object;
		
		/**
		 * Constructor
		 */		
		public function GenericCheckbox()
		{
			super();
		}
	}
}