package devoron.components.multicontainers.ddb
{
	import devoron.components.buttons.DropDownButtonGroup;
	import devoron.dataui.DataContainerForm;
	import devoron.components.data.DataStructurForm;
	import devoron.components.labels.DSLabel;
	import devoron.components.buttons.DropDownButton;
	import devoron.components.comboboxes.DSComboBox;
	import devoron.studio.core.workspace.IPropertiesPanelComponent;
	import devoron.data.core.base.DataStructur;
	import devoron.data.core.DefaultDataFactory;
	import devoron.data.core.base.IDataContainer;
	import devoron.data.core.base.IDataContainersManage;
	import flash.events.Event;
	import org.aswing.Component;
	import org.aswing.event.AWEvent;
	import org.aswing.ext.Form;
	import org.aswing.ext.FormRow;
	import org.aswing.geom.IntDimension;
	import org.aswing.Icon;
	import org.aswing.JCheckBox;
	import org.aswing.JSpacer;
	import org.aswing.JSprH;
	import org.aswing.JToggleButton;
	import org.aswing.LoadIcon;
	import org.aswing.util.HashMap;
	import org.aswing.VectorListModel;
	import com.adobe.utils.ArrayUtil;
	
	/**
	 * Множественный Drop-Down-Button контейнер данных.
	 * ПЫЩ!! ПЫЩ!!!111Адин11адин11Адин1
	 * @author Devoron
	 */
	public class DataContainersDDBComboBoxForm extends DataContainerForm implements IPropertiesPanelComponent
	{
		private const BEHAVIOR_ICON:String = "../assets/icons/behavior_icon20.png";
		private var defaultDataFactory:DefaultDataFactory;
		protected var supportedContainerFormClasses:Array;
		protected var containersCB:DSComboBox;
		protected var containersCBModel:VectorListModel;
		protected var containersDDBGroup:DropDownButtonGroup;
		protected var containerNames:Array;
		
		public function DataContainersDDBComboBoxForm(supportedContainerFormClasses:Array, dataContainerName:String="", dataContainerType:String="", dataContainerIcon:Icon=null, dataCollectionMode:String=DataContainerForm.SINGLE_COMPONENT_DATA_COLLECTION)
		{
			super(dataContainerName, dataContainerType, dataContainerIcon, dataCollectionMode);
			this.supportedContainerFormClasses = supportedContainerFormClasses;
			
			defaultDataFactory = new DefaultDataFactory();
			containersCBModel = new VectorListModel();
			containerNames = new Array();
			
			containersCB = new DSComboBox();
			containersCB.setModel(containersCBModel);
			containersCB.setPreferredSize(new IntDimension(164, 24));
			containersCB.addActionListener(behaviorsCBHandler);
			super.addLeftHoldRow(0, containersCB);
			
			containersDDBGroup = new DropDownButtonGroup();
			super.addLeftHoldRow(0, containersDDBGroup);
			
			createDataContainerForms();
			
			// установить имена контейнеров в модель и сделать первый контейнер (TimeBehavior) активным
			containersCBModel.appendAll(ArrayUtil.createUniqueCopy(containerNames));
			//containersCB.setSelectedIndex(0);
			
			var comps:Object = new Object();
			comps[dataContainerType] = containersDDBGroup;
			super.setDataContainerChangeComponents(comps);
		}
		
		/* INTERFACE devoron.gameeditor.core.IPropertiesPanelComponent */
		
		public function getDashboardComponent():Component
		{
			return this;
		}
		
		public function getDashboardMinimalComponent():Component
		{
			return new JToggleButton("sh");
		}
		
		// нужно обозначить функции получения и установки значения для нестандартного компонента - SegmentedColorMiddlePointsComponent
		
		override protected function getGetValueFunction(comp:*):Function
		{
			if (comp is DropDownButtonGroup)
				return comp.getData;
			return super.getGetValueFunction(comp);
		}
		
		override protected function getSetValueFunction(comp:*):Function
		{
			if (comp is DropDownButtonGroup)
				return comp.setData;
			return super.getSetValueFunction(comp);
		}
		
		//**************************************************** ♪ ОБРАБОТЧИКИ СОБЫТИЙ ***************************************
		
		/**
		 * Обработчик выбора в комбобоксе поведения (behaviorsCB).
		 * Делает видимой разворачивающуюся кнопку данного поведения.
		 * Добавляет выбранное поведение.
		 * @param	e
		 */
		protected function behaviorsCBHandler(e:Event):void
		{
			var containerName:String = String(containersCB.getSelectedItem());
			containersDDBGroup.showContainer(containerName);
			containersCBModel.remove(containerName);
		}
		
		/**
		 * Обработчик смены состояния чекбокса разворачивающейся кнопки поведения.
		 * @param	e
		 */
		protected function containerStateChangeHandler(e:Event):void
		{
			var behaviorName:String = (e.currentTarget.parent as DropDownButton).getText();
			if ( !(e.currentTarget as JCheckBox).isSelected()) containersCBModel.append(behaviorName);
		}
		
		/**
		 * * Обработчик нажатия кнопки закрытия разворачивающейся кнопки поведения.
		 * @param	e
		 */
		protected function behaviorRemovingHandler(e:Event):void
		{
			//var behaviorDDB:DropDownButton = (e.currentTarget.parent as DropDownButton);
			//behaviorDDB.getParent().getParent().setVisible(false);
			//behaviorDDB.hideRelatedFormRow();
			//removeBehavior(behaviorDDB.getText());
		}
		
		//**************************************************** ☼ СОЗДАНИЕ КОМПОНЕНТОВ ***************************************	
		
		protected function createDataContainerForms(visible:Boolean = false):void
		{
			var containerForm:DataContainerForm;
			for each (var containerClass:Class in supportedContainerFormClasses) 
			{
				containerForm = new containerClass();
				containersDDBGroup.appendButton(containerForm.dataContainerName, containerForm);
				containerNames.push(containerForm.dataContainerName);
			}
			
		}
	
	}

}