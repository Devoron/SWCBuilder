package devoron.aslc.moduls.project.recent
{
	import devoron.aslc.events.SWCBuilderEvent;
	import devoron.aslc.events.SWCBuilderEventDispatcher;
	import devoron.aslc.moduls.project.data.SWCBuilderProjectData;
	import devoron.aslc.moduls.project.data.SWCBuilderProjectParser;
	import devoron.aslc.moduls.project.ProjectsTable;
	import devoron.dataui.DataContainerForm;
	import devoron.dataui.DataStructursTable;
	import devoron.dataui.DataStructursTableModel;
	import devoron.file.FileInfo;
	import devoron.utils.airmediator.AirMediator;
	import flash.utils.ByteArray;
	import org.aswing.EmptyIcon;
	//import devoron.studio.core.workspace.components.dashboard.IDashboardComponent;
	import devoron.union.infoprocesses.manager.RSSIcon;
	import org.aswing.Component;
	import org.aswing.Container;
	import org.aswing.geom.IntDimension;
	import org.aswing.JScrollPane;
	
	/**
	 * RecentProject
	 * @author Devoron
	 */
	public class RecentProjectsForm extends DataContainerForm /*implements IDashboardComponent*/
	{
		private var recentProjectsTable:DataStructursTable;
		private var recentProjectsTableScP:JScrollPane;
		private var recentProjectsTableModel:DataStructursTableModel;
		private var recentProjects:Array;
		private var projectsTable:ProjectsTable;
		
		public function RecentProjectsForm()
		{
			super("Recent projects", "projects", new EmptyIcon(16,16));
			
			projectsTable = new ProjectsTable("", null, SWCBuilderProjectData);
			//projectsTable.setMaximumSize(new IntDimension(880, 615))
			projectsTable.setPreferredSize(new IntDimension(880, 615))
			var scrollPane:JScrollPane = new JScrollPane(projectsTable, JScrollPane.SCROLLBAR_ALWAYS, JScrollPane.SCROLLBAR_NEVER);
			scrollPane.setPreferredSize(new IntDimension(900, 615));
			addLeftHoldRow(0, scrollPane);
			
			setPreferredSize(new IntDimension(900, 615));
			
			SWCBuilderEventDispatcher.getInstance().addEventListener(SWCBuilderEvent.NEW_PROJECT, onNewProject);
			
			AirMediator.getDirectory("F:/swcprojects/", onResult, true);
			
			
			super.setDataContainerChangeComponents( { projects:projectsTable } );
		}
		
		private function onResult(projectsDir:FileInfo):void 
		{
			var files:Array = projectsDir.directoryListing;
			var fi:FileInfo;
			for (var i:int = 0; i < files.length; i++) 
			{
				var serializedData = JSON.parse(files[i].data);
				var data:ByteArray = (files[i].data as ByteArray);
				var str:String = data.readUTFBytes(data.length);
				//trace(serializedData);
				var parser:SWCBuilderProjectParser = new SWCBuilderProjectParser();
				parser.parseAsync(str);
				
			}
			
			
		}
		
		private function onNewProject(e:SWCBuilderEvent):void 
		{
			trace("добавить новый проект");
			var projects:Array = projectsTable.getProjects();
			projects.push(e.data);
			projectsTable.setProjects(projects);
		}
		
		// нужно обозначить функции получения и установки значения для нестандартного компонента - из таблицы -set-функций и public свойств
		
		override protected function getGetValueFunction(comp:*):Function
		{
			if (comp is ProjectsTable)
				return comp.getDataStructurs;
			return super.getGetValueFunction(comp);
		}
		
		override protected function getSetValueFunction(comp:*):Function
		{
			if (comp is ProjectsTable)
				return comp.setDataStructurs;
			return super.getSetValueFunction(comp);
		}
		
		
		public function setOwnerContainer(ownerContainer:Container):void
		{
			//ownerContainer.append(getContentPane(), {layout: StudioWorkspaceLayout.MENU_ITEM, icon: getMenuIcon(), title: getMenuText(), listener: getMenuListener()});
			//ownerContainer.append(getToolbarComponent(), {layout: StudioWorkspaceLayout.TOOLBAR});
		}
		
		
		/* INTERFACE devoron.studio.core.IDashboardComponent */
		
		public function getDashboardComponent():Component 
		{
			return this;
		}
		
		public function getDashboardMinimalComponent():Component 
		{
			return null;
		}
		
		
	
	}

}