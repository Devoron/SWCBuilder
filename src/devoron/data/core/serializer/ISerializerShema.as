package devoron.data.core.serializer 
{
	
	/**
	 * ISerializerShema
	 * @author Devoron
	 */
	public interface ISerializerShema 
	{
		function registerSerializer(cls:Class, serializer:ISerializer):void;
		function unregisterSerializer(cls:Class, serializer:ISerializer):void;
	}
	
}