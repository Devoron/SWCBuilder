package devoron.dataui.multicontainers.timeline 
{
	import devoron.dataui.multicontainers.table.DataContainersTableForm;
	import devoron.dataui.DataContainerForm;
	//import devoron.studio.mesheditor.material.ColorMaterialForm;
	import org.aswing.LoadIcon;
	/**
	 * ...
	 * @author Devoron
	 */
	public class TimelineTrackForm extends DataContainersTableForm
	{
		private const MATERIAL_ICON:String = "../assets/icons/material_icon20.png";
		
		public function TimelineTrackForm() 
		{
			super([], "ModifiersContainer", "modifier", new LoadIcon(MATERIAL_ICON), DataContainerForm.SINGLE_COMPONENT_DATA_COLLECTION, false);
		}
		
	}

}