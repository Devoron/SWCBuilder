package devoron.aslc.moduls.project.data 
{
	import devoron.data.core.base.DataStructur;
	/**
	 * SWCBuilderProjectData
	 * @author Devoron
	 */
	public class SWCBuilderProjectData extends DataStructur
	{
		
		public function SWCBuilderProjectData() 
		{
			super(true, false, SWCBuilderProjectData);
			super.dataType = "project";
			super.dataName = "Project";
		}
		
		public function set swcProject(project:SWCBuilderProject):void {
			super._relatedObject = project;
		}
		
		public function get swcProject():SWCBuilderProject {
			return super._relatedObject;
		}
		
	}

}