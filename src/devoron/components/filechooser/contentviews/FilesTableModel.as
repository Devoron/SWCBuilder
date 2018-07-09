package devoron.components.filechooser.contentviews
{
	import devoron.file.FileInfo;
	import devoron.data.core.base.DataStructur;
	import org.aswing.table.DefaultTableModel;
	
	/**
	 * Модель таблицы мешей.
	 * @author Devoron
	 */
	public class FilesTableModel extends DefaultTableModel
	{
		public function FilesTableModel(dataStructurs:Array)
		{
			setColumnClass(0, "String");
			setData(dataStructurs);
			setColumnNames(["Name", "Type", "Creation date"])
		}
		
		override public function setValueAt(aValue:*, row:int, column:int):void
		{
			var fi:FileInfo = getData()[row] as FileInfo;
			var columnName:String = getColumnName(column);
			switch (columnName)
			{
				case "Name": 
					fi.name = aValue;
					break;
				case "Type": 
					fi.extension = aValue;
					break;
				case "Creation date": 
					fi.creationDate = aValue;
					break;
			}
			fireTableCellUpdated(row, column);
		}
		
		/**
		 * Возвратить значение в таблицу.
		 * @param	row
		 * @param	column
		 * @return
		 */
		override public function getValueAt(row:int, column:int):*
		{
			
			var fi:FileInfo = getData()[row] as FileInfo;
			
			var columnName:String = getColumnName(column);
			switch (columnName)
			{
				case "Name": 
					return fi.name;
					break;
				case "Type": 
					return fi.extension;
					break;
				case "Creation date": 
					return fi.creationDate;
					break;
			}
			
			return "undefined";
		}
		
		override public function isColumnEditable(column:int):Boolean
		{
			if (column == 0)
				return true;
			return false;
		}
		
		override public function isCellEditable(rowIndex:int, columnIndex:int):Boolean
		{
			if (columnIndex == 0)
				return true;
			return false;
		}
	
	}

}