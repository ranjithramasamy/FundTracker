package com.me.fundtracker.valueobjects.master
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	import mx.collections.ArrayCollection;

	[Bindable]
    [RemoteClass(alias="com.me.fundtracker.valueobjects.master.CategoryAndAccountGroupsVO")]
	public class CategoryAndAccountGroupsVO implements IValueObject
	{
		/**
		 * Holds the collection of category lists associated with account groups. 
		 */		
		public var categoryList : ArrayCollection;
		/**
		 *Holds the collection of account groups, need to create a create category lists. 
		 */		
		public var accountGroups : ArrayCollection;
	}
}