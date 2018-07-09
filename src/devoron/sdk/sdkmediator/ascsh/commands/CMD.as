package devoron.sdk.sdkmediator.ascsh.commands 
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import org.aswing.util.HashMap;
	/**
	 * CMD
	 * @author Devoron
	 */
	dynamic public class CMD extends Proxy
	{
		private var code:String;
		private var description:String;
		protected var objectProperties:HashMap;
		
		public function CMD(code:String = "", description:String = "no description") 
		{
			this.description = description;
			this.code = code;
			this.objectProperties = new HashMap;
		}
		
		public function getCode():String {
			return "";
		}
		
		public function getArguments():String {
			var args:String = "";
			var keys:Array = objectProperties.keys();
			var value:String;
			for each (var key:String in keys) 
			{
				value = objectProperties.get(key);
				//if (value != null) {
					args += key + "=" + value + " " ;
				//}
			}
			
		return 	args;
		}
		
		public function getDesctiption():String {
			return "некий текст";
		}
		
		override flash_proxy function setProperty(name:*, value:*):void
		{
			//if (_useUrls && name == "url") setExtenalResource(String(value));
			//objectProperties.put(name, value);
			var key:String = "-"+String(name).replace("_", "-");
			//if (objectProperties.containsKey(key)) {
			trace("установка свойства " + key + " : " + value);
				objectProperties.put(key, value);
			//}
			
			/*if (dispatcher && _active)
			{
				_dataChangeTimestamp = (new Date()).time;
				dispatcher.dispatchEvent(new Event(Event.CHANGE));
			}*/
		}
		
	}

}