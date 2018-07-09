package devoron.dataui.singlecontainer.cbox
{
	import devoron.dataui.DataStructurForm;
	import devoron.data.core.base.IDataContainer;
	import devoron.dataui.DataContainerForm;
	import devoron.components.comboboxes.DSComboBox;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.event.AWEvent;
	import org.aswing.ext.Form;
	import org.aswing.ext.FormRow;
	import org.aswing.geom.IntDimension;
	import org.aswing.Icon;
	import org.aswing.JSprH;
	import org.aswing.JToggleButton;
	import org.aswing.VectorListModel;

	
	/**
	 * DataContainersComboboxForm
	 * @author Devoron
	 */ 
	public class DataContainersComboboxForm extends DataStructurForm/* implements IPropertiesPanelComponent*/
	{
		protected var containerTypesCB:DSComboBox;
		
		public function DataContainersComboboxForm(supportedContainerFormClasses:Vector.<Class>, dataStructurIcon:Icon = null, dataCollectionMode:String = "single")
		{
			super(dataCollectionMode);
			super.dataStructurIcon = dataStructurIcon;
			//super.addLeftHoldRow(0, [0, 10], new JSprH());
			
			super.supportedDataContainerClasses = supportedContainerFormClasses;
			
			createContainersComboBox(super);
			createDataContainerForms(super, 0, false);
			
			containerTypesCB.setSelectedIndex(0);
		}
		
		protected function createContainersComboBox(ownerForm:Form):void
		{
			containerTypesCB = new DSComboBox();
			containerTypesCB.setPreferredSize(new IntDimension(180, 24));
			containerTypesCB.addActionListener(containerTypesCBHandler);
			super.addLeftHoldRow(0, containerTypesCB);
		}
		
		override protected function createDataContainerForms(ownerForm:Form, gap:uint = 0, visible:Boolean = false):void
		{
			var dataContainer:*;
			var fr:FormRow;
			var dataContainerClass:Class;
			var dataContainerName:String;
			
			for each (dataContainerClass in supportedDataContainerClasses)
			{
				dataContainer = new dataContainerClass();
				dataContainerName = (dataContainer as IDataContainer).dataContainerName;
				
				fr = ownerForm.addLeftHoldRow(gap, dataContainer);
				fr.setVisible(visible);
				dataContainerFormRows.put(dataContainerName, fr);
				dataContainers.put(dataContainerName, dataContainer);
				containerNames.push(dataContainerName);
				
				(containerTypesCB.getModel() as VectorListModel).append(dataContainerName);
					//ownerForm.addLeftHoldRow(gap, [0, 10], new JSprH());
			}
		}
		
		/* INTERFACE devoron.gameeditor.core.IPropertiesPanelComponent */
		
		public function getDashboardComponent():Component
		{
			return this;
		}
		
		public function getDashboardMinimalComponent():Component 
		{
			return new JToggleButton("ds");
		}
		
		/**
		 * Обработчик выбора в комбобоксе.
		 * @param	e
		 */
		protected function containerTypesCBHandler(e:AWEvent):void
		{
			super.dataContainerChange(containerTypesCB.getSelectedItem(), true);
		}
	
	}
}