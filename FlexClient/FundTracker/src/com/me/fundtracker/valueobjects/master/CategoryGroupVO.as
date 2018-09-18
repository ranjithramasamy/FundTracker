package com.me.fundtracker.valueobjects.master
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
    [RemoteClass(alias="com.me.fundtracker.valueobjects.master.CategoryGroupVO")]
	public class CategoryGroupVO implements IValueObject
	{
		private var _groupKey : String;		
		private var _groupName : String;
		
		public function get groupKey() : String
		{
			return _groupKey;
		}
		
		public function get groupName() : String
		{
			return _groupName;
		}
		
		public function set groupKey( value : String ) : void
		{
			_groupKey  = value;
		}
		
		public function set groupName( value : String ) : void
		{
			_groupName  = value;
		}
	}
}