package com.me.fundtracker.components
{
	import mx.controls.Alert;
	
	import spark.components.List;
	import spark.events.IndexChangeEvent;
	
	public class GenericList extends List
	{
		public function GenericList()
		{
			super();
			
			//addEventListener(IndexChangeEvent.CHANGE, onItemClickHandler);
		}

		/*private function onItemClickHandler( event : IndexChangeEvent ) : void
		{
			var 
			Alert.show("item click")
		}*/
	}
}