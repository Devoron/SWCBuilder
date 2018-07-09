package devoron.dataui.multicontainers.timeline
{
	import devoron.data.core.base.DataStructurObject;
	import flash.events.Event;
	import org.aswing.table.DefaultTableModel;
	
	public class TimelineModel extends DefaultTableModel
	{
		
		public function TimelineModel(data:Array = null)
		{
			setColumnClass(0, "TimelineTrack");
			setData((data != null) ? data : new Array());
			setColumnNames(["Track"]);
		}
		
		override public function setValueAt(aValue:*, row:int, column:int):void
		{
			/*if (this.value != value.data.data)
			{
				if (this.value)
				{
					this.value.removeEventListener(Event.CHANGE, onChange);
				}
				
				this.value = value.data.data;
				this.value.addEventListener(Event.CHANGE, onChange);
				setDSO(this.value);
			}*/
			
			/*if (getValueAt(row, column) != aValue){
				if (getValueAt(row, column)){
					getValueAt(row, column).data.data.removeEventListener(Event.CHANGE, onChange);
				}
			}*/
			
			//var dataObj:Object = getData()[row];
			fireTableCellUpdated(row, column);
		}
		
		
		
		override public function getValueAt(row:int, column:int):*
		{
			return getData()[row];
		}
		
		override public function isColumnEditable(column:int):Boolean
		{
			if (column == 0) return true;
			else return false;
			return false;
		}
		
		override public function isCellEditable(rowIndex:int, columnIndex:int):Boolean
		{
			if (columnIndex == 0) return true;
			else return false;
			return false;
		}
	
	}
}