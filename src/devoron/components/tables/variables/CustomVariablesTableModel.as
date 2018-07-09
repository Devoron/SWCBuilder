package devoron.components.tables.variables
{
	import org.aswing.table.DefaultTableModel;
	
	/**
	 * ...
	 * @author Devoron
	 */
	public class CustomVariablesTableModel extends DefaultTableModel
	{
		
		public function CustomVariablesTableModel(properties:Array = null, showLines:Boolean = false)
		{
			setData((properties != null) ? properties : new Array());
			if(showLines)
			setColumnNames(["N", "Value", "Type"]);
		}
		
		override public function setValueAt(aValue:*, row:int, column:int):void
		{
			var element:Object = getData()[row];
			switch (column)
			{
				case 0: 
					//element.name = aValue;
					break;
				case 1: 
					element.value = aValue;
					break;
				case 2: 
					element.type = aValue;
					break;
			}
			fireTableCellUpdated(row, column);
		}
		
		override public function getValueAt(row:int, column:int):*
		{
			var element:Object = getData()[row];
			
			switch (column)
			{
				case 0: 
					return String(row);
					break;
				case 1: 
					return element.value;
					break;
				case 2: 
					return element.type;
					break;
			}
			
			return "undefined";
		}
		
		override public function isColumnEditable(column:int):Boolean
		{
			return column == 0 ? false : true;
		}
		
		override public function isCellEditable(rowIndex:int, columnIndex:int):Boolean
		{
			return columnIndex == 0 ? false : true;
		}
	
	}
}