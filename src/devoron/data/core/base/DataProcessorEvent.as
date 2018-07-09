package devoron.data.core.base
{
	import flash.events.Event;
	
	/**
	 * StudioEvent
	 * @author Devoron
	 */
	public class DataProccessorEvent extends Event
	{
		public static const DATA_CHANGE:String = "data_change";
		
		public static var CHANGE_FILE_MANAGER:String = "data_change";
		public static var CHANGE_FILE_MANAGER:String = "data_remove";
		public static var CHANGE_FILE_MANAGER:String = "data_create";
		
		public static var STAGE_ACCESS_ON:String = "stage_access_on";
		public static var STAGE_ACCESS_OFF:String = "stage_access_off";
		
		private var _data:Object;
		
		public function DataProccessorEvent(data:Object, type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			_data = data;
		}
		
		public function get data():Object
		{
			return _data;
		}
	
	}

}