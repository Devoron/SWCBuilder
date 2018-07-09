package devoron.components.tables.fonts
{
	import devoron.aswing.datas.ComponentData;
	import devoron.data.core.base.DataObject;
	import org.aswing.ASFont;
	import org.aswing.Component;
	import org.aswing.table.DefaultTableModel;
	
	
	/**
	 * FontsTableModel
	 * @author Devorons
	 */
	public class FontsTableModel extends DefaultTableModel
	{
		public function FontsTableModel(dataStructurs:Array=null)
		{
			setColumnClass(0, "String");
			setColumnClass(1, "Font");
			setColumnNames(["Key", "Font"]);
			setData(dataStructurs);
		
			//initWithDataNames(dataStructurs, ["Name", "Font", "Insets", "Ground decorator", "Border", "Pref size", "Min size", "Max size"]);
		}
		
		override public function setValueAt(aValue:*, row:int, column:int):void
		{
			//выфавыфоал
			/*
			 * подсказки для отрисовки
			 *
			 * focus(c:Component, g:Graphics2D, b:IntRectangle):void;
			 * требует реализации именно на уровне данные - парсер
			 *
			 * icon
			 * есть не везде. во фреймах есть, в компоненте нет
			 *
			 * internalFocusObject(c:Component):InteractiveObject;
			 * необходим пикер или дерево компонентов, чтобы выбрать вложенный объект
			 *
			 *
			 * styleTune(key:String):StyleTune;
			 * здесь вообще непростая, мне видится, работа
			 */
			var data:ComponentData = getData()[row] as ComponentData;
			var comp:Component = data.component;
			//var comp:Component = aValue as Component;
			
			switch (column)
			{
				case 0: 
					comp.name = aValue;
					break;
				case 1: 
					//gtrace(aValue);
					//var font:ASFont = new ASFont(aValue.name, aValue.size, aValue.bold, aValue.italic, aValue.underline);
					if (aValue is DataObject)
					{
						aValue = new ASFont(aValue.name, aValue.size, aValue.bold, aValue.italic, aValue.underline);
					}
					/*else
					{
						aValue = new ASFont(aValue.name, aValue.size, aValue.bold, aValue.italic, aValue.underline);
					}*/
					
					data.setDataByName(aValue, "font");
					comp.setFont(aValue);
					break;
			}
			
		
			fireTableCellUpdated(row, column);
			comp.updateUI();
		}
		
		/**
		 * Возвратить значение в таблицу.
		 * @param	row
		 * @param	column
		 * @return
		 */
		override public function getValueAt(row:int, column:int):*
		{
			var componentData:ComponentData = getData()[row] as ComponentData;
			var componentProperties:Object = componentData.getDataByContainerName("component");
			
			switch (column)
			{
				case 0: 
					return componentData.dataName;
					break;
				case 1: 
					return componentProperties.font;
					break;
			}
			
			return "undefined";
		}
	
	/*override public function isColumnEditable(column:int):Boolean
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
	 }*/
	
	}

}