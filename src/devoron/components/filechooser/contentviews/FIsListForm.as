package devoron.components.filechooser.contentviews
{
	import devoron.components.filechooser.renderers.FileCellRenderer;
	import devoron.file.FileInfo;
	import org.aswing.AssetIcon;
	import org.aswing.Component;
	import org.aswing.event.ListItemEvent;
	import org.aswing.GeneralListCellFactory;
	import org.aswing.geom.IntDimension;
	import org.aswing.JList;
	import org.aswing.JScrollPane;
	import org.aswing.VectorListModel;
	
	/**
	 * FIsListForm
	 * @author Devoron
	 */
	public class FIsListForm extends BaseFIsContentViewForm
	{
		//[Embed(source="../../../../../assets/icons/FileChooser/list_icon16.png")]
		[Embed(source="../../../../../assets/icons/commons/view_mode_list_icon20.png")]
		private var LIST_ICON16:Class;
		private var filesPane:JScrollPane;
		protected var filesModel:VectorListModel;
		protected var filesList:JList;
		
		public function FIsListForm()
		{
			setName("List");
			append(createIconButton(new AssetIcon(new LIST_ICON16), "List"));
			createFileInfosList();
		
			//setConsoleComands({"selectFiles",getUserByName
		}
		
		override public function clear():void
		{
			(filesList.getModel() as VectorListModel).clear();
		}
		
		override public function setData(dataArray:Array):void
		{
			data = dataArray;
			filesModel.clear();
			filesModel.appendAll(dataArray);
		}
		
		override public function getData():Array
		{
			return filesModel.toArray();
		}
		
		override public function getViewFIComponent():Component
		{
			return filesPane;
		}
		
		override protected function selectFile(fileName:String):void
		{
			//super.selectFile(name);
			
			var files:Array = filesModel.toArray();
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
				filesList.setSelectedValue(file);
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
		
		protected function createFileInfosList():void
		{
			filesModel = new VectorListModel();
			
			filesList = new JList(filesModel, new GeneralListCellFactory(FileCellRenderer, true, true, 41));
			//filesList = new GridList(filesModel, new GeneralGridListCellFactory(FileCellRenderer), 4, 8);
			//filesList.setL
			//filesList.setVisibleRowCount(0);
			//filesList.getLayout
			//filesList.setLayout(
			//list.setLayoutOrientation(JList.HORIZONTAL_WRAP);
			
			filesList.doubleClickEnabled = true;
			filesList.addEventListener(ListItemEvent.ITEM_DOUBLE_CLICK, onDoubleClick);
			//filesList.setD
			//filesList.setPreferredCellWidthWhenNoCount(280);
			//filesList.setPreferredCellWidthWhenNoCount(80);
			//filesList.addSelectionListener(filesListSelectionHandler);
			filesList.setSelectionMode(JList.SINGLE_SELECTION);
			
			filesPane = new JScrollPane(filesList);
			filesPane.setPreferredHeight(300);
			filesPane.setSize(new IntDimension(490, 300));
			filesPane.setMinimumSize(new IntDimension(490, 300));
			filesPane.setPreferredSize(new IntDimension(490, 300));
			filesPane.setVerticalScrollBarPolicy(JScrollPane.SCROLLBAR_ALWAYS);
			//filesPane.setHorizontalScrollBarPolicy(JScrollPane.SCROLLBAR_AS_NEEDED);
			filesPane.setHorizontalScrollBarPolicy(JScrollPane.SCROLLBAR_ALWAYS);
			//filesPane.buttonMode = true;
		}
		
		private function onDoubleClick(e:ListItemEvent):void
		{
			dispatchEvent(new FIContentViewEvent(FIContentViewEvent.ITEM_DOUBLE_CLICK, e.getValue(), e));
		}
		
		override public function setFilesModel(model:VectorListModel):void
		{
			//super.setFilesModel(model);
			filesList.setModel(model);
			filesList.updateListView();
		}
		
		override public function getSelectedValue():*
		{
			return filesList.getSelectedValue();
		}
	
	}

}