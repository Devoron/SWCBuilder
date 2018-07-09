package devoron.data.core.serializer.serializers
{
	import org.aswing.tree.DefaultTreeModel;
	
	/**
	 * TreeModelSerializer
	 * @author Devoron
	 */
	public class TreeModelSerializer
	{
		
		public function TreeModelSerializer()
		{
		
		}
		
		public function isSupport(any:*):Boolean
		{
			if (any is DefaultTreeModel)
				return true;
			return false;
		}
		
		public static function serializeTreeModel(item:String, serializedData:String, treeModel:DefaultTreeModel):String
		{
			//var cCount:uint = treeModel.getChildCount();
			
			var root:DefaultMutableTreeNode = treeModel.getRoot() as DefaultMutableTreeNode;
			
			//var ds:DataStructur = root.getUserObject() as DataStructur;
			//ds.uid
			// получаем UserObject и сериализуем его уже как объект
			//var obj:Object = root.getUserObject();
			//treeModel.getChild(treeModel.getRoot(), cCount);
			// рекурсивная проверка узлов
			
			return serializeNode(serializedData, root);
		}
		
		public static function qutes(str:String):String
		{
			return '"' + str + '"';
		}
		
	
	}

}