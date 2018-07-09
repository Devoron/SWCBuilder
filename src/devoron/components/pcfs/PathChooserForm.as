package devoron.components.pcfs
{
	import devoron.components.buttons.AboutButtonUI3;
	import devoron.components.comboboxes.AutocompleteComboBoxEditor;
	import devoron.components.comboboxes.CellFact;
	import devoron.components.comboboxes.DSComboBox;
	import devoron.components.comboboxes.TextGrayCB;
	import devoron.components.filechooser.FileChooser;
	import devoron.components.labels.DSLabel;
	import devoron.components.labels.WarningLabel;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.net.URLRequest;
	import org.aswing.ASColor;
	import org.aswing.AssetIcon;
	import org.aswing.AsWingManager;
	import org.aswing.border.EmptyBorder;
	import org.aswing.Component;
	import org.aswing.decorators.ColorDecorator;
	import org.aswing.event.AWEvent;
	import org.aswing.event.PopupEvent;
	import org.aswing.ext.Form;
	import org.aswing.ext.FormRow;
	import org.aswing.GeneralListCellFactory;
	import org.aswing.geom.IntDimension;
	import org.aswing.Insets;
	import org.aswing.JColorChooser;
	import org.aswing.JFrame;
	import org.aswing.JLabel;
	import org.aswing.JPathTextField;
	import org.aswing.JSpacer;
	import org.aswing.JToggleButton;
	
	
	[Event(name="act",type="org.aswing.event.AWEvent")]
	
	/**
	 * PathChooserForm
	 * @author Devoron
	 */
	public class PathChooserForm extends Form
	{
		public static const DIRECTORIES_ONLY:String = "directories_only";
		public static const FILES_AND_DIRECTORIES:String = "files_and_directories";
		public static const FILES_ONLY:String = "files_only";
		
		[Embed(source = "../../../../assets/icons/commons/folder_icon16.png")]
		private var FOLDER_ICON16:Class;
		
		//private const SELECT_FILE_ICON:String = "../assets/icons/select_file_icon16.png";
		private var addChooserToRootContainer:Boolean;
		private var defaultVisible:Boolean;
		
		protected var rootContainer:DisplayObjectContainer;
		protected var titleLB:DSLabel;
		protected var pathTF:JPathTextField;
		protected var colorChooser:JColorChooser;
		protected var showChooserBtn:JToggleButton;
		protected var previewColorLB:JLabel;
		
		protected var colorChooserFR:FormRow;
		
		protected var fileSelectFunction:Function;
		protected var cancelFunction:Function;
		
		protected var spacer1:JSpacer;
		protected var spacer2:JSpacer;
		protected var spacer3:JSpacer;
		
		protected var fr1:FormRow;
		protected var fr2:FormRow;
		
		protected var extensions:Array;
		protected var selectionMode:String = "files_and_directories";
		
		private static var _fileChooser:FileChooser = new FileChooser();
		
		private static var allPathChooserForms:Vector.<PathChooserForm> = new Vector.<PathChooserForm>();
		private var fileTypeCB:TextGrayCB;
		private var pathCB:DSComboBox;
		private var warningLabel:WarningLabel;
		
		public function PathChooserForm(title:String = "", fileSelectFunction:Function = null, visible:Boolean = false)
		{
			this.defaultVisible = visible;
			this.addChooserToRootContainer = addChooserToRootContainer;
			this.fileSelectFunction = fileSelectFunction;
			
			setDropTrigger(true);
			
			fileTypeCB = new TextGrayCB(["swf", "img", "video", "cam", "stream", "gif"]);
			fileTypeCB.setBackgroundDecorator(null);
			fileTypeCB.getPopupList().setBorder(new EmptyBorder(null, new Insets(2, 3, 4, 3)));
			fileTypeCB.getPopupList().setCellFactory(new GeneralListCellFactory(CellFact, true, true, 20));
			fileTypeCB.setSelectedIndex(0);
			fileTypeCB.setPreferredSize(new IntDimension(60, 26));
			fileTypeCB.getEditor().getEditorComponent().setBorder(null);
			//grayCB.scaleX = grayCB.scaleY = 0.7;
			//super.addLeftHoldRow(0, grayCB);
			
			titleLB = new DSLabel(title);
			//Main_PRICE2000.tracer("hai " + titleLB.getHeight());
			fr1 = super.addLeftHoldRow(0, titleLB, fileTypeCB);
			
			//pathTF = new JPathTextField();
			//pathTF.setPreferredWidth(235);
			
			pathCB = new DSComboBox(["asdasjhdKAJ", "SADHASJHDK", "SAJKDASLJDAJ", "JDKSAJDA"]);
			
			pathCB.setEditable(true);
			
			var acbe:AutocompleteComboBoxEditor = new AutocompleteComboBoxEditor();
			pathCB.setEditor(acbe);
			
			pathTF = (acbe.getEditorComponent() as JPathTextField);
			//pathTF.setBorder(new SideLineBorder(null, SideLineBorder.SOUTH, new ASColor(0xFFFFFF, 0.24), 0.4));
			pathCB.setBackgroundDecorator(null);
			pathCB.addActionListener(onSelectPath);
			pathCB.setPreferredSize(new IntDimension(235, 26));
			pathCB.getPopupList().setBorder(new EmptyBorder(null, new Insets(2, 3, 4, 3)));
			pathCB.getPopupList().setCellFactory(new GeneralListCellFactory(CellFact, true, true, 20));
			//pathCB.setUI(new TextCBUI());
		/*	pathCB.setBorder(null);
			pathCB.setBackground(null);
			pathCB.setBackgroundDecorator(null);*/
			
			
			//pathTF = (getEditor().getEditorComponent() as JTextField);
			//pathTF.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			/*var sld:SideLineDecorator = new SideLineDecorator(new ASColor(0, 0), new ASColor(0xFFFFFF, 0.4), 0, SideLineDecorator.SOUTH);
			sld.setGaps(0, 0, 0, -3);
			pathTF.setBackgroundDecorator(sld);*/
			//pathTF.setBorder(new SideLineBorder(null, SideLineBorder.SOUTH, new ASColor(0xFFFFFF, 1), 0.4));
			
			//var bc:ColorDecorator = new ColorDecorator(new ASColor(0, 0), new ASColor(0xFFFFFF, 0.04));
			//bc.setGaps(0, -2, -2, 3);
			//pathCB.setBackgroundDecorator(bc);
			
			showChooserBtn = new JToggleButton("", new AssetIcon(new FOLDER_ICON16, 16, 16, false));
			showChooserBtn.setUI(new AboutButtonUI3());
			showChooserBtn.setPreferredSize(new IntDimension(24, 24));
			var bc:ColorDecorator = new ColorDecorator(new ASColor(0x000000, 0.04), new ASColor(0xFFFFFF,  0.04), 2);
			bc.setGaps(-2, 1, 1, -2);
			//showChooserBtn.setBackgroundDecorator(bc);
			//showChooserBtn.setBackgroundDecorator(null);
			showChooserBtn.addActionListener(showFileChooser);
			
			spacer1 = new JSpacer(new IntDimension(2, 0));
			fr2 = super.addLeftHoldRow(0, pathCB, spacer1, showChooserBtn);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage, false, 0, true);
		}
		
		private function onSelectPath(e:AWEvent):void
		{
			//Main_PRICE2000.tracer(pathCB.getSelectedItem());
		}
		
		public static function addDragAcceptableInitiator(com:Component):void
		{
			for each (var pcf:PathChooserForm in allPathChooserForms)
				pcf.addDragAcceptableInitiator(com);
		}
		
		public static function removeDragAcceptableInitiator(com:Component):void
		{
			for each (var pcf:PathChooserForm in allPathChooserForms)
				pcf.removeDragAcceptableInitiator(com);
		}
		
		private function onRemovedFromStage(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			allPathChooserForms.splice(allPathChooserForms.indexOf(this), 1);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			allPathChooserForms.push(this);
		}
		
		override public function setVisible(v:Boolean):void
		{
			//Main_PRICE2000.tracer("path chooser visible " + v);
			super.setVisible(v);
		}
		
		public function showFileChooser(e:AWEvent = null):void
		{
			var frame:JFrame = _fileChooser.getDialogFrame();
			if (extensions)
				_fileChooser.setExtensions(extensions);
			_fileChooser.setFileSelectionMode(selectionMode);
			frame.setVisible(!frame.isVisible());
			frame.setLocationRelativeTo();
			frame.toFront();
			//frame.changeOwner(Studio.instance.stage);
			frame.changeOwner(AsWingManager.getRoot());
			if (frame.isVisible())
			{
				frame.addEventListener(PopupEvent.POPUP_CLOSED, onFileChooserClosed);
				_fileChooser.addActionListener(onFileSelect);
			}
		}
		
		public function addActionListener(listener:Function):void
		{
			super.addEventListener(AWEvent.ACT, listener);
		}
		
		public function removeActionListener(listener:Function):void
		{
			super.removeEventListener(AWEvent.ACT, listener);
		}
		
		//**************************************************** ♪ ОБРАБОТЧИКИ СОБЫТИЙ ***************************************		
		
		private function onFileChooserClosed(e:Event):void
		{
			/*e.currentTarget.removeEventListener(PopupEvent.POPUP_CLOSED, onFileChooserClosed);
			_fileChooser.removeActionListener(onFileSelect);
			showChooserBtn.setSelected(false);*/
		}
		
		private function onFileSelect(e:AWEvent):void
		{
			//pathTF.setText(_fileChooser.getSelectedFile().nativePath);
			/*pathCB.setSelectedItem(_fileChooser.getSelectedFile().nativePath);
			if (fileSelectFunction != null)
				fileSelectFunction.call(null, _fileChooser.getSelectedFile());
			*/
			super.dispatchEvent(new AWEvent(AWEvent.ACT));
		}
		
		//-------------------------------SET & GET----------------------------------------		
		
		public function set spaceWidth1(value:uint):void
		{
			spacer1.setPreferredWidth(value);
		}
		
		public function setPathFieldWidth(value:uint):void
		{
			pathCB.setPreferredWidth(value);
		}
		
		public function get formRow1():FormRow
		{
			return fr1;
		}
		
		public function get formRow2():FormRow
		{
			return fr2;
		}
		
		public function get fileChooser():FileChooser
		{
			return _fileChooser;
		}
		
		public function setTitle(title:String):void
		{
			titleLB.setText(title);
		}
		
		public function getTitle():String
		{
			return titleLB.getText();
		}
		
		public function setPath(path:String):void
		{
			//pathTF.setText(path);
			pathCB.setSelectedItem(path);
		}
		
		public function getPath():String
		{
			//return pathTF.getText();
			//return pathCB.getSelectedItem();
			var path:String = pathCB.getSelectedItem()
			
			//path.replace("\\", "\\\\");
			
			var example:RegExp = /\\/g;
			var arr;
			
			
			arr = example.exec(path);
			trace(arr.index);
			trace(arr.lastIndex);
			
			//while ((arr=example.exec(path))!=null) {
				//arr = example.exec(path);
				
				//if(arr)
				//trace(arr.index);
				//if(arr.index!=undefined)
				path = path.replace(example,  "\\\\");
			//}
			
			//return path.replace("\\", "\\\\");
			return path;
		}
		
		public function getUrlRequest():URLRequest
		{
			//return _fileChooser.getUrlRequest();
			return null;
		}
		
		public function setUrlRequest(urlRequest:URLRequest):void
		{
			pathTF.setText(urlRequest.url);
			//_fileChooser.setUrlRequest(urlRequest);
		}
		
		//****************************************
		//           Managing FileChooser
		//****************************************
		
		public function setDialogTitle(title:String):void
		{
			/*if (_fileChooser.getDialogFrame())
			{
				_fileChooser.getDialogFrame().setTitle(title);
			}*/
		}
		
		public function getDialogTitile():String
		{
			/*if (_fileChooser.getDialogFrame())
			{
				return _fileChooser.getDialogFrame().getTitle();
			}*/
			return null;
		}
		
		public function setMultiSelectionEnabled(b:Boolean):void
		{
			//_fileChooser.setMultiSelectionEnabled(b);
		}
		
		public function getMultiSelectionEnabled():Boolean
		{
			//return _fileChooser.getMultiSelectionEnabled();
			return null;
		}
		
		public function getFileSelectionMode():String
		{
			return selectionMode;
		}
		
		public function setFileSelectionMode(mode:String):void
		{
			selectionMode = mode;
		}
		
		public function getSelectedFile():String
		{
			//return _fileChooser.getSelectedFile().nativePath;
			return "";
		}
		
		public function getSelectedFiles():Array
		{
			//return _fileChooser.getSelectedFiles();
			return null;
		}
		
		public function setSelectedFile(path:String):void
		{
			//_fileChooser.setSelectedFile(path);
		}
		
		public function setSelectedFiles(paths:Array):void
		{
			//_fileChooser.setSelectedFiles(paths);
		}
		
		public function setCurrentDirectory(path:String):void
		{
			//_fileChooser.setCurrentDirectory(path);
		}
		
		public function setExtensions(extensions:Array):void
		{
			this.extensions = extensions;
			fileTypeCB.setListData(extensions);
		}
		
		public function getExtensions():Array
		{
			return extensions;
		}
	
	}

}