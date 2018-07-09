package devoron.data.core.serializer.serializers
{
	import org.aswing.VectorListModel;
	
	/**
	 * VectorListModelSerializer
	 * @author Devoron
	 */
	public class VectorListModelSerializer
	{
		
		public function VectorListModelSerializer()
		{
		
		}
		
		public function isSupport(any:*):Boolean
		{
			if (any is VectorListModel)
				return true;
			return false;
		}
		
		public static function serializeVectorListModel(item:String, serializedData:String, model:VectorListModel):String
		{
			return Serializer.serializeArray(item, serializedData, model.toArray());
		}
	
	}

}