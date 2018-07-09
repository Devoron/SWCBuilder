package devoron.aslc.moduls.project.current
{
	import devoron.aslc.events.SWCBuilderEvent;
	import devoron.aslc.events.SWCBuilderEventDispatcher;
	import devoron.aslc.moduls.project.data.SWCBuilderProjectData;
	import devoron.components.buttons.DSButton;
	import devoron.components.buttons.DSLabelButton;
	import devoron.components.buttons.DSTextField;
	import devoron.components.labels.DSLabel;
	import devoron.components.pcfs.PathChooserForm;
	import devoron.data.core.base.DataStructur;
	import devoron.data.core.base.ISerializeObserver;
	import devoron.data.core.serializer.serializers.DataStructurObjectSerializer;
	import devoron.dataui.DataContainerForm;
	import devoron.dataui.multicontainers.table.ContainersAssetsControlPanel;
	import devoron.dataui.multicontainers.table.IContainersControlPanel;
	import flash.events.Event;
	import org.aswing.border.EmptyBorder;
	import org.aswing.ButtonGroup;
	import org.aswing.components.containers.TablePane;
	import org.aswing.event.AWEvent;
	import org.aswing.ext.Form;
	import org.aswing.geom.IntDimension;
	import org.aswing.Insets;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.JTextField;
	
	/**
	 * ProjectForm
	 * @author Devoron
	 */
	public class CurrentProjectForm extends DataContainerForm implements ISerializeObserver
	{
		//[Embed(source="../../../../../assets/icons/commons/add_light_icon16.png")]
		//private const TRANSFORM_ICON:Class;
		
		private var nameTF:JTextField;
		private var packageTF:JTextField;
		private var parentTxt:JTextField;
		private var sdkPCF:PathChooserForm;
		private var tablePane:TablePane;
		private var includeLibrariesForm:Form;
		private var containersControlPanel:IContainersControlPanel;
		private var descriptionLbl:JLabel;
		private var projectTypesBG:ButtonGroup;
		private var containersControlPanel2:ContainersAssetsControlPanel;
		private var targetPlatformOptionPane:JPanel;
		private var libPathTF:DSTextField;
		private var newLibTF:DSTextField;
		private var sorcesPath:String = "F:\\Projects\\projects\\flash\\studio\\studiolibs\\ascb";
		private var jrePath:String = "C:\\Program Files (x86)\\Java\\jre1.8.0_60\\bin\\java.exe";
		
		public function CurrentProjectForm()
		{
			super("Current", "projectSettings", null/*new AssetIcon(new TRANSFORM_ICON)*/, "single", true);
			installComponents();
			super.setPreferredWidth(1050);
		}
		
		/* INTERFACE devoron.data.core.base.ISerializeObserver */
		
		public function setSerializedData(source:DataStructur, data:String):void 
		{
			
			// сообщить с помощью глобального диспетчера, что создан новый проект и передать его структу данных в событии
			SWCBuilderEventDispatcher.getInstance().dispatchEvent(new SWCBuilderEvent(SWCBuilderEvent.NEW_PROJECT, source));
		}
		
		private function installComponents():void
		{
			tablePane = new TablePane();
			tablePane.setVGap(2);
			tablePane.setColWidths(0, "*");
			
			//addLeftHoldRow(0, tablePane);
			addLeftHoldRow(0, [0, 100]);
			addLeftHoldRow(0, 200, tablePane);
			
			

			// имя проекта
			nameTF = new DSTextField("");
			nameTF.setPreferredHeight(24);
			nameTF.addEventListener(Event.CHANGE, onNameTxtChange);
			tablePane.addRow(false, ["Project name", nameTF]);
			
			// пакет проекта
			packageTF = new DSTextField("");
			packageTF.setPreferredHeight(26);
			tablePane.addRow(false, ["Project package", packageTF]);
			//tablePane.addRow(false, [0, 2]);

			// родительская папка проекта
			var javaPCF:PathChooserForm = new PathChooserForm();
			javaPCF.setFileSelectionMode(PathChooserForm.DIRECTORIES_ONLY);
			javaPCF.formRow1.setVisible(false);
			javaPCF.setPreferredHeight(26);
			javaPCF.setPathFieldWidth(400);
			tablePane.addRow();
			javaPCF.setPath(jrePath);
			tablePane.addRow(false, ["Path to java", javaPCF]);
			//sdkPCF.set
			
			// шаблон проекта
			//var templatePCF:PathChooserForm = new PathChooserForm();
			//templatePCF.formRow1.setVisible(false);
			
			// расположение SDK
			sdkPCF = new PathChooserForm();
			sdkPCF.formRow1.setVisible(false);
			sdkPCF.setPreferredHeight(26);
			sdkPCF.setPathFieldWidth(400);
			sdkPCF.setPath("F:\\AIRSDK_Compiler");
			
			tablePane.addRow(false, ["Path to SDK", sdkPCF]);
			tablePane.addRow();
			
			// output folder
			var sourcesPCF:PathChooserForm = new PathChooserForm();
			sourcesPCF.setPath(sorcesPath);
			sourcesPCF.setFileSelectionMode(PathChooserForm.DIRECTORIES_ONLY);
			
			sourcesPCF.formRow1.setVisible(false);
			sourcesPCF.setPreferredHeight(26);
			sourcesPCF.setPathFieldWidth(400);
			tablePane.addRow();
			tablePane.addRow(false, ["Sources folder", sourcesPCF]);
			
			// 7. output folder
			var outputPCF:PathChooserForm = new PathChooserForm();
			outputPCF.setFileSelectionMode(PathChooserForm.DIRECTORIES_ONLY);
			outputPCF.formRow1.setVisible(false);
			outputPCF.setPreferredHeight(26);
			outputPCF.setPathFieldWidth(400);
			tablePane.addRow();
			tablePane.addRow(false, ["Output SWC folder", outputPCF]);
			
			
			//var ds:DSButton = new DSButton("open folder", null, openFileChooserBtnHander, 100);
			
			this.newLibTF = new DSTextField();
			newLibTF.setPreferredSize(new IntDimension(400, 20));
			
			this.libPathTF = new DSTextField();
			libPathTF.setPreferredSize(new IntDimension(400, 20));
			
			libPathTF.setText("F:\\Projects\\projects\\flash\\studio\\studiolibs\\ascb.swc");
			
			
			
			// 7. подключенные библиотеки
			
			super.setDataContainerChangeComponents({name: nameTF, projectPackage: packageTF, javaPath: javaPCF, sourcesFolder: sourcesPCF, outputFolder: outputPCF, /*templatePath: templatePCF,*/ sdkPath: sdkPCF});
			
			
			tablePane.addRow(false, [1, 5]);
			
			
			addLeftHoldRow(0, [0, 20]);
			addLeftHoldRow(0, 420, new DSButton("create project", null, createProjectBtnHandler, 100, 24));
			
			
			addLeftHoldRow(0, [0, 100]);
			var urlsPanel:Form = new Form();
			urlsPanel.setTextRenderer(DSLabel);
			urlsPanel.addRightHoldRow(0, /*400,*/ "github", new DSLabelButton("github.com/devoron/swcbuilder"));
			urlsPanel.addRightHoldRow(0, /*400,*/ "authors");
			urlsPanel.addRightHoldRow(5, /*400,*/ "code",new DSLabelButton("Devoron"))
			urlsPanel.addRightHoldRow(5, /*400,*/ "desing", new DSLabelButton("Chivendu"))
			urlsPanel.setMinimumWidth(1050);
			//urlsPanel.setPreferredWidth(250);
			urlsPanel.setAlpha(0.4);
			addLeftHoldRow(0,  /*400,*/ urlsPanel);
			
			//createLibrariesForm();
			//createNativeExtensionsForm();
			
			setBorder(new EmptyBorder(null, new Insets(5, 5, 5, 5)));
		}
		
		private function createProjectBtnHandler(e:AWEvent):void 
		{
			var obj:Object = super.collectDataFromContainer();
			//trace(obj);
			//dispatchEvent(new SWCBuilderEvent);
			
			var dsoSerializer:DataStructurObjectSerializer = new DataStructurObjectSerializer();
			//dsoSerializer.serializePart(
			
			var projectDataStructur:SWCBuilderProjectData = new SWCBuilderProjectData();
			projectDataStructur.dataName = nameTF.getText();
			projectDataStructur.addDataContainer(this);
			projectDataStructur.addSerializeObserver(this);
			projectDataStructur.serializable = true;
			//projectDataStructur.serialize();
			//dataProcessorsDomain.getDataProcessor(getUID()).registerDataModuls(dataModuls);
			//dataProcessorsDomain.getDataProcessor(getUID()).processData(dataStructur, null);
			
			//dataStructur.serializable = true;
		}
		
		private function onNameTxtChange(e:Event):void
		{
		/*createBtn.setEnabled(/^[a-z]\w*$/i.test(nameTF.getText()) > 0);
		   if (createBtn.isEnabled())
		 packageTF.setText("com." + nameTF.getText().toLowerCase());*/
		}
		
		
	}

}