package com.me.fundtracker.valueobjects.transaction
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	[Bindable]
	[RemoteClass(alias="com.me.fundtracker.valueobjects.transaction.DonationVO")]
	public class DonationVO implements IValueObject
	{
		private var _donationId : String;		
		private var _date : String;		
		private var _donCategoryID : int;		
		private var _donCategoryType : String;		
		private var _donatedBy : String;
		private var _narration : String;
		private var _amount : String;

		public function get donationId():String
		{
			return _donationId;
		}

		public function set donationId(value:String):void
		{
			_donationId = value;
		}

		public function get date():String
		{
			return _date;
		}

		public function set date(value:String):void
		{
			_date = value;
		}

		public function get donCategoryID():int
		{
			return _donCategoryID;
		}

		public function set donCategoryID(value:int):void
		{
			_donCategoryID = value;
		}

		public function get donCategoryType():String
		{
			return _donCategoryType;
		}

		public function set donCategoryType(value:String):void
		{
			_donCategoryType = value;
		}

		public function get donatedBy():String
		{
			return _donatedBy;
		}

		public function set donatedBy(value:String):void
		{
			_donatedBy = value;
		}

		public function get narration():String
		{
			return _narration;
		}

		public function set narration(value:String):void
		{
			_narration = value;
		}

		public function get amount():String
		{
			return _amount;
		}

		public function set amount(value:String):void
		{
			_amount = value;
		}


	}
}