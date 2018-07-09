package devoron.components.tables.colors
{
	import devoron.components.darktable.DarkTableCellEditor;
	import devoron.components.darktable.DarkTableNumberCellEditor;
	import devoron.components.decorators.ResizedGradientBackgroundDecorator;
	import devoron.components.tables.DSTable;
	import devoron.components.tables.INewValueGenerator;
	import devoron.components.values.color.ColorTableCellEditor;
	import devoron.components.values.color.ColorTableCellRenderer;
	import flash.geom.Matrix;
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.border.SideLineBorder;
	import org.aswing.decorators.GradientBackgroundDecorator;
	import org.aswing.event.AWEvent;
	import org.aswing.JTable;
	import org.aswing.table.GeneralTableCellFactory;
	
	public class ColorsTable extends DSTable implements INewValueGenerator
	{
		private var colorsTableModel:ColorsTableModel= new ColorsTableModel();
		
		public function ColorsTable()
		{
			super.setDefaultEditor("String", new DarkTableCellEditor());
			super.setDefaultEditor("Color", new ColorTableCellEditor());
			setDefaultCellFactory("Color", new GeneralTableCellFactory(ColorTableCellRenderer));
			super.getSelectionModel().setSelectionMode(JTable.SINGLE_SELECTION);
			//super.setColumnsSize(300, 95);
			//super.setPreferredWidth(420);
			super.setColumnsResizable(false);
			super.setModel(colorsTableModel);
			
			var clr:uint = 0x000000;
			var colors:Array = [clr, clr, clr, clr, clr];
			var alphas:Array = [0.14, 0.08, 0.04, 0.02, 0.01];
			var ratios:Array = [0, 70, 145, 200, 255];
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(270, 19, 0, 0, 0);
			//super.getTableHeader().set
			var bg:ResizedGradientBackgroundDecorator = new ResizedGradientBackgroundDecorator(GradientBackgroundDecorator.LINEAR, colors, alphas, ratios, matrix, "pad", "rgb", 0, null, 0);
			//bg.setGaps(-1, 0, 4, 1); rltb
			bg.setGaps( 0, 0, 0, 2);
			getTableHeader().setBackgroundDecorator(bg);
			
			
			getTableHeader().setBorder(new SideLineBorder(new SideLineBorder(null, SideLineBorder.WEST, new ASColor(0x000000, 0.14), 0.5), SideLineBorder.EAST, new ASColor(0x000000, 0.14), 0.5));
			
			/*var font:ASFont = super.getTableHeader().getFont();
			font = font.changeName("Tahoma");
			font = font.changeSize(11);
			super.getTableHeader().setFont(font);*/
			//gtrace(super.getTableHeader().getFont());
			
			// слушатель изменения значений в событий
			getModel().addTableModelListener(new ColorsTableChangeListener(this));
			setNewValueGenerator(this);
		}
		
		public override function getValueClone(value:*):*{
			return {name:getNewDefaultValueName(value.name+"_copy"), value:(value.value as ASColor).clone()};
		}
		
		public function generateNewValue():*
		{
			return {name:getNewDefaultValueName("color"), value:new ASColor()};
		}
		
		public function setPropertiesObject(obj:*):void
		{
			//ce.setObject(obj);
		}
		
		
		public function getColorsObject():Object {
			var colorsObject:Object = new Object();
			var colors:Array = colorsTableModel.getData();
			for each (var item:Object in colors) 
			{
				colorsObject[item.name] = ASColor.getWithARGB(item.value);
				//colorsObject[item.name] = new ASColor(item.value);
			}
			//for (var colorName:String in colorsObject)
			//var propertiesCount:uint = colors.push( { "name": colorName, "value": colorsObject[colorName] } );
			//colorsTableModel.setData(colorsTableModel.getData());
			//getSelectionModel().setSelectionInterval(propertiesCount - 1, propertiesCount - 1);
			
			return colorsObject;
		}
		
		public function setColorsObject(colorsObject:Object):void {
			var colors:Array = new Array();
			for (var colorName:String in colorsObject) {
				//var propertiesCount:uint = colors.push( { "name": colorName, "value": (colorsObject[colorName].value as ASColor).getARGB() } );
				var propertiesCount:uint = colors.push( { name: colorName, value: new ASColor(colorsObject[colorName],1) } );
				//var propertiesCount:uint = colors.push( { "name": colorName, "value": colorsObject[colorName]} );
			}
			colorsTableModel.setData(colors);
			//getSelectionModel().setSelectionInterval(propertiesCount - 1, propertiesCount - 1);
		}
		
		public function getColors():Array
		{
		/*	var data:Array = [];
			var baseData
			for (var i:int = 0; i < getData().length; i++) 
			{
				data.push(
			}*/
			
			return colorsTableModel.getData();
		}
		
		public function setColors(properties:Array):void
		{
			colorsTableModel.setData(properties);
		}
		
		
	
	}
}