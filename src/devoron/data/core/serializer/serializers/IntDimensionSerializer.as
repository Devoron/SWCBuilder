package devoron.data.core.serializer.serializers
{
	import org.aswing.geom.IntDimension;
	
	/**
	 * ...
	 * @author Devoron
	 */
	public class IntDimensionSerializer
	{
		
		public function IntDimensionSerializer()
		{
		
		}
		
		public function isSupport(any:*):Boolean
		{
			if (any is IntDimension)
				return true;
			return false;
		}
		
		static public function serializeIntDimension(serializedData:String, value:Object):String
		{
			serializedData += qutes("IntDimension") + ":" + "23";
			//serializedData = serializeObject(serializedData, value[prop]);
			//serializedData += "{";
			//for (var prop:String in value)
			//{
			//if (value[prop] is String)
			//serializedData += qutes(prop) + ":" + qutes(value[prop]) + ",";
			//
			//
			//}
			//
			//serializedData += "}" /*+ ","*/;
			//
			return serializedData;
		}
		
		public static function qutes(str:String):String
		{
			return '"' + str + '"';
		}
	
	}

}