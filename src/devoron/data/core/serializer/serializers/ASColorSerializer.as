package devoron.data.core.serializer.serializers
{
	import org.aswing.ASColor;
	
	/**
	 * ...
	 * @author Devoron
	 */
	public class ASColorSerializer
	{
		
		public function ASColorSerializer()
		{
		
		}
		
		public function isSupport(any:*):Boolean
		{
			if (any is ASColor)
				return true;
			return false;
		}
		
		static public function serializeASColor(serializedData:String, value:Object):String
		{
			//serializedData += qutes(prop) + ":";
			//serializedData = serializeObject(serializedData, value[prop]);
			
			serializedData += qutes(prop) + " : " + qutes(String((value[prop] as ASColor).getARGB()));
			return serializedData;
		}
		
		public static function qutes(str:String):String
		{
			return '"' + str + '"';
		}
	
	}

}