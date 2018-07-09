package devoron.components.filechooser.renderers 
{
	import org.aswing.ext.GeneralGridListCellFactory;
	import org.aswing.ext.GridListCell;
	/**
	 * FileChooserGridListCellFactory
	 * @author Devoron
	 */
	public class FileChooserGridListCellFactory extends GeneralGridListCellFactory
	{
		
		public function FileChooserGridListCellFactory(cellClass:Class)
		{
			super(cellClass);
		}
		
		override public function createNewGridListCell():GridListCell 
		{
			return new cellClass(GRID) as GridListCell
		}
		
		
	}

}