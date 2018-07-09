package devoron.data.core.serializer 
{
	
	/**
	 * ICompositeSerializer
	 * @author Devoron
	 */
	public interface ICompositeSerializer extends ISerializer
	{
		function setSerializerShema(serializerShema:ISerializerShema):void;
	}
	
}