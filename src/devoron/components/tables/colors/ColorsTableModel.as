package devoron.components.tables.colors
{
	
	import devoron.utils.gtrace;
	import org.aswing.table.DefaultTableModel;
	
	public class ColorsTableModel extends DefaultTableModel
	{
		
		public function ColorsTableModel(properties:Array = null)
		{
			setColumnClass(0, "String");
			setColumnClass(1, "Color");
			setData((properties != null) ? properties : new Array());
			setColumnNames(["Key", "Color"]);
		}
		
		override public function setValueAt(aValue:*, row:int, column:int):void
		{
			gtrace("новое значение пришло" + aValue);
			var property:Object = getData()[row];
			switch (column)
			{
				case 0: 
					getData()[row].name = aValue;
					break;
				case 1: 
					getData()[row].value = aValue;
					break;
			}
			//getData()[row] = property;
			super.fireTableCellUpdated(row, column);
			//fireTableCellUpdated(row, column);
		}
		
		override public function getValueAt(row:int, column:int):*
		{
			var property:Object = getData()[row];
			
			switch (column)
			{
				case 0: 
					return String(property.name);
					break;
				case 1: 
					return property.value;
					break;
			}
			
			return "undefined";
		}
		
		override public function isColumnEditable(column:int):Boolean
		{
			// столбец Snapshot
			if (column == 1)
			return false;
			return true;
		}
		
		override public function isCellEditable(rowIndex:int, columnIndex:int):Boolean
		{
			return true;
		}
	
	}
}