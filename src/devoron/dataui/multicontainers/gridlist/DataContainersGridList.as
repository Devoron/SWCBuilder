package devoron.components.multicontainers.gridlist
{
	import org.aswing.event.AWEvent;
	import org.aswing.ext.GeneralGridListCellFactory;
	import org.aswing.ext.GridList;
	import org.aswing.VectorListModel;
	
	/**
	 * DataContainersGridList
	 * @author Devoron
	 */
	public class DataContainersGridList extends GridList
	{
		
		public function DataContainersGridList(model:VectorListModel)
		{
			//model = new VectorListModel();
			super(model, new GeneralGridListCellFactory(ContainerGridListCell), 4, 0);
			//set
			//containersGridList.addEventListener(GridListItemEvent.ITEM_DOUBLE_CLICK, onItemDoubleClick);
			setTileWidth(64);
			setTileHeight(64);
			
			setSelectionMode(GridList.MULTIPLE_SELECTION);
			//modulForm.addLeftHoldRow(0, jls, containersGridListSP);
			model.addListDataListener(new DataContainersGridListChangeListener(this));
			//getModel().addTableModelListener(new DataContainersTableChangeListener(this));
			//getModel().addTableModelListener(new DataContainersTableChangeListener(this));
		}
		
		
		public function getData():Array
		{
			return (getModel() as VectorListModel).toArray();
		}
		
		public function setData(data:Array):void
		{
			(getModel() as VectorListModel).clear();
			(getModel() as VectorListModel).appendAll(data);
		}
		
		public function addActionListener(listener:Function):void
		{
			super.addEventListener(AWEvent.ACT, listener);
		}
		
		public function removeActionListener(listener:Function):void
		{
			super.removeEventListener(AWEvent.ACT, listener);
		}
	
	}

}