package com.me.fundtracker.model.master
{
	import com.adobe.cairngorm.model.ModelLocator;
	import com.me.fundtracker.valueobjects.master.CategoryVO;
	import com.me.fundtracker.valueobjects.master.MembersVO;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class MasterModelLocator implements ModelLocator
	{		
		/**
		 * Holds the current class instance.
		 */		
		private static var _instance : MasterModelLocator;
		
		/**
		 * Single Instance of Our EffectsUtil  
		 * @param enforcer
		 * 
		 */		
		public function MasterModelLocator(enforcer:SingletonEnforcer) 
		{
			if (enforcer == null) {
				throw new Error( "You Can Only Have One ModelLocator" );
			}
		}
		
		/**
		 * Returns the Single Instance.  
		 * @return 
		 * 
		 */	
		public static function getInstance() : MasterModelLocator 
		{
			if (_instance == null) {
				_instance = new MasterModelLocator( new SingletonEnforcer );
			}
			
			return _instance;
		}	
		
		// -----------------------------------------------------------------------------------------------------------------------------------------
		//							Public member variable declarations for Members Management and its child pages.
		// -----------------------------------------------------------------------------------------------------------------------------------------
		
		/**
		 * Flex Datagrid datasource which holds the collection of MembersVo objects for Members.mxml page.
		 */	
		public var collMembersDetail:ArrayCollection = new ArrayCollection();
		
		/**
		 * Flex Datagrid datasource which holds the collection of MembersVo objects for AddEditMembers.mxml page.
		 */	
		public var collEditableMembersDetail:ArrayCollection = new ArrayCollection();
		
		/**
		 * Set the selected index for all members list datagrid.
		 */		
		public var membersGridSelectedItem : MembersVO;
		
		
		// -----------------------------------------------------------------------------------------------------------------------------------------
		//							Public member variable declarations for Group Category page.
		// -----------------------------------------------------------------------------------------------------------------------------------------
		/**
		 * Flex Datagrid datasource which holds the collection of Category objects for ExpenditureCategory.mxml page.
		 */	
		public var collCategoryList:ArrayCollection = new ArrayCollection();
		
		/**
		 * Set the selected index for Category datagrid.
		 */		
		public var categoryListGridSelectedItem : CategoryVO;
		
		/**
		 * Holds the list of account groups where the groups belongs the several category types.
		 */		
		public var collAccountGroups : ArrayCollection = new ArrayCollection();
		
		/**
		 * Holds the checkbox instance of category groups which is generated dynamically.
		 */		
		public var collCategoryGrpCheckboxInstance : ArrayCollection = new ArrayCollection();
	}
}


// -----------------------------------------------------------------------------------------------------------------------------------------
//					Internal class which is accessed by current class itself that are enforcing the strict Singleton model
// -----------------------------------------------------------------------------------------------------------------------------------------

class SingletonEnforcer {}