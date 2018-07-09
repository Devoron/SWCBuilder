package devoron.components.filechooser.contentviews
{
	import devoron.file.FileInfo;
	import devoron.components.darktable.DarkTableCellEditor;
	import devoron.components.decorators.ResizedGradientBackgroundDecorator;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import org.aswing.ASColor;
	import org.aswing.AssetIcon;
	import org.aswing.border.LineBorder;
	import org.aswing.border.SideLineBorder;
	import org.aswing.colorchooser.ColorRectIcon;
	import org.aswing.Component;
	import org.aswing.decorators.ColorDecorator;
	import org.aswing.decorators.GradientBackgroundDecorator;
	import org.aswing.geom.IntDimension;
	import org.aswing.Icon;
	import org.aswing.JList;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
	import org.aswing.JTable;
	import org.aswing.table.DefaultTableModel;
	import org.aswing.table.JTableHeader;
	import org.aswing.VectorListModel;
	
	/**
	 * FIsTableForm
	 * @author Devoron
	 */
	public class FIsTableForm extends BaseFIsContentViewForm
	{
		//[Embed(source="../../../../../assets/icons/FileChooser/table_icon16.png")]
		[Embed(source="../../../../../assets/icons/commons/view_mode_table_icon20.png")]
		private const TABLE_ICON16:Class;
		
		private var filesPane:JScrollPane;
		protected var filesModel:FilesTableModel;
		protected var filesTable:JTable;
		
		public function FIsTableForm()
		{
			//super.setLayout(
			setName("Table");
			append(createIconButton(new AssetIcon(new TABLE_ICON16), "Table"));
			createFileInfosTable();
		}
		
		
		override protected function selectFile(fileName:String):void
		{
			//super.selectFile(name);
			
			var files:Array = data/*filesModel.toArray()*/;
			var file:FileInfo;
			var exists:Boolean = false;
			for each (file in files)
			{
				if (file.name == fileName)
				{
					exists = true;
					break;
				}
			}
			
			if (exists)
			{
				//filesTable.setSelectedValue(file);
			}
		
		/*while ((files[i] as FileInfo).name != name) {
		
		 }*/
		}
		
		private function selectFiles(... objects):void
		{
			//objects.length
			// распарсить все объекты по типа
			// к каждой последовательности типов должна быть привязка определённой функции
			//var types:Array = 
		}
		
		protected function createFileInfosTable():void
		{
			filesModel = new FilesTableModel(data);
			
			filesTable = new JTable(filesModel);
			filesTable.setShowHorizontalLines(false);
			filesTable.setGridColor(new ASColor(0X000000, 0.14));
			
			/**
			 * Редактирование названия файла.
			 * ВРЕМЕННО ВЫКЛЮЧЕНО
			 */
			//filesTable.setCellEditor(new FileTableCellEditor());
			
			
			//filesTable.setGridColor(ASColor.getASColor(255, 255, 255, 0.015));
			filesTable.setForeground(new ASColor(0xE1E2D6, 0.4));
			filesTable.setSelectionBackground(new ASColor(0XFFFFFF, 0.15));
			filesTable.setSelectionForeground(new ASColor(0xFFFFFF, 0.4));
			
			var header:JTableHeader = filesTable.getTableHeader();
			header.setPreferredHeight(19);
			header.setForeground(new ASColor(0xFFFFFF, 0.5));
			header.setMideground(new ASColor(0xFFFFFF, 0));
			header.setBackground(new ASColor(0X000000, 0));
			//header.setBorder(new LineBorder(
			
			var colors:Array = [0x000000, 0x000000, 0x000000, 0x000000, 0x000000];
			var alphas:Array = [0.24, 0.14, 0.08, 0.04, 0.01];
			var ratios:Array = [0, 70, 145, 200, 255];
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(270, 19, 0, 0, 0);
			//super.getTableHeader().set
			var bg:ResizedGradientBackgroundDecorator = new ResizedGradientBackgroundDecorator(GradientBackgroundDecorator.LINEAR, colors, alphas, ratios, matrix, "pad", "rgb", 0, new ASColor(0x000000, 0.14), 2);
			bg.setGaps(-1, 0, 0, 1);
			header.setBackgroundDecorator(bg);
			//filesTable.getCellPane().setBorder(new SideLineBorder(new SideLineBorder(null, SideLineBorder.WEST, new ASColor(0x000000, 0.14), 0.5), SideLineBorder.EAST, new ASColor(0x000000, 0.14), 0.5));
			
			
			/*var colors:Array = [0x000000, 0x000000, 0x000000, 0x000000, 0x000000];
			var alphas:Array = [0.24, 0.14, 0.08, 0.04, 0.01];
			var ratios:Array = [0, 70, 145, 200, 255];
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(270, 22, 0, 0, 0);
			header.setBackgroundDecorator(new GradientBackgroundDecorator(GradientBackgroundDecorator.LINEAR, colors, alphas, ratios, matrix, "pad", "rgb", 0, new ASColor(0xFFFFFF, 0), 2));
			*/
			
			filesTable.setBackground(new ASColor(0xFFFFFF, 0.01));
			filesTable.setBackgroundDecorator(new ColorDecorator(new ASColor(0, 0)));
			//filesTable.setBackgroundChild(null);
			//filesTable.setDefaultEditor("String", new DarkTableCellEditor());
			filesTable.getSelectionModel().setSelectionMode(JTable.SINGLE_SELECTION);
			//setColumnsSize(100, 95, 52);
			filesTable.setColumnsResizable(false);
			filesTable.setScrollPaneDisabledWhenEditing(true);
			
			//filesTable.addEventListener(D
			//filesList.doubleClickEnabled = true;
			//filesList.addEventListener(ListItemEvent.ITEM_DOUBLE_CLICK, onDoubleClick);
			
			filesPane = new JScrollPane(filesTable);
			filesPane.setPreferredHeight(300);
			filesPane.setSize(new IntDimension(490, 300));
			filesPane.setMinimumSize(new IntDimension(490, 300));
			filesPane.setPreferredSize(new IntDimension(490, 300));
			filesPane.setVerticalScrollBarPolicy(JScrollPane.SCROLLBAR_ALWAYS);
			//filesPane.setHorizontalScrollBarPolicy(JScrollPane.SCROLLBAR_AS_NEEDED);
			filesPane.setHorizontalScrollBarPolicy(JScrollPane.SCROLLBAR_ALWAYS);
			//filesPane.buttonMode = true;
			filesPane.doubleClickEnabled = true;
			filesPane.addEventListener(MouseEvent.DOUBLE_CLICK, onDouble);
			
		}
		
		private function onDouble(e:MouseEvent):void 
		{
			var selId:int = filesTable.getSelectedRow();
			if (selId == -1)
				return;
			
			// выбранная структура данных
			trace(filesModel.getData()[selId]);
			
		}
		
		/*private function onDoubleClick(e:ListItemEvent):void
		{
			dispatchEvent(new FIContentViewEvent(FIContentViewEvent.ITEM_DOUBLE_CLICK, e.getValue(), e));
		}*/
		
		
		override public function setData(dataArray:Array):void 
		{
			data = dataArray;
			filesModel.setData(data);
			filesTable.updateUI();
		}
		
		override public function getViewFIComponent():Component
		{
			return filesPane;
		}
		
		override public function setFilesModel(model:VectorListModel):void
		{
			//super.setFilesModel(model);
			/*filesTable.setModel(model);
			filesTable.updateListView();*/
		}
		
		override public function getSelectedValue():*
		{
			var selId:int = filesTable.getSelectedRow();
			if (selId == -1)
				return;
			
			// выбранная структура данных
			return filesModel.getData()[selId];
			//filesTable.getse
			//filesTable.getS
			//return filesTable.getSelectedValue();
			//return filesTable.getSelectionModel().get
		}
	
	}

}