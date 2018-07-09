package devoron.components.filechooser
{
	import com.adobe.utils.ArrayUtil;
	import devoron.components.buttons.DSButton;
	import devoron.components.buttons.DSTextField;
	import devoron.components.comboboxes.AutocompleteComboBoxEditor;
	import devoron.components.comboboxes.CellFact;
	import devoron.components.comboboxes.DSComboBox;
	import devoron.components.comboboxes.TextCBUI;
	import devoron.components.filechooser.autocomplete.AutocompleteManager;
	import devoron.components.filechooser.contentviews.IContentView;
	import devoron.components.filechooser.ImageFCH;
	import devoron.components.filechooser.renderers.RootDirectoryCellRenderer;
	import devoron.components.frames.StudioFrame;
	import devoron.components.hidebuttons.HideButtonPanel;
	import devoron.components.labels.DSLabel;
	import devoron.components.searchfields.SearchPanel;
	import devoron.file.FileInfo;
	import devoron.file.NATIVE;
	import devoron.utils.airmediator.AirMediator;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.events.StatusEvent;
	import flash.events.TextEvent;
	import flash.net.SharedObject;
	import flash.net.URLRequest;
	import org.aswing.ASColor;
	import org.aswing.AssetIcon;
	import org.aswing.border.EmptyBorder;
	import org.aswing.border.SideLineBorder;
	import org.aswing.Component;
	import org.aswing.event.AWEvent;
	import org.aswing.event.ResizedEvent;
	import org.aswing.event.SelectionEvent;
	import org.aswing.ext.Form;
	import org.aswing.ext.FormRow;
	import org.aswing.ext.GridList;
	import org.aswing.ext.GridListItemEvent;
	import org.aswing.GeneralListCellFactory;
	import org.aswing.geom.IntDimension;
	import org.aswing.Icon;
	import org.aswing.Insets;
	import org.aswing.JButton;
	import org.aswing.JDropDownButton;
	import org.aswing.JFrame;
	import org.aswing.JList;
	import org.aswing.JOptionPane;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
	import org.aswing.JTextField;
	import org.aswing.util.autocomplete.AutocompleteDictionary;
	import org.aswing.util.HashMap;
	import org.aswing.VectorListModel;
	//import MAINS.other.editors.Main_PRICE2000;
	//import devoron.components.filechooser.fchs.AwdFCH;
	//import devoron.components.console.dconsole2.core.text.autocomplete.AutocompleteDictionary;
	//import devoron.components.console.dconsole2.core.text.autocomplete.AutocompleteManager;
	//import devoron.components.filechooser.fchs.AtfFCH;
	//import devoron.components.filechooser.fchs.AwdFCH;
	//import devoron.components.filechooser.fchs.ImageFCH;
	//import devoron.components.filechooser.fchs.AudioFCH;
	//import devoron.components.filechooser.fchs.ImageFCH;
	
	[Event(name="act",type="org.aswing.event.AWEvent")]
	
	/**
	 * Dispatched when the user selects a file for upload or download from the file-browsing dialog box.
	 * @eventType	flash.events.Event.SELECT
	 */
	[Event(name="select",type="flash.events.Event")]
	
	/**
	 * Dispatched when a file upload or download is canceled through the file-browsing dialog
	 * box by the user.
	 * @eventType	flash.events.Event.CANCEL
	 */
	[Event(name="cancel",type="flash.events.Event")]
	
	/**
	 * FileChooser
	 * @author Devoron
	 */
	public class FileChooser extends EventDispatcher
	{
		public static const DIRECTORIES_ONLY:String = "directories_only";
		public static const FILES_AND_DIRECTORIES:String = "files_and_directories";
		public static const FILES_ONLY:String = "files_only";
		
		[Embed(source="../../../../assets/icons/managers/FileChooser/warning_icon20.png")]
		private static const WARNING_ICON:Class;
		
		[Embed(source="../../../../assets/icons/managers/FileChooser/info_icon20.png")]
		private const INFO_ICON:Class;
		
		[Embed(source="../../../../assets/icons/managers/FileChooser/new_folder_icon16.png")]
		private const NEW_FOLDER_ICON:Class
		
		[Embed(source="../../../../assets/icons/managers/FileChooser/rename_icon16.png")]
		private const RENAME_ICON:Class;
		
		[Embed(source="../../../../assets/icons/managers/FileChooser/search_icon16.png")]
		private const SEARCH_ICON:Class;
		
		[Embed(source="../../../../assets/icons/commons/folder_icon16.png")]
		private const SELECT_FILE_ICON:Class;
		
		[Embed(source="../../../../assets/icons/managers/FileChooser/trash_icon16.png")]
		private const TRASH_ICON:Class;
		
		[Embed(source="../../../../assets/icons/managers/FileChooser/up_folder_icon16.png")]
		private const UP_FOLDER_ICON:Class;
		
		[Embed(source="../../../../assets/icons/managers/FileChooser/assets_manager_icon16.png")]
		private const ARRAY_EDITOR_ICON16:Class;
		
		/*private const INFO_ICON:String = "../assets/icons/managers/FileChooser/info_icon20.png";
		   private const WARNING_ICON:String = "../assets/icons/managers/FileChooser/warning_icon20.png";
		   private const SELECT_FILE_ICON:String = ".../assets/icons/managers/FileChooser//select_file_icon16.png";
		   private const TRASH_ICON:String = "../assets/icons/managers/FileChooser/trash_icon16.png";
		   private const NEW_FOLDER_ICON:String = "../assets/icons/managers/FileChooser/new_folder_icon16.png";
		   private const UP_FOLDER_ICON:String = "../assets/icons/managers/FileChooser/up_folder_icon16.png";
		   private const RENAME_ICON:String = "../assets/icons/managers/FileChooser/rename_icon16.png";
		   private const SEARCH_ICON:String = "../assets/icons/managers/FileChooser/search_icon16.png";
		 */
		
		
		public static var helpers:Array;
		public static var typesAndHelpers:HashMap = new HashMap();
		public static var cachedPreview:HashMap = new HashMap();
		public static var cachedPreviewByDate:HashMap = new HashMap();
		
		private var selectionMode:String = "files_and_directories";
		
		protected var filesModel:VectorListModel;
		//protected var filesList:JList;
		protected var filesList:GridList;
		protected var filesPane:JScrollPane;
		
		protected var rootDirectoriesModel:VectorListModel;
		protected var rootDirectoriesList:JList;
		protected var rootDirectoriesPane:JScrollPane;
		
		protected var componentsForm:Form;
		protected var useFileChooserHelper:Boolean;
		protected var dialogFrame:JFrame;
		protected var dialogForm:Form;
		
		protected var _okBtnText:String = "Ok";
		protected var _cancelBtnText:String = "Cancel";
		protected var fileChooserHelpersForm:FileChooserHelpersForm;
		private var viewModesForm:ViewModesForm;
		
		private var first:Boolean = true;
		private var contentViewComponent:Component;
		private var contentView:IContentView;
		private var filteredFiles:Array = [];
		private var autocompleteManager:AutocompleteManager;
		
		private var directoriesPanel:JPanel;
		
		private const CAMERA_EDITOR_ICON:String = "../assets/icons/camera_editor_icon20.png";
		private var pathTF:JTextField;
		private var searchTF:JTextField;
		
		/**
		 * ВРЕМЕННОЕ
		 */
		//private var lastFolderPath:String = "C:\\Users\\Devoron\\Desktop";
		private var lastFolderPath:String = "F:\\Projects\\projects\\flash\\Wheater\\bin";
		private var lastFolderAtShown:Boolean = true;
		
		protected var fileChooserSO:SharedObject;
		
		public var currentMode:Namespace;
		
		public static var STAGE:Stage;
		
		public function FileChooser(title:String = "Open file dialog", useFileChooserHelper:Boolean = true)
		{
			//if (CONFIG::air)
			//{
			currentMode = NATIVE;
			/*}
			   else {
			   currentMode = LOC;
			 }*/
			
			this.useFileChooserHelper = useFileChooserHelper;
			helpers = [/*new ImageFCH()*/ /*, new AudioFCH(), new GifFCH(), new FontFCH2(), new AS3FCH()*/ /*new AwdFCH()*/ /*new AtfFCH()*/];
			//typesAndHelpers.put("as", 
			
			fileChooserHelpersForm = new FileChooserHelpersForm();
			fileChooserHelpersForm.registerHelpers(helpers);
			
			viewModesForm = new ViewModesForm();
			viewModesForm.addEventListener(Event.CHANGE, viewModeChangeHandler);
			filesModel = new VectorListModel();
			
			fileChooserSO = SharedObject.getLocal("FileChooser");
			
			dialogFrame = new StudioFrame();
			dialogFrame.setMinimumSize(new IntDimension(770, 300));
			//dialogFrame.filters = [new DropShadowFilter(4, 45, 0x000000, 0.14, 4, 4, 0.5, 2)];
			
			//(dialogFrame.getTitleBar() as JFrameTitleBar).setClosableOnly(true);
			//dialogFrame.setBackground(new ASColor(0X0E1012, 1));
			dialogFrame.setTitle(title);
			dialogFrame.setIcon(new AssetIcon(new SELECT_FILE_ICON));
			//dialogFrame.setMinimumSize(new IntDimension(770, 300));
			//dialogFrame.setMaximumWidth(770);
			
			/*var cd:ColorDecorator = new ColorDecorator(new ASColor(0x262F2B, 1), new ASColor(0XFFFFFF, 0.24), 4);
			   cd.setGaps(-2, 1, 1, -2);
			 dialogFrame.setBackgroundDecorator(cd);*/
			
			//dialogFrame.setBackgroundDecorator(new ColorBackgroundDecorator(new ASColor(0x262F2B, 1), new ASColor(0xFFFFFF, 0.4)));
			
			var panePanel:JPanel = new JPanel();
			panePanel.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 5)));
			//panePanel.setLayout(new BorderLayout(10, 2));
			//panePanel.setSizeWH(730, 430);
			dialogFrame.setContentPane(panePanel);
			
			componentsForm = new Form();
			//form.setSizeWH(730, 430);
			componentsForm.setVisible(true);
			panePanel.append(componentsForm);
			
			createRootDirectoriesList();
			//createDirectoryContentList();
			
			directoriesPanel = new JPanel();
			directoriesPanel.setBorder(new EmptyBorder(null, new Insets(0, -4, 0, 0)));
			//directoriesPanel.setBackgroundDecorator(new ColorDecorator(new ASColor(0x8000FF, 0.2)));
			directoriesPanel.setSize(new IntDimension(525, 300));
			directoriesPanel.setMinimumSize(new IntDimension(525, 300));
			createControlElements();
			
			var centerForm:Form = new Form();
			centerForm.setBorder(null);
			//centerForm.setBackgroundDecorator(new ColorDecorator(new ASColor(0x80FF00, 0.4)));
			centerForm.addLeftHoldRow(0, directoriesPanel);
			viewModeChangeHandler(null);
			createControlElementsBottom(centerForm);
			
			var hbp:HideButtonPanel = new HideButtonPanel("right", rootDirectoriesPane, panePanel);
			hbp.hideBtn.addActionListener(onHbpBtn);
			hbp.setPreferredWidth(10);
			componentsForm.addLeftHoldRow(0, hbp, rootDirectoriesPane, centerForm);
			
			dialogFrame.pack();
			dialogFrame.addEventListener(AWEvent.SHOWN, onShown);
			dialogFrame.addEventListener(ResizedEvent.RESIZED, onResized);
		}
		
		private function onHbpBtn(e:AWEvent):void
		{
			if (rootDirectoriesPane.isVisible())
			{
				pathTF.setPreferredWidth(375);
				searchTF.setPreferredWidth(150);
				dialogFrame.setMinimumSize(new IntDimension(1000, 300));
				dialogFrame.setPreferredWidth(1000);
			}
			else
			{
				pathTF.setPreferredWidth(262);
				searchTF.setPreferredWidth(90);
				dialogFrame.setMinimumSize(new IntDimension(1000, 300));
				dialogFrame.setPreferredWidth(1000);
			}
			pathTF.revalidate();
			searchTF.revalidate();
			
			directoriesPanel.setPreferredWidth(525);
			directoriesPanel.revalidate();
			
			dialogFrame.pack();
		}
		
		private function viewModeChangeHandler(e:Event):void
		{
			// удалить прежний рендерер, отображающий контент
			if (directoriesPanel.getComponentCount() > 0)
				directoriesPanel.removeAt(0);
			// получить новый 
			contentViewComponent = viewModesForm.getViewFIComponent();
			contentViewComponent.setPreferredSize(directoriesPanel.getSize());
			contentViewComponent.revalidate();
			
			//(contentViewComponent as IContentView)
			directoriesPanel.append(contentViewComponent);
			directoriesPanel.repaintAndRevalidate();
			// установить модель в компонент
			//(contentViewComponent as IContentView).setFilesModel(filesModel);
			contentView = viewModesForm.getContentView();
			//contentView.setFilesModel(filesModel);
			contentView.setData(filteredFiles);
		
		}
		
		private function onResized(e:ResizedEvent):void
		{
			var delte:IntDimension = e.getNewSize().decreaseSize(e.getOldSize());
			var size:IntDimension = rootDirectoriesPane.getSize();
			size.increaseSize(delte);
			rootDirectoriesPane.setPreferredHeight(size.height);
			size = directoriesPanel.getSize();
			directoriesPanel.setPreferredSize(size.increaseSize(delte));
			size = contentViewComponent.getSize();
			contentViewComponent.setPreferredSize(size.increaseSize(delte));
			rootDirectoriesPane.revalidate();
			directoriesPanel.revalidate();
			contentViewComponent.revalidate();
		}
		
		public function getHelper(extension:String):FileChooserHelper
		{
			//var helpers:
			return null;
		}
		
		public function addActionListener(listener:Function):void
		{
			super.addEventListener(AWEvent.ACT, listener);
		}
		
		public function removeActionListener(listener:Function):void
		{
			super.removeEventListener(AWEvent.ACT, listener);
		}
		
		private var currentDirectory:FileInfo;
		
		private function onFiles(directory:FileInfo):void
		{
			// если директории не существует, то установить WarningIcon в PathField
			if (!directory.exists)
			{
				return;
			}
			//if (!directory.exists){
			
			//warningLabel.x = pathTF.getWidth() - 24;
			//var bd:BitmapData = new BitmapData(55, 11, false, value);
			/*var ct:ColorTransform = new ColorTransform();
			   ct.alphaOffset = -200;
			 bd.colorTransform(new Rectangle(0, 0, 55, 11), ct);*/
			//var icon:AssetIcon = new AssetIcon(new Bitmap(bd), 55, 11);
			
			//warningLabel.set
			//warningLabel.setVisible(true);
			
			/*	return;
			   }
			   else{
			   if(warningLabel){
			   if (warningLabel.isVisible()){
			   warningLabel.setVisible(false);
			   //pathTF.removeChild(warningLabel);
			   }
			   }
			 }*/
			
			// установить выбранную директорию в AutocompleteManager,
			// чтобы сразу получить содержимое этой директории
			//gtrace(directory.directoryListing);
			
			// нужно пройти по всему содержимому папки и если файл является папкой, то предложить в путь
			//am.setDictionary(
			
			var dict:AutocompleteDictionary = new AutocompleteDictionary();
			for each (var file:FileInfo in directory.directoryListing)
			{
				dict.addToDictionary(file.name);
			}
			
			autocompleteManager.setDictionary(dict);
			//cachedPreview.clear();
			//gtrace(directory);
			
			currentDirectory = directory;
			if (directory.nativePath.length)
				pathTF.setHtmlText(pathToHTML(directory.nativePath));
			
			filesModel.clear();
			
			var files:Array = directory.directoryListing;
			filteredFiles = new Array();
			var fi:FileInfo;
			var isSupported:Boolean = false;
			
			// только директории
			if (selectionMode == DIRECTORIES_ONLY)
			{
				for (var i:int = 0; i < files.length; i++)
				{
					fi = files[i] as FileInfo;
					if (fi.isDirectory)
						//filesModel.append(fi);
						filteredFiles.push(fi);
				}
			}
			
			// только файлы или файлы и директории
			if ((selectionMode == FILES_ONLY) || (selectionMode == FILES_AND_DIRECTORIES))
			{
				// с учётом расширений
				if (extensions)
				{
					for (var k:int = 0; k < files.length; k++)
					{
						fi = files[k] as FileInfo;
						
						if (fi.extension == null /*&& selectionMode!=FILES_ONLY*/)
						{
							//filesModel.append(fi);
							filteredFiles.push(fi);
						}
						else
						{
							for each (var item:String in extensions)
							{
								// у папок extension = null
								if ((fi.extension.toLowerCase() == item) || (fi.extension.toUpperCase() == item))
								{
									//filesModel.append(fi);
									filteredFiles.push(fi);
									break;
								}
							}
						}
						
					}
				}
				// без учёта расширений
				else
				{
					for (var n:int = 0; n < files.length; n++)
					{
						//filesModel.append(files[n] as FileInfo);
						filteredFiles.push(files[n] as FileInfo);
					}
				}
			}
			searched = false;
			//viewModesForm.getContentView().setFilesModel(filesModel);
			viewModesForm.getContentView().setData(filteredFiles);
		}
		
		private function pathToHTML(nativePath:String):String
		{
			var folderNames:Array = nativePath.split("\\");
			if (folderNames[folderNames.length - 1] == "")
				folderNames.pop();
			var folderName:String;
			var htmlPath:String = "";
			for (var i:uint = 0; i < folderNames.length; i++)
			{
				htmlPath += '<a href=' + qutes("event:" + concatFromTo(0, i, folderNames)) + '>' + folderNames[i] + '</a>';
				htmlPath += "\\";
			}
			//gtrace("htlm" + htmlPath);
			// <a href="event:имя_кликнутой_папки">имя_папки_клика</a>
			
			htmlPath = htmlPath.substring(0, htmlPath.length - 2);
			//gtrace("htlm" + htmlPath);
			
			return htmlPath;
		}
		
		private function concatFromTo(startIndex:uint, endIndex:uint, arr:Array):String
		{
			var result:String = "";
			for (var i:int = startIndex; i <= endIndex; i++)
			{
				result += arr[i];
				result += "\\";
			}
			result = result.substring(0, result.length - 1);
			return result;
		}
		
		private function qutes(str:String):String
		{
			return '"' + str + '"';
		}
		
		/**
		 * Двойной клик в списке файлов.
		 * @param	e
		 */
		private function onDoubleClick(e:GridListItemEvent):void
		{
			var fi:FileInfo = FileInfo(e.getValue());
			
			// если директория, то нужно её открыть
			if (fi.isDirectory)
			{
				AirMediator.getDirectory(fi.nativePath, onFiles, false, errorHandler);
			}
			// если выбираемый тип - файлы или файлы и директории, то выбор сделан
			else if (selectionMode == FILES_ONLY || selectionMode == FILES_AND_DIRECTORIES)
			{
				lastFolderPath = fi.parentPath;
				fileChooserSO.data.lastFolderPath = lastFolderPath;
				fileChooserSO.flush();
				fileChooserSO.flush();
				
				dispatchEvent(new AWEvent(AWEvent.ACT));
				dialogFrame.setVisible(false);
			}
		}
		
		protected function filesListSelectionHandler(e:SelectionEvent):void
		{
			//var fi:FileInfo = filesList.getSelectedValue();
			var fi:FileInfo = (contentViewComponent as IContentView).getSelectedValue();
			if (fi == null)
				return;
			filenameTF.setText(fi.name);
		}
		
		public function isFileChooserHelperSupported():Boolean
		{
			return useFileChooserHelper;
		}
		
		public function setFileChooserSuppoted(b:Boolean):void
		{
			useFileChooserHelper = b;
		}
		
		public function setFileChooserHelper(fch:FileChooserHelper):void
		{
		
		}
		
		public function getFileChooserHelper():FileChooserHelper
		{
			return null;
		}
		
		private function renameTo(newName:String):void
		{
			if (newName == null || newName == "" || newName == "null")
				return;
			
			var fi:FileInfo = getFileInfo();
			AirMediator.moveTo(fi.nativePath, fi.parentPath + "\\" + newName, false, onRenamed, errorHandler);
		}
		
		//**************************************************** ♪ ОБРАБОТЧИКИ СОБЫТИЙ ***************************************		
		
		private function cancelBtnBtnHandler(e:AWEvent):void
		{
			dialogFrame.setVisible(false);
		}
		
		private var selectedFI:FileInfo;
		
		private function okBtnHandler(e:AWEvent):void
		{
			var fi:FileInfo = viewModesForm.getContentView().getSelectedValue();
			if (fi == null)
				return;
			
			if (selectionMode == DIRECTORIES_ONLY && !fi.isDirectory)
				return;
			
			if (selectionMode == FILES_ONLY && fi.isDirectory)
				return;
			
			lastFolderPath = fi.parentPath;
			fileChooserSO.data.lastFolderPath = lastFolderPath;
			fileChooserSO.flush();
			
			selectedFI = fi;
			
			dispatchEvent(new AWEvent(AWEvent.ACT));
			dialogFrame.setVisible(false);
		}
		
		private function onPathChange(e:AWEvent):void
		{
			var path:String = pathTF.getText();
			if (path == "" || path.length < 2)
				return;
			AirMediator.getDirectory(path, onFiles, false, errorHandler);
		}
		
		private function onMoveToTrash(removedFileInfo:FileInfo):void
		{
			var files:Array = filesModel.toArray();
			var l:uint = files.length;
			var id:int = -1;
			for (var i:int = 0; i < l; i++)
			{
				if ((files[i] as FileInfo).nativePath == removedFileInfo.nativePath)
				{
					id = i;
					break;
				}
			}
			if (id != -1)
			{
				filesModel.removeAt(id);
				searched = false;
			}
		}
		
		private function rootDirectoriesListSelectionHandler(e:SelectionEvent):void
		{
			var selId:int = rootDirectoriesList.getSelectedIndex();
			if (selId == -1)
				return;
			
			var path:String = FileInfo(rootDirectoriesModel.get(selId)).nativePath;
			AirMediator.getDirectory(path, onFiles, false, errorHandler);
		}
		
		private function onShown(e:AWEvent):void
		{
			
			/*if (!AirMediator.nativeMode::isConnected())
			   {
			   AirMediator.nativeMode::addConnectListener(onConnectToAirMediator);
			   dialogFrame.addEventListener(AWEvent.HIDDEN, onHidden);
			   return;
			 }*/
			
			//****************************************************************************************************************************************
			//****************************************************************************************************************************************
			//*************************	ВНИМАНИЕ. СЕЙЧАС FILE CHOOSER СВЯЗЫВАЕТСЯ ЧЕРЕЗ AIR MEDIATOR ПО LOCAL CONNECTION, ********************************
			//************************* НО НЕОБХОДИМО ПРЕДУСМОТРЕТЬ ВАРИАНТ, КОГДА ОН ДЕЛАЕТ ЭТО ПО FTP ИЛИ СОКЕТАМ. ***********************************
			//****************************************************************************************************************************************
			//****************************************************************************************************************************************
			//****************************************************************************************************************************************
			//****************************************************************************************************************************************
			//****************************************************************************************************************************************
			//****************************************************************************************************************************************
			
			rootDirectoriesModel.clear();
			filesModel.clear();
			
			AirMediator.getDesktopDirectory(onDirectory);
			AirMediator.getUserDirectory(onDirectory);
			AirMediator.getDocumentsDirectory(onDirectory);
			AirMediator.getRootDirectories(onRootDirectories);
			
			if (lastFolderAtShown)
			{
				if (lastFolderPath)
				{
					AirMediator.getDirectory(lastFolderPath, onFiles, false, errorHandler);
				}
				else
				{
					if (fileChooserSO.data.lastFolderPath != undefined)
					{
						lastFolderPath = fileChooserSO.data.lastFolderPath;
						AirMediator.getDirectory(lastFolderPath, onFiles, false, errorHandler);
					}
				}
			}
		}
		
		private function onHidden(e:AWEvent):void
		{
			AirMediator.removeConnectListener(onConnectToAirMediator);
		}
		
		private function onConnectToAirMediator(e:StatusEvent):void
		{
			AirMediator.removeConnectListener(onConnectToAirMediator);
			dialogFrame.removeEventListener(AWEvent.HIDDEN, onHidden);
		}
		
		private function onDirectory(directory:FileInfo):void
		{
			rootDirectoriesModel.append(directory);
		}
		
		private function onRootDirectories(directories:Array):void
		{
			rootDirectoriesModel.appendAll(directories);
			//rootDirectoriesList.setSelectedIndex(directories.length - 1);
			//rootDirectoriesListSelectionHandler(null);
		}
		
		private function errorHandler(path:String, errorMessage:String):void
		{
			//MessageFrameHelper.showWarningMessage(path + " " + errorMessage);
		/*if (!directory.exists){
		   var warningLabel:JLabel = new JLabel("", new AssetIcon(new WARNING_ICON));
		   warningLabel.x = pathTF.getWidth() - 24;
		   pathTF.addChild(warningLabel);
		   return;
		 }*/
		}
		
		private function onRenamed(renamedFI:FileInfo):void
		{
			filesModel.replaceAt(filesList.getSelectedIndex(), renamedFI);
			searched = false;
		}
		
		private var searched:Boolean = false;
		private var originalClone:Array;
		private var filenameTF:JTextField;
		private var extensions:Array;
		private var extensionsModel:VectorListModel;
		private var typesCB:DSComboBox;
		private var warningLabel:JDropDownButton;
		private var pathCB:DSComboBox;
		
		private function searchBtnHandler(e:AWEvent):void
		{
			var searchText:String = searchTF.getText();
			if (!searched)
			{
				originalClone = ArrayUtil.createUniqueCopy(filesModel.toArray());
				searched = true;
			}
			else
			{
				if (searchText == "")
				{
					searched = false;
					filesModel.clear();
					filesModel.appendAll(originalClone);
					//gtrace("нечего искать");
					return;
				}
			}
			
			var files:Array = ArrayUtil.createUniqueCopy(originalClone);
			var filesArrayClone:Array = [];
			
			for (var i:int = 0; i < files.length; i++)
			{
				if ((files[i] as FileInfo).name.indexOf(searchText) != -1)
				{
					filesArrayClone.push(files[i]);
				}
			}
			filesModel.clear();
			filesModel.appendAll(filesArrayClone);
		}
		
		protected function onLevelTop(e:AWEvent):void
		{
			if (currentDirectory)
			{
				if (currentDirectory.parentPath != "")
				{
					AirMediator.getDirectory(currentDirectory.parentPath, onFiles, false, errorHandler);
				}
			}
		}
		
		private function createNewDirectory(e:AWEvent = null):void
		{
			if (currentDirectory)
			{
				AirMediator.createDirectory(currentDirectory.nativePath + "New Directory", onNewDirectoryCreated, errorHandler);
			}
		}
		
		protected function onNewDirectoryCreated(newDirectory:FileInfo):void
		{
			filesModel.append(newDirectory);
		}
		
		private function linkEvent(event:TextEvent):void
		{
			AirMediator.getDirectory(event.text, onFiles, false, errorHandler);
		}
		
		private function moveToTrash(e:AWEvent):void
		{
			var fi:FileInfo = getFileInfo();
			if (fi)
			{
				AirMediator.moveToTrash(fi.nativePath, onMoveToTrash, errorHandler);
			}
		}
		
		private function renameFile(e:AWEvent):void
		{
			var fi:FileInfo = getFileInfo();
			if (fi)
			{
				JOptionPane.showInputDialog("Rename to", "Input new " + (fi.isDirectory ? "directory" : "file") + " name, please                                                            ", renameTo, fi.name, null, true, new AssetIcon(new INFO_ICON, 20, 20));
			}
		}
		
		//**************************************************** ☼ СОЗДАНИЕ КОМПОНЕНТОВ ***************************************
		
		protected function createButton(text:String, icon:Icon, listener:Function, tooltipText:String = ""):JButton
		{
			var btn:JButton = new JButton(text, icon);
			btn.setForeground(new ASColor(0xFFFFFF, 0.5));
			btn.setBackgroundDecorator(null);
			btn.addActionListener(listener);
			if (tooltipText != "")
				btn.setToolTipText(tooltipText);
			return btn;
		}
		
		protected function createButton2(text:String, icon:Icon, listener:Function, tooltipText:String = ""):JButton
		{
			var btn:DSButton = new DSButton(text, icon);
			btn.setForeground(new ASColor(0xFFFFFF, 0.5));
			btn.addActionListener(listener);
			if (tooltipText != "")
				btn.setToolTipText(tooltipText);
			return btn;
		}
		
		protected function createControlElements():void
		{
			// textFields
			
			//var autocompleteDictionary:AutocompleteDictionary = new AutocompleteDictionary();
			//autocompleteDictionary.addToDictionary("path1");
			//am.setDictionary(
			/*pathTF.setPreferredWidth(375);
			   pathTF.addEventListener(TextEvent.LINK, linkEvent);
			   pathTF.addActionListener(onPathChange);
			 pathTF.addEventListener(KeyboardEvent.KEY_UP, pathTFKeyDownHandler);*/
			
			//AutocompleteManager
			//pathTF.setAu
			//pathTF.setForeground(new ASColor(0xFFFFFF, 0.6));
			
			pathCB = new DSComboBox(["asdasjhdKAJ", "SADHASJHDK", "SAJKDASLJDAJ", "JDKSAJDA"]);
			pathCB.setBackgroundDecorator(null);
			pathCB.setEditable(true);
			pathCB.setPreferredWidth(375);
			pathCB.getPopupList().setBorder(new EmptyBorder(null, new Insets(2, 3, 4, 3)));
			pathCB.getPopupList().setCellFactory(new GeneralListCellFactory(CellFact, true, true, 20));
			pathCB.setUI(new TextCBUI());
			//var bc:ColorDecorator = new ColorDecorator(new ASColor(0, 0), new ASColor(0xFFFFFF, 0.04));
			//bc.setGaps(0, 0, -2, 3);
			//pathCB.setBackgroundDecorator(bc);
			pathCB.setBackgroundDecorator(null);
			
			var acbe:AutocompleteComboBoxEditor = new AutocompleteComboBoxEditor();
			pathCB.setEditor(acbe);
			
			pathTF = (acbe.getEditorComponent() as JTextField);
			pathTF.addEventListener(TextEvent.LINK, linkEvent);
			pathTF.addActionListener(onPathChange);
			pathTF.setBackgroundDecorator(null);
			pathTF.setBorder(new SideLineBorder(null, SideLineBorder.SOUTH, new ASColor(0xFFFFFF, 0.24), 0.4));
			//pathTF.addEventListener(KeyboardEvent.KEY_UP, pathTFKeyDownHandler);
			autocompleteManager = new AutocompleteManager(pathTF, pathCB);
			
			searchTF = new JTextField();
			/*searchTF.setBackgroundDecorator(null);
			   searchTF.setBorder(new SideLineBorder(null, SideLineBorder.SOUTH, new ASColor(0xFFFFFF, 0.24), 0.4));
			   searchTF.setPreferredWidth(150);
			   searchTF.addActionListener(searchBtnHandler);
			 searchTF.setForeground(new ASColor(0xFFFFFF, 0.6));*/
			var searchPanel:SearchPanel = new SearchPanel();
			searchPanel.searchField.setPreferredWidth(150);
			
			// buttons
			var comp:Form = new Form();
			var levelTopBtn:JButton = createButton("", new AssetIcon(new UP_FOLDER_ICON), onLevelTop, "on level top");
			var newDirectoryBtn:JButton = createButton("", new AssetIcon(new NEW_FOLDER_ICON), createNewDirectory, "create new directory");
			var renameBtn:JButton = createButton("", new AssetIcon(new RENAME_ICON), renameFile, "rename");
			var moveToTrashBtn:JButton = createButton("", new AssetIcon(new TRASH_ICON), moveToTrash, "move to trash");
			var searchBtn:JButton = createButton("", new AssetIcon(new SEARCH_ICON), searchBtnHandler, "search");
			
			var showFCHFormBtn:JDropDownButton = new JDropDownButton("", new AssetIcon(new ARRAY_EDITOR_ICON16, 16, 16), false, fileChooserHelpersForm);
			showFCHFormBtn.setBackgroundDecorator(null);
			showFCHFormBtn.setPreferredWidth(35);
			showFCHFormBtn.setToolTipText("preview");
			
			var showViewModesFormBtn:JDropDownButton = new JDropDownButton("", new AssetIcon(new ARRAY_EDITOR_ICON16, 16, 16), false, viewModesForm);
			showViewModesFormBtn.setBackgroundDecorator(null);
			showViewModesFormBtn.setPreferredWidth(35);
			showViewModesFormBtn.setPopupAlignment(JDropDownButton.CENTER);
			showViewModesFormBtn.setToolTipText("view modes");
			
			var controlsFR:FormRow = comp.addLeftHoldRow(2, 8, /*15, */ /*pathTF,*/ pathCB, levelTopBtn, newDirectoryBtn, renameBtn, moveToTrashBtn, showFCHFormBtn, showViewModesFormBtn, /*28,*/ searchPanel /*, searchBtn*/);
			
			componentsForm.insertAll(componentsForm.getComponentCount() - 2, controlsFR);
		
		/*pathTF.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
		   searchTF.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
		   pathTF.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
		 searchTF.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);*/
		
			//form.insertAll(form.getComponentCount() - 1, new JSp(500), createButton("", onLevelTop));
			//form.addLeftHoldRow(0, 20, rootDirectoriesPane, 20, filesPane);
		}
		
		private function onFocusOut(e:FocusEvent):void
		{
			//gtrace("focus out");
			//return;
			//pathTF.setPreferredWidth(415);
			//searchTF.setPreferredWidth(150);
			
			pathTF.setPreferredWidth(370);
			searchTF.setPreferredWidth(150);
			pathTF.repaintAndRevalidate();
			searchTF.repaintAndRevalidate();
		/*else {
		   pathTF.setPreferredWidth(415);
		   searchTF.setPreferredWidth(150);
		 }*/
		
		/*var target:JTextField = e.currentTarget as JTextField;
		   //var target:JTextField = source == pathTF ? searchTF : pathTF;
		   gtrace(target.getPreferredWidth());
		
		   if (target.getWidth() != 0) {
		   target.setPreferredWidth(target.getPreferredWidth() * 0.8);
		
		   target.repaintAndRevalidate();
		   //target.setWidth(target.getPreferredWidth() * 0.8);
		 }*/ /*if(target.getWidth()!=0){
		   target.setPreferredWidth(target.getPreferredWidth() * 1.2);
		   target.revalidate();
		 }*/
		}
		
		private function onFocusIn(e:FocusEvent):void
		{
			//gtrace("focus in");
			if (first)
			{
				first = false;
				return;
			}
			
			if (e.currentTarget == searchTF)
			{
				pathTF.setPreferredWidth(270);
				searchTF.setPreferredWidth(250);
			}
			/*else {
			   pathTF.setPreferredWidth(500);
			   searchTF.setPreferredWidth(50);
			 }*/
			
			pathTF.repaintAndRevalidate();
			searchTF.repaintAndRevalidate();
		/*var target:JTextField = e.currentTarget as JTextField;
		   gtrace(target.getPreferredWidth());
		
		   //if
		   //var target:JTextField = source == pathTF ? searchTF : pathTF;
		
		   if (target.getPreferredWidth() != 0) {
		   target.setPreferredWidth(target.getPreferredWidth() * 1.2);
		   target.repaintAndRevalidate();
		   }
		
		 return;*/
		
		/*var source:JTextField = e.currentTarget as JTextField;
		   var target:JTextField = source == pathTF ? searchTF : pathTF;
		   //target = e.type == FocusEvent.FOCUS_IN ? source
		
		   if (source.getWidth() != 0) {
		   gtrace(source.getPreferredWidth() + " " + source + " " + source.getWidth());
		   source.setPreferredWidth(source.getPreferredWidth() * .2);
		   source.setWidth(source.getPreferredWidth() * .2);
		   //source.revalidate();
		   gtrace(source.getPreferredWidth() + " " + source + " " + source.getWidth());
		   //source.repaint();
		   }
		   if(target.getWidth()!=0){
		   target.setPreferredWidth(target.getPreferredWidth() * 1.2);
		   target.revalidate();
		   //target.repaint();
		 }*/
		}
		
		/**
		 * Создание списка корневых директорий.
		 */
		protected function createRootDirectoriesList():void
		{
			rootDirectoriesModel = new VectorListModel();
			
			rootDirectoriesList = new JList(rootDirectoriesModel, new GeneralListCellFactory(RootDirectoryCellRenderer, true, true, 20));
			
			rootDirectoriesList.setPreferredCellWidthWhenNoCount(150);
			rootDirectoriesList.addSelectionListener(rootDirectoriesListSelectionHandler);
			rootDirectoriesList.setSelectionMode(JList.SINGLE_SELECTION);
			
			rootDirectoriesPane = new JScrollPane(rootDirectoriesList, JScrollPane.SCROLLBAR_ALWAYS, JScrollPane.SCROLLBAR_AS_NEEDED);
			rootDirectoriesPane.setBorder(new EmptyBorder(null, new Insets(0, 2, 0, 0)));
			rootDirectoriesPane.setPreferredHeight(380);
			rootDirectoriesPane.setPreferredSize(new IntDimension(170, 380));
			rootDirectoriesPane.buttonMode = true;
		}
		
		/**
		 * Создание элементо нижней панели.
		 * 1. поле имени файла
		 * 2. комбобокс типов
		 * 3. кнопки "Ok", "Cancel"
		 * @param	form2
		 */
		protected function createControlElementsBottom(form2:Form):void
		{
			filenameTF = new DSTextField();
			filenameTF.setBackgroundDecorator(null);
			filenameTF.setBorder(new SideLineBorder(null, SideLineBorder.SOUTH, new ASColor(0xFFFFFF, 0.24), 0.4));
			filenameTF.setPreferredWidth(445);
			
			var okBtn:JButton = createButton2(_okBtnText, null, okBtnHandler);
			okBtn.setPreferredWidth(80);
			okBtn.setPreferredHeight(16);
			
			var cancelBtn:JButton = createButton2(_cancelBtnText, null, cancelBtnBtnHandler);
			cancelBtn.setPreferredWidth(80);
			cancelBtn.setPreferredHeight(16);
			
			extensionsModel = new VectorListModel();
			typesCB = new DSComboBox(extensionsModel);
			typesCB.setPreferredWidth(450);
			
			form2.addLeftHoldRow(0, new DSLabel("File name"), 25, filenameTF);
			form2.addLeftHoldRow(0, new DSLabel("Type of files"), 10, typesCB);
			form2.addLeftHoldRow(0, [0, 5]);
			form2.addCenterHoldRow(0, /*530,*/ okBtn, 4, cancelBtn);
		}
		
		//-------------------------------SET & GET----------------------------------------		
		
		public function getDialogForm():Form
		{
			return dialogForm;
		}
		
		public function getDialogFrame():JFrame
		{
			return dialogFrame;
		}
		
		public function showOpenDialog(owner:*):void
		{
		
		}
		
		public function showSaveDialog(owner:*):void
		{
		
		}
		
		public function setMultiSelectionEnabled(b:Boolean):void
		{
			if (b)
				viewModesForm.setSelectionMode(JList.SINGLE_SELECTION);
			else
				viewModesForm.setSelectionMode(JList.MULTIPLE_SELECTION);
		}
		
		public function getMultiSelectionEnabled():Boolean
		{
			return filesList.getSelectionMode() == JList.MULTIPLE_SELECTION;
		}
		
		public function getFileSelectionMode():String
		{
			return selectionMode;
		}
		
		public function setFileSelectionMode(mode:String):void
		{
			selectionMode = mode;
		}
		
		public function getSelectedFile():FileInfo
		{
			//return (filesList.getSelectedValue() as FileInfo).nativePath;
			return selectedFI;
		}
		
		public function getSelectedFiles():Array
		{
			return null;
		}
		
		public function setSelectedFile(path:String):void
		{
		
		}
		
		public function setSelectedFiles(paths:Array):void
		{
		
		}
		
		public function setCurrentDirectory(path:String):void
		{
		
		}
		
		public function setExtensions(extensions:Array):void
		{
			this.extensions = extensions;
			extensionsModel.clear();
			extensionsModel.appendAll(extensions);
			if (extensions.length > 0)
				typesCB.setSelectedIndex(0);
		}
		
		public function getExtensions():Array
		{
			return extensions;
		}
		
		protected function setFileInfo(fileInfo:FileInfo):void
		{
			filesModel.append(fileInfo);
		}
		
		protected function getFileInfo():FileInfo
		{
			var selId:int = filesList.getSelectedIndex();
			if (selId == -1)
				return null;
			return filesModel.get(filesList.getSelectedIndex());
		}
		
		public function getUrlRequest():URLRequest
		{
			if (filesList.getSelectedIndex() == -1)
				return null;
			
			var fi:FileInfo = getFileInfo();
			return new URLRequest(fi.nativePath);
		
		}
		
		public function setUrlRequest(urlRequest:URLRequest):void
		{
		
		}
		
		public function showLastFolderAtShown(b:Boolean):void
		{
			lastFolderAtShown = b;
		}
	
	}

}