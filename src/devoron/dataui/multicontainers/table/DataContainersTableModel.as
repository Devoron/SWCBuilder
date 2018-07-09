package devoron.dataui.multicontainers.table
{
	import org.aswing.table.DefaultTableModel;
	
	public class DataContainersTableModel extends DefaultTableModel
	{
		
		public function DataContainersTableModel(data:Array = null)
		{
			setColumnClass(0, "String");
			setColumnClass(1, "String");
			setData((data != null) ? data : new Array());
			setColumnNames(["Name", "Type"]);
		}
		
		override public function setValueAt(aValue:*, row:int, column:int):void
		{
			var dataObj:Object = getData()[row];
			switch (column)
			{
				case 0: 
					dataObj.name = aValue;
					break;
				/*case 1:
					material.data = aValue;
					break;*/
			}
			fireTableCellUpdated(row, column);
		}
		
		override public function getValueAt(row:int, column:int):*
		{
			var dataObj:Object = getData()[row];
			
			switch (column)
			{
				case 0: 
					return dataObj.name;
					break;
				case 1: 
					return dataObj.data.id;
					break;
			}
			
			return "undefined";
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