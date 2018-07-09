package devoron.components.tables.fonts
{
	import devoron.studio.moduls.gui.components.editors.FontCellEditor;
	import devoron.components.decorators.ResizedGradientBackgroundDecorator;
	import devoron.components.tables.DSTable;
	import devoron.components.tables.INewValueGenerator;
	import devoron.components.tables.PathCellEditor;
	import devoron.values.font.ASFontValue;
	import flash.geom.Matrix;
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.border.SideLineBorder;
	import org.aswing.decorators.GradientBackgroundDecorator;
	import org.aswing.JTable;
	import org.aswing.table.DefaultTableModel;
	import org.aswing.table.GeneralTableCellFactory;
	
	public class FontsTable extends DSTable implements INewValueGenerator
	{
		protected var fontsTableModel:DefaultTableModel;
		
		public function FontsTable(fontsTableModel:DefaultTableModel = null)
		{
			//super();
			this.fontsTableModel = fontsTableModel ? fontsTableModel : new FontsTableModel();
			//this.fontsTableModel = fontsTableModel;
			setModel(fontsTableModel);
			setDefaultEditor("Path", new PathCellEditor());
			setDefaultEditor("Font", new FontCellEditor());
			//setDefaultCellFactory("Size", new GeneralTableCellFactory(FontCellRenderer));
			setDefaultCellFactory("Font", new GeneralTableCellFactory(FontsTableCellRenderer2));
			//setDefaultEditor("Color", new ColorTableCellEditor());
			
			//setDefaultEditor("Object", new DarkTableCompoundCellEditor());
			//ASFontUIResource (name:String="Tahoma", size:Number=11, bold:Boolean=false, italic:Boolean=false, underline:Boolean=false, embedFontsOrAdvancedPros:*=null)
			getSelectionModel().setSelectionMode(JTable.MULTIPLE_SELECTION);
			setColumnsResizable(false);
			
			var clr:uint = 0x000000;
			var colors:Array = [clr, clr, clr, clr, clr];
			var alphas:Array = [0.14, 0.08, 0.04, 0.02, 0.01];
			var ratios:Array = [0, 70, 145, 200, 255];
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(270, 19, 0, 0, 0);
			//super.getTableHeader().set
			var bg:ResizedGradientBackgroundDecorator = new ResizedGradientBackgroundDecorator(GradientBackgroundDecorator.LINEAR, colors, alphas, ratios, matrix, "pad", "rgb", 0, null, 0);
			//bg.setGaps(-1, 0, 4, 1); rltb
			bg.setGaps(0, 0, 0, 2);
			getTableHeader().setBackgroundDecorator(bg);
			
			getTableHeader().setBorder(new SideLineBorder(new SideLineBorder(null, SideLineBorder.WEST, new ASColor(0x000000, 0.14), 0.5), SideLineBorder.EAST, new ASColor(0x000000, 0.14), 0.5));
			
			/*super.setColumnsSize(300, 95);
			   super.setPreferredWidth(420);
			 super.setColumnsResizable(false);*/
			// слушатель изменения значений для связи ячеек: функция - аргументы
			//getModel().addTableModelListener(new OmgEbala(this));
			
			// слушатель изменения значений в событий
			//getModel().addTableModelListener(new FontsT(this));
			getModel().addTableModelListener(new FontsTableChangeListener(this));
			
			setNewValueGenerator(this);
		}
		
		public function generateNewValue():*
		{
			return {name: getNewDefaultValueName("font"), value: new ASFontValue(new ASFont())};
		}
		
		public override function getValueClone(value:*):*
		{
			return {name: getNewDefaultValueName(value.name + "_copy"), value: (value.value as ASFont).clone()};
		}
		
		public function getFonts():Array
		{
			return fontsTableModel.getData();
		}
		
		public function setFonts(fonts:Array):void
		{
			fontsTableModel.setData(fonts);
		}
		
		public function setFontsObject(fontsObject:Object):void
		{
			var fonts:Array = new Array();
			for (var lafKey:String in fontsObject)
			{
				//var propertiesCount:uint = colors.push( { "name": colorName, "value": (colorsObject[colorName].value as ASColor).getARGB() } );
				//var propertiesCount:uint = colors.push( { "name": colorName, "value": new ASColor(colorsObject[colorName],1) } );
				var propertiesCount:uint = fonts.push({"name": lafKey, "value": fontsObject[lafKey]});
			}
			
			/*for each (var item:Object in colors)
			   {
			   colorsObject[item.name] = ASColor.getWithARGB(item.value);
			   //colorsObject[item.name] = new ASColor(item.value);
			 }*/
			
			//fontsTableModel.setData(fonts);
			(super.getModel() as DefaultTableModel).setData(fonts);
		}
	
	}
}