package devoron.aslc.moduls.project 
{
	import devoron.aslc.events.SWCBuilderEvent;
	import devoron.aslc.events.SWCBuilderEventDispatcher;
	import devoron.aslc.moduls.project.current.CurrentProjectForm;
	import devoron.aslc.moduls.project.data.SWCBuilderProjectData;
	import devoron.aslc.moduls.project.recent.RecentProjectsForm;
	import devoron.components.buttons.AboutButton;
	import devoron.components.labels.DSLabel;
	import devoron.dataui.DataContainerForm;
	import devoron.utils.airmediator.AirMediator;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import org.aswing.AssetIcon;
	import org.aswing.ButtonGroup;
	import org.aswing.event.AWEvent;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.layout.BorderLayout;
	import org.aswing.layout.FlowLayout;
	import org.aswing.util.HashMap;
	
	/**
	 * ProjectsProviderForm
	 * @author Devoron
	 */
	public class ProjectsProviderForm extends DataContainerForm
	{
		[Embed(source="../../../../../assets/icons/commons/project_icon.png")]
		private const PROJECT_ICON:Class;
		
		private var bg:ButtonGroup;
		private var hash:HashMap;
		private var contentContainer:JPanel;
		
		public function ProjectsProviderForm() 
		{
			super("Projects", "projects", new AssetIcon(new PROJECT_ICON));
			bg = new ButtonGroup(false, 0, true);
			bg.addActionListener(onAct);
			var modulComponents:Vector.<DataContainerForm> = new Vector.<DataContainerForm>();
			modulComponents.push(new CurrentProjectForm());
			modulComponents.push(new RecentProjectsForm());
			
			
			var pan:JPanel = new JPanel(new FlowLayout());
			hash = new HashMap();
			var btn:AboutButton;
			for each (var item:DataContainerForm in modulComponents) 
			{
				btn = new AboutButton(item.dataContainerName);
				pan.append(btn);
				bg.append(btn);
				hash.put(item.dataContainerName, item);
				btn.setEnabled(true);
				btn.setPreferredHeight(24);
			}
			
			
			var lb:JLabel = new DSLabel("Projects");
			lb.setFont(lb.getFont().changeSize(14));
			addLeftHoldRow(0, lb);
			
			addLeftHoldRow(0, pan);
			contentContainer = new JPanel(new BorderLayout());
			addLeftHoldRow(0, contentContainer);
			contentContainer.setPreferredWidth(1050);
			
			bg.setSelectedIndex(0);
			
			SWCBuilderEventDispatcher.getInstance().addEventListener(SWCBuilderEvent.NEW_PROJECT, onNewProject);
		}
		
		private function onNewProject(e:SWCBuilderEvent):void 
		{
			var project:SWCBuilderProjectData = (e.data as SWCBuilderProjectData);
			//OutputForm.log("Creating project " + project.dataName);
			var sdkPath:String = project.dataContainers.get("Current").sourcesFolder;
			//trace(data);
			
			// сохранить сериализованные данные в файл
			
			var ba:ByteArray = new ByteArray();
			ba.writeMultiByte(project.dataCode, "utf-8");
			ba.position = 0;
			
			AirMediator.writeToFile("F:/swcprojects/"+project.dataName+".swcf", ba, AirMediator.UTF_BYTES);
			
			//trace(sdkPath);
			//var file:File = new File(sdkPath);
			
			//rootFolder = FileInfo.fileInfoFromFile(file)
			/*rootFolder = AirMediator.getFile(sdkPath, null);
			arr = new Array;
			recursiveWalk(rootFolder);*/
			//var dso:IDataContainer = project.getDataContainer("Current");
			//trace(dso.collectDataFromContainer().sdkPath);
		}
		
		private function onAct(e:AWEvent):void 
		{
			var form:DataContainerForm = hash.get(bg.getSelectedButtonText()) as DataContainerForm;
			if (form) {
				contentContainer.removeAll();
				contentContainer.append(form, BorderLayout.WEST);
				//form.revalidate();
				//contentContainer.pack();
				
			}
		}
		
	}

}