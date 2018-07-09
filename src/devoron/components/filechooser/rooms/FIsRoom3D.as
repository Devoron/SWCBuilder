package devoron.components.filechooser.rooms
{
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.PerspectiveLens;
	import away3d.containers.View3D;
	import away3d.debug.Trident;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.events.ParserEvent;
	import away3d.loaders.AssetLoader;
	import away3d.primitives.WireframePlane;
	import devoron.airmediator.AirMediator;
	import devoron.components.color.ColorChooserForm;
	import devoron.components.filechooser.renderers.FileCellRenderer;
	import devoron.components.comboboxes.DSComboBox;
	import devoron.components.HSVSlider;
	import devoron.components.SliderForm;
	import devoron.components.WhiteChB;
	import devoron.components.DSLabel;
	import devoron.utils.searchandreplace.workers.SearchAndReplaceWorker.src.devoron.file.FileInfo;
	import devoron.file.LOC;
	import devoron.file.NATIVE;
	import devoron.geometry.parsers.geometries.ExternalGeometrySubParser;
	import devoron.image.utils.ImageDecoder;
	import devoron.image.utils.ImageUtil;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.DropShadowFilter;
	import flash.geom.Vector3D;
	import org.aswing.ASColor;
	import org.aswing.AssetIcon;
	import org.aswing.border.EmptyBorder;
	import org.aswing.decorators.ColorDecorator;
	import org.aswing.event.AWEvent;
	import org.aswing.event.InteractiveEvent;
	import org.aswing.event.ListItemEvent;
	import org.aswing.event.PopupEvent;
	import org.aswing.ext.Form;
	import org.aswing.ext.GeneralGridListCellFactory;
	import org.aswing.ext.GridList;
	import org.aswing.ext.KnobForm;
	import org.aswing.geom.IntDimension;
	import org.aswing.Insets;
	import org.aswing.JButton;
	import org.aswing.JDropDownButton;
	import org.aswing.JFrame;
	import org.aswing.JFrameTitleBar;
	import org.aswing.JList;
	import org.aswing.JNumberKnob;
	import org.aswing.JNumberStepper;
	import org.aswing.JPanel;
	import org.aswing.JPopup;
	import org.aswing.JScrollPane;
	import org.aswing.layout.FlowLayout;
	import org.aswing.util.HashMap;
	import org.aswing.util.Stack;
	import org.aswing.VectorListModel;

	
	/**
	 * AudioFCH
	 * 
	 * Render for audio-files in FileChooser.
	 * @author Devoron
	 */
	public class FIsRoom3D extends JFrame
	{
		[Embed(source = "../../../../../assets/icons/sound_editor_icon16.png")]
		private const AUDIO_ICON:Class;
		
		private var previewObjectCompleteListener:Function;
		private var path:String;
		
		// список уже распарсенных ассетов
		public var objectsCash:HashMap;
		public var objectsStack:Stack;	
		public var currentMode:Namespace;
		
		private var running:Boolean = false;
		private var enabled:Boolean = true;
		
		
		private var computedPath:String;
		private var view:View3D;
		private var loader:AssetLoader;
		private var geometryParser:ExternalGeometrySubParser;
		private var panePanel:JPanel;
		private var trident:Trident;
		private var wireframeGrid:WireframePlane;
		private var skyboxButtonPanel:JPanel;
		private var filesList:GridList;
		private var filesModel:VectorListModel;
		
		
		public function FIsRoom3D()
		{
			if (CONFIG::air)
			{
				currentMode = NATIVE;
			}
			else {
				currentMode = LOC;
			}
			
			//dialogFrame = new JFrame(null, title, false);
			filters = [new DropShadowFilter(4, 45, 0x000000, 0.14, 4, 4, 0.5, 2)];
			
			(getTitleBar() as JFrameTitleBar).setClosableOnly(true);
			setBackground(new ASColor(0X0E1012, 1));
			setIcon(new AssetIcon(new AUDIO_ICON));
			setMinimumSize(new IntDimension(770, 300));
			setSize(new IntDimension(770, 300));
			setMaximumWidth(770);
			setTitle("Room3D");
			
			
			var cd:ColorDecorator = new ColorDecorator(new ASColor(0x262F2B, 1), new ASColor(0XFFFFFF, 0.24), 4);
			cd.setGaps(-2, 1, 1, -2);
			setBackgroundDecorator(cd);
			
			//dialogFrame.setBackgroundDecorator(new ColorBackgroundDecorator(new ASColor(0x262F2B, 1), new ASColor(0xFFFFFF, 0.4)));
			
			panePanel = new JPanel();
			panePanel.setBorder(new EmptyBorder(null, new Insets(0, 10, 5, 10)));
			//panePanel.setLayout(new BorderLayout(10, 2));
			//panePanel.setSizeWH(730, 430);
			setContentPane(panePanel);
			
			var controlsForm:Form = new Form();
			controlsForm.setTextRenderer(DSLabel);
			var rotationChB:WhiteChB  = new WhiteChB("rotation");
			//controlsForm.addLeftHoldRow(0, 20, rotationChB);
			
			var speedSL:SliderForm = new SliderForm("speed", 0, 100);
			controlsForm.addLeftHoldRow(0, /*20, */rotationChB, speedSL);
			
			var hsvSL:HSVSlider = new HSVSlider();
			hsvSL.setPreferredHeight(12);
			hsvSL.setPreferredWidth(181);
			hsvSL.addStateListener(hsvSLListener);
			controlsForm.addLeftHoldRow(0, new DSLabel("background color"), hsvSL);
			
			
			skyboxButtonPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 10, 0, false));
			skyboxButtonPanel.setPreferredHeight(30);
			
			//wireframeGrid.se
			
			var roomTexturesPanel:JPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 10, 0, false));
			
			controlsForm.addLeftHoldRow(0, "skyboxes");
			controlsForm.addLeftHoldRow(0, skyboxButtonPanel);
			
			controlsForm.addLeftHoldRow(0, "room textures");
			controlsForm.addLeftHoldRow(0, roomTexturesPanel);
			
			
			//width:Number, height:Number, segmentsW:int = 10, segmentsH:int = 10, color:uint = 0xFFFFFF, thickness:Number = 1, orientation:String = "yz"
			var gridWST:JNumberStepper = new JNumberStepper();
			var gridHST:JNumberStepper = new JNumberStepper();
			var gridSegmentW:JNumberStepper = new JNumberStepper();
			var gridSegmentH:JNumberStepper = new JNumberStepper();
			var gridCCF:ColorChooserForm = new ColorChooserForm("grid color");
			var gridThicknessST:JNumberStepper = new JNumberStepper();
			var orientationCB:DSComboBox = new DSComboBox(); 
			
			
			var showSkyboxesListBtn:JDropDownButton = new JDropDownButton("", new AssetIcon(new AUDIO_ICON), true, createSkyboxesList());
			//showSkyboxesListBtn.setPopupAlignment(JDropDownButton.BOTTOM);
			showSkyboxesListBtn.setPreferredWidth(35);
			showSkyboxesListBtn.setPopupAlignment(JDropDownButton.RIGHT);
			showSkyboxesListBtn.setToolTipText("preview helpers");
			controlsForm.addLeftHoldRow(0, showSkyboxesListBtn);
			
			/*	var angleKF:KnobForm = new KnobForm("angle", KnobForm.X_AXIS, 26);
			angleKF.setKnobRadius(20);
			controlsForm.addLeftHoldRow(0, 20, angleKF);*/
			
				/*var knobForm:KnobForm = new KnobForm("rotation speed", KnobForm.X_AXIS, 3, KnobForm.RIGHT);
			controlsForm.addLeftHoldRow(0, 20, knobForm);
			knobForm.setKnobRadius(15);*/
			
			panePanel.append(controlsForm);
			
			
			objectsStack = new Stack();
			objectsCash = new HashMap();
			
			createSimpleWorld();
			addEventListener(PopupEvent.POPUP_OPENED, onPopupOpened);
			
			AirMediator.currentMode::getDirectory("F:\\Projects\\projects\\flash\\FileChooserSWF\\assets\\skyboxes", resultHandler, true/*, errorHandler:Function = null*/)
		}
		
		protected function createSkyboxesList():JPopup 
		{
			var popup:JPopup = new JPopup();
			
			var cd:ColorDecorator = new ColorDecorator(new ASColor(0x262F2B, 1), new ASColor(0XFFFFFF, 0.24), 4);
			cd.setGaps(-2, 1, 0, -1);
			popup.setBackgroundDecorator(cd);
			
			//viewsHashMap = new HashMap();
			//contentViews = new HashMap();
			
			/*setSize(new IntDimension(250, 200));
			   setPreferredSize(new IntDimension(250, 200));
			   setMaximumSize(new IntDimension(250, 200));
			 setMinimumSize(new IntDimension(250, 200));*/
			
			//var modulForm:Form = new Form(new VerticalCenterLayout());
			var modulForm:Form = new Form();
			modulForm.setBorder(new EmptyBorder(null, new Insets(0, 2, 0, 2)));
			//setContentPane(modulForm);
			popup.append(modulForm);
			filesModel = new VectorListModel();
			
			filesList = new GridList(filesModel, new GeneralGridListCellFactory(FileCellRenderer), 4, 8);
			filesList.doubleClickEnabled = true;
			//filesList.addEventListener(ListItemEvent.ITEM_DOUBLE_CLICK, onDoubleClick);
			//filesList.addSelectionListener(selectContentViewListener);
			
			//filesList.setPreferredCellWidthWhenNoCount(280);
			//filesList.setPreferredCellWidthWhenNoCount(80);
			//filesList.addSelectionListener(filesListSelectionHandler);
			filesList.setSelectionMode(JList.SINGLE_SELECTION);
			
			var filesPane:JScrollPane = new JScrollPane(filesList);
			//filesPane.setPreferredHeight(200);
			filesPane.setSize(new IntDimension(200, 100));
			filesPane.setMinimumSize(new IntDimension(200, 100));
			filesPane.setPreferredSize(new IntDimension(200, 100));
			filesPane.setVerticalScrollBarPolicy(JScrollPane.SCROLLBAR_ALWAYS);
			//filesPane.setHorizontalScrollBarPolicy(JScrollPane.SCROLLBAR_AS_NEEDED);
			filesPane.setHorizontalScrollBarPolicy(JScrollPane.SCROLLBAR_ALWAYS);
			//filesPane.buttonMode = true;
			
			modulForm.addRightHoldRow(0, filesPane);
			
			popup.pack();
			return popup;
		}
		
		private function resultHandler(fi:FileInfo):void 
		{
			gtrace(fi);
			//skyboxButtonPanel
			var files:Array = fi.directoryListing;
			var btn:JButton;
			for (var i:int = 0; i < files.length; i++) 
			{
				var bi:Bitmap;
				if (!bi)
					bi = new Bitmap(new BitmapData(35, 25));
				var bd:BitmapData = ImageUtil.scaleBitmapData(bi.bitmapData, 35 / bi.width);
				var icon:AssetIcon = new AssetIcon(new Bitmap(bd));
				btn = new JButton("", icon);
				btn.setSize(new IntDimension(35, 25));
				btn.addActionListener(walpaperBtnHandler);
				btn.setShiftOffset(0);
				//btn.name = String(j);
				skyboxButtonPanel.append(btn);
				
				new ImageDecoder((files[i] as FileInfo).data, onSkyboxImageComplete, btn);
			}
			
			
			
			/*var btn:JButton;
			
			for (var j:int = 0; j < 8; j++)
			{
				var bi:Bitmap;
				if (!bi)
					bi = new Bitmap(new BitmapData(35, 25));
				var bd:BitmapData = ImageUtil.scaleBitmapData(bi.bitmapData, 35 / bi.width);
				var icon:AssetIcon = new AssetIcon(new Bitmap(bd));
				btn = new JButton("", icon);
				btn.setSize(new IntDimension(35, 25));
				btn.addActionListener(walpaperBtnHandler);
				btn.setShiftOffset(0);
				btn.name = String(j);
				//(j < 4 ? p1 : p2).append(btn);
				skyboxButtonPanel.append(btn);
			}*/
			
		}
		
		private function onSkyboxImageComplete(bd:BitmapData, btn:JButton):void 
		{
			var bd2:BitmapData = ImageUtil.scaleBitmapData(bd, 35 / bd.width);
			var icon:AssetIcon = new AssetIcon(new Bitmap(bd2));
			btn.setIcon(icon);
		}
		
		private function walpaperBtnHandler(e:AWEvent):void 
		{
			
		}
		
		private function hsvSLListener(e:InteractiveEvent):void 
		{
			//ApplicationBackgroundDecorator.setHSV(hsvSL.getValue());
		}
		
		/**
		 * Построить комнату:
			 * 1. распарсить объект по ссылке
			 * 2. добавить объект в комнату
		 * @param	path
		 */
		public function buildRoom(path:String):void {
			AirMediator.currentMode::getFile(path, onLoad, true);
		}
		
		private function onPopupOpened(e:PopupEvent):void 
		{
			//stage.addChild(view3D);
			panePanel.addChild(view);
		}
		
		/*public function omg():void {
		var ds:DataStructur;
			var transformDSO:DataStructurObject;
			var matricies:Vector.<Matrix3D> = currentMatrixEditor.getMatrices();
			
			if (matricies)
			{
				for (var i:int = 0; i < count; i++)
				{
					ds = createdObjects[i];
					transformDSO = ds.getDataByContainerName("TransformMatrix");
					
					if (transformDSO)
					{
						transformDSO.active = false;
						var transforms:Vector.<Vector3D> = matricies[i].decompose();
						transformDSO.positionX = transforms[0].x;
						transformDSO.positionYST = transforms[0].y;
						transformDSO.positionZST = transforms[0].z;
						transformDSO.rotationXST = transforms[1].x;
						transformDSO.rotationYST = transforms[1].y;
						transformDSO.rotationZST = transforms[1].z;
						transformDSO.scaleXST = transforms[2].x;
						transformDSO.scaleYST = transforms[2].y;
						transformDSO.scaleZST = transforms[2].z;
						transformDSO.active = true;
					}
					
				}
			}	
		}*/
		
		/**
		 * Создать примитивный мир, в котором будут отрисовываться preview для
		 * трёхмерных объектов.
		 */
		private function createSimpleWorld():void {
			var camera:Camera3D = new Camera3D();
				camera.position = new Vector3D(0, 0, -50);
				//camera2.lookAt(World.meshes[0].position);
				
				view = new View3D(null, camera, null, true);
				view.antiAlias = 1;
				view.camera.lens = new PerspectiveLens(90);
				view.width = 750;
				view.height = 280;
				view.backgroundAlpha = 0;
				
				//Main_FILE_CHOOSER_FLASH.STAGE.addChild(view3D);
				view.alpha = 0;
				view.visible = false;
				
				
				trident = new Trident(70, true);
				view.scene.addChild(trident);
				view.buttonMode = true;
			
				// сетка
				wireframeGrid = new WireframePlane(300, 300, 10, 10, 0x0, 0.7, WireframePlane.ORIENTATION_XZ);
				wireframeGrid.color = 0xFFFFFF;
				view.scene.addChild(wireframeGrid);
				
				//view2.addEventListener(Event.ENTER_FRAME, onEnterFrame);
				/*this.addChild(view2);*/
				
				/*var cube:Mesh = new Mesh(new CubeGeometry(), new ColorMaterial(0x5E8D23));
				view2.scene.addChild(cube);
				*/
				
				//SingleFileLoader.enableParser(AWDParser);
			//var meshParser:MeshParser = new MeshParser();
			
			//loader = new AssetLoader();
			
			/*loader.addEventListener(AssetEvent.ASSET_COMPLETE, onAnimation);
			loader.addEventListener(LoaderEvent.RESOURCE_COMPLETE, onComplete);
			loader.addEventListener(LoaderEvent.LOAD_ERROR, onError);*/	
		}
		
		
		/* INTERFACE devoron.components.filechooser.FileChooserHelper */
		
		public function getSupportedExtensions():Array
		{
			return ["awd"];
		}
		
		
		/* INTERFACE devoron.components.filechooser.IFileChooserHelper */
		
		public function getType():String 
		{
			return "audio";
		}
		
		
		public override function isEnabled():Boolean 
		{
			return enabled;
		}
		
		public override function setEnabled(b:Boolean):void 
		{
			enabled = b;
			
			if (b == false) {
			objectsStack.clear();	
			if(previewObjectCompleteListener!=null)
			previewObjectCompleteListener.call(null, { path:computedPath, icon: null } );
			}	
		}
		
		/*private function workerStateHandler(e:Event):void 
		{
			AirMediator.currentMode::getFile(path, onLoad, true);
		}*/
		
		private function onLoad(fi:FileInfo):void
		{
			
		/*		var mesh:Mesh = new Mesh(e);
			view3D.scene.addChild(mesh);
			view3D.camera.lookAt(mesh.position);*/
			
			//gtrace("2: получен файл " + fi.nativePath + " " + fi.data.length + " mainToBackSpectrum " + mainToBackSpectrum.state);
			
			// отдать потоку байты аудио-файла и запустить выполнение потока
			//MessageChannelState.
			
			//fi.data.shareable = true;
			//spectrumWorker.setSharedProperty("bytes", fi.data);
			//mainToBackSpectrum.send(fi.nativePath);
			//runWorker();
		
		/*		parserCls = AllSubParsers.getRelatedParser(id, AllSubParsers.ALL_GEOMETRIES);
				if (!parserCls)
					dieWithError("Unknown geometry parser");
				_geometryParser = new parserCls();
				addSubParser(_geometryParser);
				_geometryParser.parseAsync(subData);*/
				
				
			/*parser.addEventListener(ParserEvent.PARSE_ERROR, onEr);
			parser.parseAsync({url: "C:\\Users\\Devoron\\Desktop\\asset_rocks.awd"});*/
			
			geometryParser = new ExternalGeometrySubParser();
				geometryParser.addEventListener(AssetEvent.GEOMETRY_COMPLETE, onGeometry);
			loader.loadData({url: getText(fi.nativePath)/*"C:\\Users\\Devoron\\Desktop\\asset_rocks.awd"*/}, "mesh", null, null, geometryParser);
			//onEnterFrame(null);
		}
		
		public function getText(str:String):String
		{
			var text:String = str;
			text = text.replace(/\\/g, '/');
			//text = text.replace( /\\/g, '\\\\');
			return text;
		}
		
		private function onEr(e:ParserEvent):void 
		{
			gtrace(e);
		}
		
		private function onGeometry(e:AssetEvent):void 
		{
			gtrace("2:Создана геометрия " + e);
			//onEnterFrame(e.asset as Geometry);
		}
			private function computeNext():void {
				if (objectsStack.isEmpty()) {
					running = false;
					}
				else {
					var obj:Object = objectsStack.pop();
					if(obj){
					var fi:FileInfo = obj.fi;
					var listener:Function = obj.listener;
					previewObjectCompleteListener = listener;
					path = fi.nativePath;
					AirMediator.currentMode::getFile(fi.nativePath, onLoad, true, errorHandler);
					gtrace("ЗАПРОС НА ФАЙЛ " + fi.nativePath + " осталось " + objectsStack.size()); 
					}
				}
			}
			
			private function errorHandler(data:String):void 
			{
				gtrace("2:Ошибка " + data);
			}
		
		
		
		private function onError(e:LoaderEvent):void 
		{
			gtrace(e);
		}
		
		private function onComplete(e:LoaderEvent):void 
		{
			gtrace(e);
		}
		
		private function onAnimation(e:AssetEvent):void 
		{
			gtrace(e);
		}
		
	
	}

}