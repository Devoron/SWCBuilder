package devoron.data.core.serializer.serializers
{
	import devoron.data.core.serializer.ICompositeSerializer;
	import devoron.data.core.serializer.ISerializerShema;
	import devoron.data.core.serializer.SerializerShema;
	
	/**
	 * ...
	 * @author Devoron
	 */
	public class ArraySerializer implements ICompositeSerializer
	{
		
		public function ArraySerializer()
		{
		
		}
		
		public function isSupport(any:*):Boolean {
			if (any is Array)
			return true;
		return false;
		}
		
		public static function serializeArray(item:String, serializedData:String, arr:Array):String
		{
			//gtrace("сериализация массива");
			serializedData += qutes(item) + " : " + "[";
			var value:*;
			for (var i:uint = 0; i < arr.length; i++)
			{
				value = arr[i];
				
				// обработка простых типов
				serializedData = SerializerShema.serializeValue(serializedData, value);
				
				// обработка сложных типов
				serializedData = SerializerShema.serializeObject(serializedData);
				
			}
			
			//if (arr.length > 0)
			//serializedData = serializedData.substring(0, serializedData.length - 1);
			
			if (serializedData.charAt(serializedData.length - 1) == ",")
				serializedData = serializedData.substr(0, serializedData.length - 1);
			
			//serializedData = serializedData.substring(0, serializedData.length - 2) + "}";
			serializedData += "]" /*+ ","*/;
			return serializedData;
		}
		
		public static function qutes(str:String):String
		{
			return '"' + str + '"';
		}
		
		/* INTERFACE devoron.data.core.serializer.ICompositeSerializer */
		
		public function setSerializerShema():void 
		{
			
		}
		
		public function setSerializerShema(serializerShema:ISerializerShema):void 
		{
			
		}
		
		public function serialize(any:*):String 
		{
			
		}
		
	
	}

}