package devoron.data.core.serializer.serializers
{
	import devoron.data.core.serializer.ISerializer;
	
	/**
	 * SimpleTypesSerializer
	 * @author Devoron
	 */
	public class SimpleTypesSerializer implements ISerializer
	{
		
		public function SimpleTypesSerializer()
		{
		
		}
		
		public function isSupport(any:*):Boolean
		{
			if (any is String || any is Number || any is int || any is uint || any is Boolean)
				return true;
			return false;
		}
		
		/* INTERFACE devoron.data.core.serializer.ISerializer */
		
		public function serialize(any:*):String
		{
		
		}
	
	}

}