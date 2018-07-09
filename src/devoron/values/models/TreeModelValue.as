package devoron.values.models 
{
	import org.aswing.tree.TreeModel;
	/**
	 * ...
	 * @author Devoron
	 */
	public class TreeModelValue 
	{
		private var treeModel:TreeModel;
		
		public function TreeModelValue() 
		{
			
		}
		
		public function getRelatedModel():TreeModel{
			return treeModel;
		}
		
		public function setRelatedModel(treeModel:TreeModel):void{
			this.treeModel = treeModel;
		}
		
	}

}