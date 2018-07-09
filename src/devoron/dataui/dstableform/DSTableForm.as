package devoron.dataui.dstableform
{
	import devoron.components.buttons.DSButton;
	import devoron.components.tables.INewValueGenerator;
	import devoron.components.tables.TableControlPanel;
	import devoron.data.core.base.DataStructur;
	import devoron.data.core.base.DataStructurEvent;
	import devoron.dataui.DataStructursTable;
	import devoron.dataui.DataStructursTableModel;
	import org.aswing.event.AWEvent;
	import org.aswing.event.SelectionEvent;
	import org.aswing.event.TableCellEditEvent;
	import org.aswing.event.TableModelEvent;
	import org.aswing.ext.Form;
	import org.aswing.ext.FormRow;
	import org.aswing.geom.IntDimension;
	import org.aswing.JButton;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
	import org.aswing.JTable;
	import org.aswing.ListSelectionModel;
	import org.aswing.table.DefaultTableModel;
	
	/**
	 * DSTableForm
	 * @author Devoron
	 */
	public class DSTableForm extends Form
	{
		protected var dataStructursTableSelectionModel:ListSelectionModel;
		protected var dataStructursTableScP:JScrollPane;
		private var dataStructursTableModel:DataStructursTableModel;
		private var dataStructursTable:DataStructursTable;
		private var newValueGenerator:INewValueGenerator;
		private var dataStructurs:Array;
		private var tcpContainer:JPanel;
		private var tcp:TableControlPanel;
		private var dataStructurClass:Class;
		private var dataName:String;
		
		public function DSTableForm()
		{
			installComponents();
		}
		
		public function installListeners():void {
			
		}
		
		/*public function addTableModelListener(type:String, listener:Function):void {
			//dataStructursTable.addE
		}*/
		
		public function removeTableModelListener():void {
			
		}
		
		public function getTable():DataStructursTable {
			return dataStructursTable;
		}
		
		public function getTableControlPanel():TableControlPanel {
			return tcp;
		}
		
		public function setTableControlPanel(tcp:TableControlPanel):void {
			this.tcp = tcp;
			tcpContainer.removeAll();
			tcpContainer.append(tcp);
			tcpContainer.revalidate();
		}
		
		public function setNewValueGenerator(newValueGenerator:INewValueGenerator):void {
			this.newValueGenerator = newValueGenerator;
			dataStructursTable.setNewValueGenerator(newValueGenerator);
		}
		
		public function setData(data:Array):void
		{
			var structursCount:uint = dataStructurs.push(dataStructur);
			dataStructursTableModel.setData(dataStructursTableModel.getData());
			dataStructursTableSelectionModel.setSelectionInterval(structursCount - 1, structursCount - 1);
		}
		
		private function installComponents():void
		{
			this.dataName = dataName;
			//throw new Error("in DSTableForm.as");
			dataStructursTableModel =/* model ? model :*/ new DataStructursTableModel(dataStructurs);
			dataStructursTable = new DataStructursTable(dataStructursTableModel, dataStructurClass);
			
			dataStructursTable.setSelectionMode(JTable.MULTIPLE_SELECTION);
			dataStructursTableSelectionModel = dataStructursTable.getSelectionModel();
			dataStructursTable.addSelectionListener(dataTableSelectionHandler);
			dataStructursTable.addActionListener(dataStructursModelChange);
			//dataStructursTable.addEventListener(TableCellEditEvent.EDITING_STOPPED, onEditingStoped);
			
			dataStructursTableScP = new JScrollPane(dataStructursTable, JScrollPane.SCROLLBAR_ALWAYS, JScrollPane.SCROLLBAR_NEVER);
			dataStructursTableScP.getHorizontalScrollBar().setEnabled(false);
			dataStructursTableScP.setPreferredSize(new IntDimension(267, 180));
			addLeftHoldRow(0, dataStructursTableScP);
			
			tcpContainer = new JPanel();
			tcpContainer.setPreferredWidth(267);
			addLeftHoldRow(0, tcpContainer);
			
			var tcp:TableControlPanel = new TableControlPanel(dataStructursTable);
			setTableControlPanel(tcp);
			
			var composite:Form = new Form();
			//var tableFR:FormRow = composite.addLeftHoldRow(0, tableForm);
			
			//devoron_studio::modulForm.addLeftHoldRow(0, composite)
			//return composite;
		}
		
		private function dataStructursModelChange():void 
		{
			//dataStructursTable
		}
		
		protected function dataTableSelectionHandler(e:SelectionEvent):void
		{
			if (dataStructursTable.getSelectedRowCount() > 1)
				return;
			
			var selId:int = dataStructursTable.getSelectedRow();
			if (selId == -1)
				return;
			
			// выбранная структура данных
			var dataStructur:DataStructur = dataStructursTableModel.getData()[selId];
			//setSelectedDataStructur(dataStructur);
			//dispatchEvent(new DataStructurEvent
		}
		
		private function setSelectedDataStructur(dataStructur:DataStructur):void 
		{
			
		}
		
		
		private function addDataStructurBtnHandler(e:AWEvent):void 
		{
			var dataStructur:DataStructur = addNewDataStructur();
			
			if (dataStructursTable)
			{
				var structursCount:uint = dataStructurs.push(dataStructur);
				dataStructursTableModel.setData(dataStructursTableModel.getData());
				dataStructursTableSelectionModel.setSelectionInterval(structursCount - 1, structursCount - 1);
			}
		}
		
		private function removeDataStructurBtnHandler(e:AWEvent):void 
		{
			
		}
		
		private function copyDataStructurBtnHandler(e:AWEvent):void 
		{
			
		}
		
		private function unistallComponents():void
		{
		
		}
		
		/**
		 * Создать кнопку.
		 * @param	text
		 * @param	listener
		 * @return
		 */
		protected function createButton(text:String, listener:Function):JButton
		{
			var btn:JButton = new DSButton(text, null, listener, 81, 16);
			return btn;
		}
	}

}