package devoron.components.multicontainers.tabbedpane
{
	import devoron.components.darktable.DarkTableCellEditor;
	import devoron.components.darktable.DarkTableNumberCellEditor;
	import devoron.components.tabbedpane.DSTabbedPane;
	import devoron.components.tables.DSTable;
	import devoron.components.tables.INewValueGenerator;
	import devoron.data.core.base.DataStructurObject;
	import devoron.studio.modificators.ktween.GraphCellRenderer;
	import devoron.utils.ArrayNamesHelper;
	import org.aswing.ListSelectionModel;
	//import devoron.studio.modificators.ktween.GraphCellRenderer;
	import flash.geom.Matrix;
	import org.aswing.ASColor;
	import org.aswing.decorators.GradientBackgroundDecorator;
	import org.aswing.event.AWEvent;
	import org.aswing.event.SelectionEvent;
	import org.aswing.JTable;
	import org.aswing.table.DefaultTableModel;
	import org.aswing.table.GeneralTableCellFactory;
	import org.aswing.table.GeneralTableCellFactoryUIResource;
	import org.aswing.table.TableModel;
	import org.aswing.TableTextHeaderCell;
	
	/**
	 * DataContainersTabbedPane
	 * @author Devoron
	 */
	public class DataContainersTabbedPane extends DSTabbedPane
	{
		
		public function DataContainersTabbedPane(model:TableModel)
		{
			//super(model);
			
			//super.setDefaultEditor("String", new DarkTableCellEditor());
			//super.getSelectionModel().setSelectionMode(JTable.MULTIPLE_SELECTION);
			//super.setColumnsResizable(false);
			
			//setDefaultEditor("Number", new DarkTableNumberCellEditor());
			
			//getModel().addTableModelListener(new DataContainersTableChangeListener(this));
		}
		
		public function getData():*
		{
			//super.dispatchEvent(new Event(Event.CHANGE));
			return (super.getModel() as DefaultTableModel).getData();
		}
		
		public function setData(data:*):void
		{
			(super.getModel() as DefaultTableModel).setData(data);
		}
		
		public function addActionListener(listener:Function):void
		{
			super.addEventListener(AWEvent.ACT, listener);
		}
		
		public function removeActionListener(listener:Function):void
		{
			super.removeEventListener(AWEvent.ACT, listener);
		}
		
		public function setNewValueGenerator(newValueGenerator:INewValueGenerator):void
		{
			//this.newValueGenerator = newValueGenerator;
		}
		
		public function addDefaultValue():void
		{
			/*if (!newValueGenerator)
				return;
			var model:DefaultTableModel = getModel() as DefaultTableModel;
			if (model)
			{
				var data:Array = model.getData();
				data.push(newValueGenerator.generateNewValue());
				model.setData(data);
			}*/
		
		}
		
		public function removeSelectedValues():void
		{
			return;
			var selModel:ListSelectionModel = super.getSelectionModel();
			var selId:int = selModel.getMaxSelectionIndex();
			
			var data:Array = (getModel() as DefaultTableModel).getData();
			var selIndicies:Array = [];
			selIndicies.sort(Array.NUMERIC);
			selIndicies.reverse();
			for (var i:int = 0; i < selIndicies.length; i++)
			{
				data.removeAt(selIndicies[i]);
			}
			(getModel() as DefaultTableModel).setData(data);
			
			// установить выбранной предыдущую структуру (или следующую, если  нет)
			var structursCount:uint = data.length;
			if (structursCount > 0)
			{
				selId = selId < structursCount ? selId : structursCount - 1;
				selModel.setSelectionInterval(selId, selId);
			}
		}
		
		public function cloneSelectedValues():void
		{
			return;
			var selModel:ListSelectionModel = super.getSelectionModel();
			var selId:int = selModel.getMaxSelectionIndex();
			//var selectedIndices:Array = getSelectedRows();
			var selectedIndices:Array = [];
			var data:Array = (getModel() as DefaultTableModel).getData();
			// если структура данных не выбрана, то ничего предпринимать не следует
			if (!selectedIndices.length)
				return;
			
			var structursCount:uint;
			var dataStructur:*;
			var selId:int = 0;
			
			for each (selId in selectedIndices)
			{
				//dataStructur = (dataStructursTableModel.getData()[dataStructursTable.getSelectedRow()]).clone();
				//structursCount = data.push((data[selId]).clone());
				structursCount = data.push(getValueClone(data[selId]));
			}
			
			(getModel() as DefaultTableModel).setData(data);
			selId = structursCount - 1;
			selModel.setSelectionInterval(selId, selId);
		}
		
		public function getValueClone(value:*):*
		{
			return null;
		}
		
		protected function getNewDefaultValueName(dataName:String):String
		{
			/*var dsOrDSO:*; // DataStructur or DataStructurObject
			   var childNode:TreeNode;
			   var childrenCount:int = node.getChildCount();
			   var dataStructurs:Array = [];
			
			   for (var i:int = 0; i < childrenCount; i++)
			   {
			   childNode = node.getChildAt(i);
			   dsOrDSO = (childNode as DefaultMutableTreeNode).getUserObject();
			   dataStructurs.push(dsOrDSO);
			 }*/
			var model:DefaultTableModel = getModel() as DefaultTableModel;
			var names:Array = model.getData()
			/*for (var i:int = 0; i < names.length; i++)
			   {
			   names[i] = (names[i] as Object).name;
			 }*/
			
			return ArrayNamesHelper.createNewOrdinalName(names, "dataName", dataName)
		}
	
	}

}

