package devoron.components.tables
{
	//import MAINS.other.editors.LiveTableChangeListener;
	import devoron.components.decorators.ResizedGradientBackgroundDecorator;
	import devoron.utils.ArrayNamesHelper;
	import flash.geom.Matrix;
	import org.aswing.ASColor;
	import org.aswing.border.SideLineBorder;
	import org.aswing.decorators.GradientBackgroundDecorator;
	import org.aswing.JTable;
	import org.aswing.ListSelectionModel;
	import org.aswing.event.AWEvent;
	import org.aswing.event.TableModelEvent;
	import org.aswing.event.TableModelListener;
	import org.aswing.table.DefaultTableModel;
	import org.aswing.table.JTableHeader;
	import org.aswing.table.TableModel;
	
	/**
	 * DSTable
	 * @author Devoron
	 */
	public class DSTable extends JTable implements TableModelListener
	{
		private var newValueGenerator:INewValueGenerator;
		protected var columnSizes:Array = [20, 200, 150];
		
		public function DSTable(model:TableModel = null)
		{
			super(model);
			
			setShowHorizontalLines(false);
			
			setGridColor(new ASColor(0X000000, 0.14));
			setForeground(new ASColor(0xFFFFFF, 0.4));
			setSelectionBackground(new ASColor(0XFFFFFF, 0.08));
			setSelectionForeground(new ASColor((0xFFFFFF, 0.4), 0.6));
			//setSelectionForeground(new ASColor(0x000000, 0.6));
			setBackgroundDecorator(null);
			getSelectionModel().setSelectionMode(JTable.SINGLE_SELECTION);
			setScrollPaneDisabledWhenEditing(true);
			
			var clr:uint = 0x000000;
			var colors:Array = [clr, clr, clr, clr, clr];
			var alphas:Array = [0.14, 0.08, 0.04, 0.02, 0.01];
			var ratios:Array = [0, 70, 145, 200, 255];
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(270, 19, 0, 0, 0);
			var bg:ResizedGradientBackgroundDecorator = new ResizedGradientBackgroundDecorator(GradientBackgroundDecorator.LINEAR, colors, alphas, ratios, matrix, "pad", "rgb", 0, null, 0);
			bg.setGaps(0, 0, 0, 2);
			
			var header:JTableHeader = getTableHeader();
			header.setPreferredHeight(19);
			header.setForeground(new ASColor(0xFFFFFF, 0.5));
			header.setBorder(new SideLineBorder(new SideLineBorder(null, SideLineBorder.WEST, new ASColor(0x000000, 0.14), 0.5), SideLineBorder.EAST, new ASColor(0x000000, 0.14), 0.5));
			header.setBackgroundDecorator(bg);
		
			//getCellPane().setBorder(new SideLineBorder(new SideLineBorder(null, SideLineBorder.WEST, new ASColor(0x000000, 0.14), 0.5), SideLineBorder.EAST, new ASColor(0x000000, 0.14), 0.5));
		}
		
		
		/*override public function setModel(dataModel:TableModel):void 
		{
			if (super.getModel()) {
				super.getModel().removeTableModelListener(this);
			}
			super.setModel(dataModel);
			if(dataModel)
			dataModel.addTableModelListener(this);
		}*/
		/* INTERFACE org.aswing.event.TableModelListener */
		
		public override function tableChanged(e:TableModelEvent):void
		{
			super.tableChanged(e);
			dispatchEvent(new AWEvent(AWEvent.ACT));
			//dispatchEvent(e);
		}
		
		public function addActionListener(listener:Function):void
		{
			addEventListener(AWEvent.ACT, listener);
		}
		
		public function removeActionListener(listener:Function):void
		{
			removeEventListener(AWEvent.ACT, listener);
		}
		
		//public function ad
		
		override public function setData(data:*):void
		{
			super.setData(data);
			/*liveObjectsTable*/
			setColumnsSize(columnSizes);
			//super.setColumnsSize(20, 200, 150);
			revalidate();
			//super.setPreferredWidth(420);
			//super.setColumnsResizable(false);
			//super.setRo
		}
		
		public function setNewValueGenerator(newValueGenerator:INewValueGenerator):void
		{
			this.newValueGenerator = newValueGenerator;
		}
		
		public function addDefaultValue():void
		{
			if (!newValueGenerator)
				return;
			var model:DefaultTableModel = getModel() as DefaultTableModel;
			if (model)
			{
				var data:Array = model.getData();
				data.push(newValueGenerator.generateNewValue());
				model.setData(data);
			}
		
		}
		
		public function removeSelectedValues():void
		{
			var selModel:ListSelectionModel = super.getSelectionModel();
			var selId:int = selModel.getMaxSelectionIndex();
			
			var data:Array = (getModel() as DefaultTableModel).getData();
			var selIndicies:Array = getSelectedRows();
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
			var selModel:ListSelectionModel = super.getSelectionModel();
			var selId:int = selModel.getMaxSelectionIndex();
			var selectedIndices:Array = getSelectedRows();
			var data:Array = (getModel() as DefaultTableModel).getData();
			// если структура данных не выбрана, то ничего предпринимать не следует
			if (!selectedIndices.length)
				return;
			
			var structursCount:uint;
			var dataStructur:*;
			selId = 0;
			
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
		
		public function getDataStructurs():Array
		{
			return (getModel() as DefaultTableModel).getData();
		}
		
		public function setDataStructurs(dataStructurs:Array):void
		{
			(getModel() as DefaultTableModel).setData(dataStructurs);
		}
	
	}

}