package devoron.aslc.moduls.libraries
{
	//import devoron.studio.plugins.modificators.ktween.AccessorsComboBoxCellEditor;
	import devoron.components.darktable.DarkTableNumberCellEditor;
	import devoron.components.tables.DSTable;
	import devoron.components.tables.INewValueGenerator;
	import flash.geom.Matrix;
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.decorators.GradientBackgroundDecorator;
	import org.aswing.event.AWEvent;
	import org.aswing.event.TableModelEvent;
	import org.aswing.JTable;
	import org.aswing.table.DefaultTableModel;
	import org.aswing.table.GeneralTableCellFactory;
	import org.aswing.table.JTableHeader;
	
	public class IncludedClassesTable extends DSTable implements INewValueGenerator
	{
		//private var ce:AccessorsComboBoxCellEditor;
		private var arrayTableModel:DefaultTableModel;
		
		public function IncludedClassesTable(model:DefaultTableModel)
		{
			super(model);
			arrayTableModel = model;
			columnSizes = [60, 630, 105, 200];
			//ce = new AccessorsComboBoxCellEditor();
			//setDefaultEditor("String", ce);
			setDefaultEditor("Number", new DarkTableNumberCellEditor());
			setDefaultEditor("int", new DarkTableNumberCellEditor());
			//setDefaultEditor("Object", new DarkTableCompoundCellEditor());
			setDefaultCellFactory("Value", new GeneralTableCellFactory(IncludeClassControlCell));
			
			getSelectionModel().setSelectionMode(JTable.SINGLE_SELECTION);
			setColumnsResizable(false);
			
			// слушатель изменения значений в событий
			//getModel().addTableModelListener(new ArrayTableChangeListener(this));
			
			setNewValueGenerator(this)
			
			var header:JTableHeader = getTableHeader();
			
			var colors:Array = [0x000000, 0x000000, 0x000000, 0x000000, 0x000000];
			var alphas:Array = [0.24, 0.14, 0.08, 0.04, 0.01];
			var ratios:Array = [0, 70, 145, 200, 255];
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(270, 22, 0, 0, 0);
			header.setBackgroundDecorator(new GradientBackgroundDecorator(GradientBackgroundDecorator.LINEAR, colors, alphas, ratios, matrix, "pad", "rgb", 0, new ASColor(0xFFFFFF, 0), 2));
			
		}
		
		
		
		/* INTERFACE devoron.components.tables.INewValueGenerator */
		
		public function generateNewValue():* 
		{
			return ["string"];
		}
		
		public function setPropertiesObject(obj:*):void
		{
			//ce.setObject(obj);
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
		
		public override function tableChanged(e:TableModelEvent):void
		{
			super.tableChanged(e);
			setColumnsSizes(columnSizes);
		}
	
	}
}