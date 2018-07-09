package devoron.aslc.events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Devoron
	 */
	public class SWCBuilderEvent extends Event
	{
		public var data:*;

		public static const NEW_PROJECT:String = "new_project";
		
		public function SWCBuilderEvent(type:String, data:*) 
		{
			super(type);
			this.data = data;
			
		}
		
	}

}