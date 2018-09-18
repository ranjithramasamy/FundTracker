package com.me.fundtracker.components.helpers
{
	import com.adobe.cairngorm.view.ViewHelper;
	import com.me.fundtracker.components.FilterBar;
	import com.me.fundtracker.events.components.InteractiveComponentEvent;
	
	public class FilterBarHelper extends ViewHelper
	{
		/**
		 * Holds the instance of current view which is associate with this helper.
		 */ 
		private var _view : FilterBar;
		
		// --------------------------------------------------------------------------------------------------------------------------------
		// --------------------------------------------------------------------------------------------------------------------------------
		
		/**
		 * Constructor 
		 * 
		 */		
		public function FilterBarHelper()
		{
			super();
		}
		
		/**
		 * On initialize.
		 */		
		public function onInit() : void
		{
			_view = FilterBar(view);
		}
		
		/**
		 * Dispatch refresh event on 'Refresh' button click.
		 */		
		public function dispatchRefreshEvent() : void
		{
			// Define event object, initialize it, then dispatch it.  
			var eventObj:InteractiveComponentEvent = new InteractiveComponentEvent(InteractiveComponentEvent.REFRESH); 
			_view.dispatchEvent(eventObj);
		}
		
		
	}
}