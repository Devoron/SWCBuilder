package devoron.dataui
{
	import devoron.components.tables.DSTable;
	import devoron.components.tables.INewValueGenerator;
	import devoron.data.core.base.DataStructur;
	import org.aswing.ASColor;
	import org.aswing.event.SelectionEvent;
	import org.aswing.JTable;
	import org.aswing.table.GeneralTableCellFactoryUIResource;
	import org.aswing.table.TableModel;
	import org.aswing.TableTextHeaderCell;
	
	/**
	 * Таблица структур данных.
	 * @author Devoron
	 */
	//public class DataStructursTable extends JTable 
	public class DataStructursTable extends DSTable implements INewValueGenerator
	{
		private var dataStructurClass:Class;
		
		public function DataStructursTable(model:TableModel, dataStructurClass:Class)
		{
			super(model);
			this.dataStructurClass = dataStructurClass;
			
			/*setShowHorizontalLines(true);
			   setGridColor(ASColor.getASColor(255, 255, 255, 0.015));
			   setForeground(new ASColor(0xE1E2D6, 0.4));
			   setSelectionBackground(new ASColor(0XFFFFFF, 0.15));
			   setSelectionForeground(new ASColor(0xFFFFFF, 0.4));
			   getTableHeader().setPreferredHeight(17);
			   getTableHeader().setForeground(new ASColor(0xFFFFFF, 0.5));
			   getTableHeader().setMideground(new ASColor(0xFFFFFF, 0));
			   getTableHeader().setBackground(new ASColor(0X000000, 0));
			   setBackground(new ASColor(0xFFFFFF, 0.01));
			   setBackgroundChild(null);
			   setDefaultEditor("String", new DarkTableCellEditor());
			   getSelectionModel().setSelectionMode(JTable.SINGLE_SELECTION);
			   //setColumnsSize(100, 95, 52);
			   setColumnsResizable(false);
			 setScrollPaneDisabledWhenEditing(true);*/
			setNewValueGenerator(this);
		}
		
		public static var DEFAULT_VALUE_GENERATOR:Function = default_value_generator;
		
		private static function default_value_generator(dataStructurClass:Class):DataStructur
		{
			return new dataStructurClass();
		}
		
		/* INTERFACE devoron.components.tables.INewValueGenerator */
		
		public function generateNewValue():*
		{
			var dataStructur:DataStructur;
			if (DEFAULT_VALUE_GENERATOR!=null)
			{
				dataStructur = DEFAULT_VALUE_GENERATOR(dataStructurClass);
			}
			return dataStructur;
		}
		
		public override function getValueClone(value:*):*
		{
			var dataStructur:DataStructur = value as DataStructur;
			
			
			/*if (DEFAULT_VALUE_GENERATOR)
			{
				dataStructur = DEFAULT_VALUE_GENERATOR(dataStructurClass);
			}*/
			
			/*var message:MessageData = (value as MessageData).clone() as MessageData;
			 message.dataName = getNewDefaultValueName("Message");*/
			return dataStructur.clone();
		}
	
	}

}

