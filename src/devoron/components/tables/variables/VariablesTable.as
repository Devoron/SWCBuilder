package devoron.components.tables.variables
{
	import devoron.studio.plugins.modificators.ktween.AccessorsComboBoxCellEditor;
	import devoron.components.darktable.DarkTableNumberCellEditor;
	import devoron.components.tables.DSTable;
	import devoron.components.tables.INewValueGenerator;
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.event.AWEvent;
	import org.aswing.JTable;
	import org.aswing.table.DefaultTableModel;
	
	public class VariablesTable extends DSTable implements INewValueGenerator
	{
		private var ce:AccessorsComboBoxCellEditor;
		private var arrayTableModel:DefaultTableModel;
		
		public function VariablesTable(model:DefaultTableModel)
		{
			super(model);
			arrayTableModel = model;
			ce = new AccessorsComboBoxCellEditor();
			setDefaultEditor("String", ce);
			setDefaultEditor("Number", new DarkTableNumberCellEditor());
			setDefaultEditor("int", new DarkTableNumberCellEditor());
			//setDefaultEditor("Object", new DarkTableCompoundCellEditor());
			
			getSelectionModel().setSelectionMode(JTable.SINGLE_SELECTION);
			setColumnsResizable(false);
			
			// слушатель изменения значений в событий
			getModel().addTableModelListener(new ArrayTableChangeListener(this));
			
			setNewValueGenerator(this)
		}
		
		
		
		/* INTERFACE devoron.components.tables.INewValueGenerator */
		
		public function generateNewValue():* 
		{
			return ["string"];
		}
		
		public function setPropertiesObject(obj:*):void
		{
			ce.setObject(obj);
		}
		
		public override function addActionListener(listener:Function):void
		{
			addEventListener(AWEvent.ACT, listener);
		}
		
		public override function removeActionListener(listener:Function):void
		{
			removeEventListener(AWEvent.ACT, listener);
		}
		
		public function isFunctionCustom():Boolean
		{
			return false;
		}
		
		public function setFunctionCustom(custom:Boolean):void
		{
		
		}
		
		public function getValues():Array
		{
			return arrayTableModel.getData();
		}
		
		public function setValues(properties:Array):void
		{
			if (!properties)
				return;
			// проверим первое значение
			var firstData:* = properties[0];
			if (properties.length > 0)
			{
				//if ("optional" in properties[0])
					//setModel(new DefaultArgumentsTableModel(properties));
				return;
			}
			//setModel(new CustomArgumentsTableModel(properties));
		}
		
		public function addEmptyElement():void
		{
			var elements:Array = arrayTableModel.getData();
			var propertiesCount:uint = elements.push({"value": "noname", "type": "String"});
			//var propertiesCount:uint = properties.push(  {"name":"none", "from": new OneDValue(), "to": new OneDValue()} );
			
			arrayTableModel.setData(arrayTableModel.getData());
			getSelectionModel().setSelectionInterval(propertiesCount - 1, propertiesCount - 1);
		}
	
	}
}