package devoron.aslc.moduls.libraries
{
	import devoron.studio.moduls.code.tools.debugger.ParamObject;
	
	import org.aswing.table.DefaultTableModel;
	
	public class IncludedClassesTableModel extends DefaultTableModel
	{
		
		public function IncludedClassesTableModel(properties:Array = null)
		{
			setData((properties != null) ? properties : new Array());
			setColumnNames(["N", "Name", "FileSize", "LastModified"]);
			setColumnClass(0, "Value");
			setColumnClass(1, "String");
		}
		
		override public function setValueAt(aValue:*, row:int, column:int):void
		{
			var element:Object = getData()[row] as Object;
			switch (column)
			{
				case 0: 
					element.optional = aValue;
					break;
				case 1: 
					element.type = aValue;
					break;
				
			}
			fireTableCellUpdated(row, column);
		}
		
		override public function getValueAt(row:int, column:int):*
		{
			var element:Object = getData()[row] as Object;
			
			switch (column)
			{
				case 0: 
					return element.optional;
					break;
				case 1: 
					return element.type;
					break;
				//case 2: 
					//return element.optional;
					//break;
					case 2: 
					return element.fileSize;
					break;
				case 3:
					return element.mDate;
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