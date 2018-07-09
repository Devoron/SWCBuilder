package devoron.aslc.moduls.libraries
{
	import ascb.util.DateFormat;
	import devoron.aslc.events.SWCBuilderEvent;
	import devoron.aslc.events.SWCBuilderEventDispatcher;
	import devoron.aslc.moduls.output.OutputForm;
	import devoron.aslc.moduls.project.data.SWCBuilderProjectData;
	import devoron.components.buttons.DSButton;
	import devoron.components.buttons.DSTextField;
	import devoron.components.labels.DSLabel;
	import devoron.data.core.base.DataStructurObject;
	import devoron.data.core.base.IDataContainer;
	import devoron.dataui.DataContainerForm;
	import devoron.dataui.multicontainers.table.ContainersAssetsControlPanel;
	import devoron.file.FileInfo;
	import devoron.sdk.aslc.core.utils.ConfigurationMaker;
	import devoron.sdk.sdkmediator.ascsh.ASCSH;
	import devoron.sdk.sdkmediator.ascsh.commands.CompcCMD;
	import devoron.utils.airmediator.AirMediator;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filters.BlurFilter;
	import flash.utils.ByteArray;
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.ASFontAdvProperties;
	import org.aswing.border.EmptyBorder;
	import org.aswing.event.AWEvent;
	import org.aswing.ext.Form;
	import org.aswing.geom.IntDimension;
	import org.aswing.Insets;
	import org.aswing.JCheckBox;
	import org.aswing.JFrame;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
	import org.aswing.layout.BorderLayout;
	//import devoron.studio.moduls.code.components.ScriptsTreeForm;
	
	/**
	 * SWCBuilderForm
	 * @author Devoron
	 */
	public class SWCBuilderForm extends DataContainerForm
	{
		protected var classesTable:IncludedClassesTable;
		protected var classesTableModel:IncludedClassesTableModel;
		protected var newLibTF:DSTextField;
		private var containersControlPanel:ContainersAssetsControlPanel;
		//private var _fileChooser:FileChooser = new FileChooser("Select libraries");
		//private var scriptsTreeForm:ScriptsTreeForm;
		private var rootFolder:FileInfo;
		private var asc:ASCSH;
		private var titleLB:JLabel;
		private var libPathTF:DSTextField;
		public static var sizeLB:JLabel;
		public static var m2:Shape;
		
		private var arr:Array = new Array();
		//private var classesListScP:JScrollPane;
		private var f:File;
		private var classesListScP:JScrollPane;
		
		public function SWCBuilderForm()
		{
			super("SWC", "project");
			
			intallComponents();
			SWCBuilderEventDispatcher.getInstance().addEventListener(SWCBuilderEvent.NEW_PROJECT, onNewProject);
		}
		
		
		private function intallComponents():void
		{
			var lb:JLabel = new DSLabel("SWCBuilder");
			lb.setFont(lb.getFont().changeSize(14));
			
			addLeftHoldRow(0, lb);
			
			var ds2:DSButton = new DSButton("create swc", null, createSWCBtnHander, 100, 24);
			var includeAllChB:JCheckBox = new JCheckBox("includeAll", null, true);
			includeAllChB.setIconTextGap(5);
			includeAllChB.addActionListener(includeAllChBHandler);
			
			
			//btn.setPreferredHeight(24);
			
			this.newLibTF = new DSTextField();
			newLibTF.setPreferredSize(new IntDimension(400, 20));
			
			this.libPathTF = new DSTextField();
			libPathTF.setPreferredSize(new IntDimension(400, 20));
			
			libPathTF.setText("F:\\Projects\\projects\\flash\\studio\\studiolibs\\ascb.swc");
			
			createIncludedClassesTableForm();
			
			titleLB = new JLabel("F:\\src\\nochump", null, JLabel.LEFT);
			titleLB.setPreferredSize(new IntDimension(260, 16));
			
			var advProp:ASFontAdvProperties = new ASFontAdvProperties(true, "advanced", "pixel");
			var font:ASFont = new ASFont("Roboto Light", 14, true, false, false, advProp);
			titleLB.setTextFilters([new BlurFilter(1, 1, 3)]);
			titleLB.setForeground(new ASColor(0x7596a5));
			titleLB.setVerticalTextPosition(JLabel.CENTER);
			titleLB.setFont(font);
			
			sizeLB = new JLabel("   history size 2023412 points ~ 0.03 mb", null, JLabel.LEFT);
			//sizeLB.setPreferredSize(new IntDimension(260, 11));
			sizeLB.setPreferredSize(new IntDimension(260, 12));
			sizeLB.setMinimumSize(new IntDimension(260, 12));
			//lb.setSize(new IntDimension(100, 16));
			
			var advProp2:ASFontAdvProperties = new ASFontAdvProperties(true, "advanced", "pixel");
			var font2:ASFont = new ASFont("Roboto Light", 9, true, false, false, advProp2);
			sizeLB.setTextFilters([new BlurFilter(1, 1, 3)]);
			sizeLB.setForeground(new ASColor(0x7596a5));
			sizeLB.setVerticalTextPosition(JLabel.BOTTOM);
			sizeLB.setFont(font2);
			
			m2 = new Shape();
			//m2.graphics.beginFill(0X75EA00, 0.5);
			m2.graphics.beginFill(0XFFFFFF, 0.5);
			//m2.graphics.drawRect(0, 4, 8, 3);
			m2.graphics.drawCircle(0, 0, 2);
			m2.graphics.endFill();
			m2.x = 2;
			m2.y = 6;
			//sizeLB.addChild(m2);
			
			
			var vfsd2:Form = new Form;
			vfsd2.addLeftHoldRow(0, titleLB);
			vfsd2.addLeftHoldRow(0, sizeLB).setPreferredHeight(16);
			
			addLeftHoldRow(0, classesListScP/*, scriptsTreeForm*/);
			var p:JPanel = new JPanel(new BorderLayout());
			//p.append(includeAllChB, BorderLayout.WEST);
			//p.append(ds2, BorderLayout.CENTER);
			addLeftHoldRow(0, 20, includeAllChB, 400, ds2);
			
			
			addLeftHoldRow(0, new OutputForm());
			
		}
		
		private function includeAllChBHandler(e:AWEvent):void 
		{
			var classes:Array = classesTableModel.getData();
			var val:Boolean = (e.currentTarget as JCheckBox).isSelected();
			for each (var item:Object in classes) 
			{
				item.optional = val;
			}
			classesTableModel.setData(classes);
		}
		
		
		private function buildSWC():void
		{
			asc = new ASCSH();
			asc.startShell();
			
			//bytecodeController.compile();
			//var configFilePath:String = "F:\\Projects\\projects\\flash\\studio\\Studio13\\src\\InjectionClass.xml";
			var configFilePath:String = "F:\\InjectionClass.xml";
			//var path3:String = "F:\\Projects\\projects\\flash\\studio\\studiolibs\\config2.xml";
			var sources:Vector.<String> = new Vector.<String>;
			//sources.push("F:\\Projects\\projects\\flash\\studio\\studiolibs\\org\\mixingloom");
			sources.push("F:\\Projects\\projects\\flash\\studio\\studiolibs");
			//sources.push("F:\\Projects\\projects\\flash\\studio\\studiolibs\\org");
			var arr:Array = classesTableModel.getData();
			var classNames:Vector.<String> = new Vector.<String>;
			for each (var item:Object in arr)
			{
				if(item.optional)
				classNames.push(item.type);	
			}
			
			// создать конфигурационный xml-файл
			var configText:String = ConfigurationMaker.createConfigFile(configFilePath, sources, classNames);
			
			var ba:ByteArray = new ByteArray();
			ba.writeMultiByte(configText, "utf-8");
			ba.position = 0;
			//MULTI_BYTE
			//AirMediator.writeToFile(configFilePath, ba, "utf-bytes", /*{configFilePath:configFilePath, outputPath:outputPath}*/null, onResult);
			AirMediator.writeToFile(configFilePath, ba, AirMediator.BYTES, null, onConfigFileComplete);
		}
		
		
		
		private function sendBuildCommand():void
		{
			//var configFilePath:String = obj.configFilePath;
			//var outputPath:String = obj.outputPath;
			//var outputPath:String = "F:\\Projects\\projects\\flash\\studio\\studiolibs\\ascb.swc";
			var outputPath:String = libPathTF.getText();
			//var path:String = "F:\\Projects\\projects\\flash\\studio\\Studio13\\src\\InjectionClass.xml";
			var path:String = "F:\\InjectionClass.xml";
			//var cmd3:* = new CompcCMD(config.nativePath, outputPath);
			var cmd3:* = new CompcCMD(path, outputPath);
			//cmd3.id = 1;
			//cmd.load_config = "application.xml";
			//cmd.load_config = "runtime_mxmlc_config.xml";
			//cmd.o = "F:/Projects/projects/flash/studio/Studio13/bin/generated404.swf";
			asc.runCommand(cmd3);
		}
		
		private function createIncludedClassesTableForm():void
		{
			this.classesTableModel = new IncludedClassesTableModel();
			
			classesTable = new IncludedClassesTable(classesTableModel);
			classesTable.setBorder(new EmptyBorder(null, new Insets(2, 3, 4, 3)));
			classesTable.setForeground(new ASColor(0xFFFFFF, 0.4));
			classesTable.setSelectionForeground(new ASColor(0xFFFFFF, 0.8));
			
			classesListScP = new JScrollPane(classesTable);
			//classesTable.setPreferredSize(new IntDimension(1010, 480));
			classesListScP.setPreferredSize(new IntDimension(1030, 300));
			classesListScP.setVerticalScrollBarPolicy(JScrollPane.SCROLLBAR_ALWAYS);
			classesListScP.setHorizontalScrollBarPolicy(JScrollPane.SCROLLBAR_AS_NEEDED);
		}
		
		//**************************************************** ☼ ОБРАБОТКА СОБЫТИЙ ***************************************
		
		private function createSWCBtnHander(e:AWEvent):void
		{
			buildSWC();
		}
		
		private function onConfigFileComplete(config:FileInfo):void
		{
			OutputForm.log("Config file written to " + config.nativePath);
			sendBuildCommand();
		}
		
		private function onFileSelect(e:AWEvent):void
		{
			//gtrace("3:" + fi.nativePath);
			//var libs:Array = librariesTable.getLibraries();
			var libs:Array;
			//rootFolder = _fileChooser.getSelectedFile();
			//arr = new Array;
			//recursiveWalk(rootFolder);
			//libs.push(_fileChooser.getSelectedFile());
			//librariesTable.setLibraries(libs);
			// загрузить выбранную swc-библиотеку
		}
		
		/**
		 * Обработчик выбора директории с кодом.
		 * @param	e
		 */
		private function openFileChooserBtnHander(e:AWEvent):void
		{
			//var frame:JFrame = _fileChooser.getDialogFrame();
			
			//var fr:FileReference = new FileReference();
			//fr.browse(FileFilter
			
			f = new File;
			f.addEventListener(Event.SELECT, onSourceFolderSelected);
			f.browseForDirectory("Choose a library directory");
			
			//if (extensions)
			//_fileChooser.setExtensions(["swc"]);
			/*_fileChooser.setFileSelectionMode(FileChooser.DIRECTORIES_ONLY);
			frame.changeOwner(AsWingManager.getRoot());
			frame.toFront();
			frame.setVisible(!frame.isVisible());
			frame.setLocationRelativeTo();
			//frame.changeOwner(Studio.instance.stage);
			if (frame.isVisible())
			{
				frame.addEventListener(PopupEvent.POPUP_CLOSED, onFileChooserClosed);
				_fileChooser.addActionListener(onFileSelect);
			}*/
		}
		
		private function onNewProject(e:SWCBuilderEvent):void 
		{
			var project:SWCBuilderProjectData = (e.data as SWCBuilderProjectData);
			OutputForm.log("Creating project " + project.dataName);
			var sdkPath:String = project.dataContainers.get("Current").sourcesFolder;
			//trace(sdkPath);
			//var file:File = new File(sdkPath);
			
			//rootFolder = FileInfo.fileInfoFromFile(file)
			rootFolder = AirMediator.getFile(sdkPath, null);
			arr = new Array;
			recursiveWalk(rootFolder);
			//var dso:IDataContainer = project.getDataContainer("Current");
			//trace(dso.collectDataFromContainer().sdkPath);
		}
		
		private function onSourceFolderSelected(e:Event):void 
		{
			var libs:Array;
			//rootFolder = _fileChooser.getSelectedFile();
			rootFolder = FileInfo.fileInfoFromFile(f)
			arr = new Array;
			recursiveWalk(rootFolder);
		}
		
		private function onFileChooserClosed(e:Event):void
		{
			//e.currentTarget.removeEventListener(PopupEvent.POPUP_CLOSED, onFileChooserClosed);
			//_fileChooser.removeActionListener(onFileSelect);
		}
		
		private function recursiveWalk(fi:FileInfo):void
		{
			AirMediator.getDirectory(fi.nativePath, findAllSources);
		}
		
		private function findAllSources(directory:FileInfo):void
		{
			for each (var item:FileInfo in directory.directoryListing)
			{
				if (item.isDirectory)
					recursiveWalk(item);
				else if (item.extension == "as")
				{
					//classesModel.append(item.name);
					
					var pat1:RegExp = /\\/gi;
					//var s:String = "12.345.67.89";
					//trace(s.replace(pat1,",")) //12,345,67,89
					var p:String = item.nativePath.replace(rootFolder.nativePath + "\\", "")
					//classesModel.append(item.nativePath.replace(pat1, "."));
					try
					{
						p = p.replace(pat1, ".")
					}
					catch (e:Error)
					{
						trace(e);
					}
					p = p.substring(0, p.length - 3); // remove extension(.as)
					p = rootFolder.name + "." + p; // имя корневой директории впереди файла
					//classesModel.append(p);
					//classesTableModel.d
					
					var formatter:DateFormat = new DateFormat("m.d.Y h:i");
					
					
					//arr.push({type: p, optional: true,  fileSize: item.size, mDate: item.modificationDate});
					arr.push({type: p, optional: true,  fileSize: item.size, mDate: formatter.format(item.modificationDate)});
				}
			}
			classesTableModel.setData(arr);
		}
	
	}

}