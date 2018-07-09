apackage devoron.aslc.moduls.project.data 
{
	import devoron.data.core.base.DataStructur;
	/**
	 * StudioProjectData
	 * @author Devoron
	 */
	public class SWCBuilderProjectDataSet extends DataStructur
	{
		
		public function SWCBuilderProjectDataSet() 
		{
			super(true, false, SWCBuilderProjectDataSet);
			super.dataType = "projectSet";
			super.dataName = "группа проектов " + int(Math.random()*30);
			//super.dataName = "ProjectsSet";
			
			 super._relatedObject = new Vector.<String>;
			 for (var i:int = 0; i < Math.random()*30; i++) 
			 {
				// должен быть либо полный путь к файлу проекта .as3live(или .as3l)
				// либо его uid, но это бред
				//в ProjectGroupsForm, как и 
				super._relatedObject.push("project " + i);
			 }
			 
		}
		
		
		/**
		 * Возвращает пути к файлам проектов.
		 */
		public function get studioProjectsSet():Vector.<String> {
			return super._relatedObject;
		}
		
		/**
		 * Возвращает пути к файлам проектов.
		 */
		public function set studioProjectsSet(projectsSet:Vector.<String>):void {
			super._relatedObject = projectsSet;
		}
		
	}

}