package devoron.dataui.multicontainers.simple
{
	import devoron.data.core.base.DefaultDataFactory;
	import devoron.data.core.base.SimpleDataComponent;
	import devoron.dataui.DataContainerTitleBar;
	import devoron.studio.core.workspace.components.dashboard.IDashboardComponent;
	import devoron.dataui.DataContainerForm;
	import devoron.components.labels.DSLabel;
	import devoron.components.comboboxes.DSComboBox;
	import devoron.data.core.base.IDataContainer;
	import devoron.data.core.base.DataStructurObject;
	import devoron.utils.ArrayNamesHelper;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.Container;
	import org.aswing.EmptyIcon;
	import org.aswing.event.AWEvent;
	import org.aswing.event.SelectionEvent;
	import org.aswing.event.TableCellEditEvent;
	import org.aswing.ext.Form;
	import org.aswing.ext.FormRow;
	import org.aswing.geom.IntDimension;
	import org.aswing.Icon;
	import org.aswing.JButton;
	import org.aswing.JOptionPane;
	import org.aswing.JScrollPane;
	import org.aswing.JSprH;
	import org.aswing.JToggleButton;
	import org.aswing.LoadIcon;
	import org.aswing.table.DefaultTableModel;
	import org.aswing.util.HashMap;
	import org.aswing.util.ObjectUtils;
	import org.aswing.VectorListModel;
	
	/**
	 * Множественный toogle-отображающий контейнер данных.
	 * @author Devoron
	 */
	public class DefaultDataContainersForm extends DataContainerForm implements IDashboardComponent
	{
		protected var supportedContainerFormClasses:Array;
		
		private var containerForms:HashMap;
		private var defaultDataFactory:DefaultDataFactory;
		
		//private var controlButtonsFR:FormRow;
		//private var btnsAndDataContainersFRs:HashMap;
		
		public function DefaultDataContainersForm(supportedContainerFormClasses:Array, dataContainerName:String = "", dataContainerType:String = "", dataContainerIcon:Icon = null, dataCollectionMode:String = DataContainerForm.SINGLE_COMPONENT_DATA_COLLECTION)
		{
			super(dataContainerName, dataContainerType, dataContainerIcon, dataCollectionMode);
			
			this.supportedContainerFormClasses = supportedContainerFormClasses;
			containerForms = new HashMap();
			defaultDataFactory = new DefaultDataFactory();
			//btnsAndDataContainersFRs = new HashMap();
			
			createContainerForms();
			
			//super.addLeftHoldRow(0, [0, 5]);
			
			var comps:Object = new Object();
			comps[dataContainerType] = this;
			super.setDataContainerChangeComponents(comps);
		}
		
		// нужно обозначить функции получения и установки значения для нестандартного компонента - DataContainersToogleForm
		
		override protected function getGetValueFunction(comp:*):Function
		{
			if (comp is DefaultDataContainersForm)
				return comp.getData;
			return super.getGetValueFunction(comp);
		}
		
		override protected function getSetValueFunction(comp:*):Function
		{
			if (comp is DefaultDataContainersForm)
				return comp.setData;
			return super.getSetValueFunction(comp);
		}
		
		public function getData():Array
		{
			var data:Array = new Array();
			var dataNames:Array = containerForms.keys();
			var container:DataContainerForm;
			for each (var dataName:String in dataNames)
			{
				gtrace("сбор данных внутри");
				container = containerForms.get(dataName);
				data.push({id: container.dataContainerName, data: container.collectDataFromContainer()});
			}
			return data;
		}
		
		public function setData(data:Object):void
		{
			var container:DataContainerForm;
			for each (var dataObject:*in data)
			{
				gtrace("установка данных внутрь");
				container = containerForms.get(dataObject.id);
				container.setDataToContainer(dataObject.data);
			}
		}
		
		public function addActionListener(listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			super.addEventListener(AWEvent.ACT, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeActionListener(listener:Function):void
		{
			super.removeEventListener(AWEvent.ACT, listener);
		}
		
		protected function createContainerForms():void
		{
			//controlButtonsFR = super.addLeftHoldRow(2, 0);
			
			// сбор дефолтных данных, создание форм-контейнеров и toogle-кнопок для каждого DataContainerForm
			var dataContainerBtn:JToggleButton;
			var data:DataStructurObject;
			var dataContainer:DataContainerForm;
			var containerFR:FormRow;
			
			/*for each (var containerFormClass:Class in supportedContainerFormClasses)
			   {
			   dataContainer = new containerFormClass();
			   data = dataContainer.collectDataFromContainer() as DataStructurObject;
			   data.dataName = dataContainer.dataContainerName;
			   data.dataType = dataContainer.dataContainerType;
			
			   containerFR = super.addLeftHoldRow(0, dataContainer);
			   defaultDataFactory.registerDataStructurObject(dataContainer.dataContainerName, data.clone());
			   dataContainer.addDataChangeListener(containerDataChangeHandler, null);
			   containerForms.put(dataContainer.dataContainerName, dataContainer);
			
			   dataContainerBtn = new JToggleButton("", dataContainer.icon);
			   dataContainerBtn.buttonMode = true;
			   dataContainerBtn.setSelected(true);
			   dataContainerBtn.addActionListener(dataContainerBtnHandler);
			   Container(controlButtonsFR.getComponent(0)).append(dataContainerBtn);
			
			   btnsAndDataContainersFRs.put(dataContainerBtn, containerFR);
			 }*/
			var fr:FormRow;
			
			for each (var containerFormClass:Class in supportedContainerFormClasses)
			{
				dataContainer = new containerFormClass();
				data = dataContainer.collectDataFromContainer() as DataStructurObject;
				
				defaultDataFactory.registerDataStructurObject(dataContainer.dataContainerName, data.clone());
				dataContainer.addDataChangeListener(containerDataChangeHandler, null);
				containerForms.put(dataContainer.dataContainerName, dataContainer);
				
				if (dataContainer is IDashboardComponent)
				{
					var form:Form = new Form();
					var titleLabel:DataContainerTitleBar = new DataContainerTitleBar((dataContainer as IDataContainer).dataContainerType.toUpperCase(), dataContainer.dataContainerIcon);
					titleLabel.setPreferredWidth(180);
					titleLabel.setWidth(180);
					form.addLeftHoldRow(0, titleLabel);
					
					titleLabel.metaData = form;
					
					var fr2:FormRow = form.addLeftHoldRow(0, IDashboardComponent(dataContainer).getDashboardComponent());
					fr = super.addLeftHoldRow(0, form);
					
					titleLabel.setRelatedDataContainer(dataContainer);
					titleLabel.setRelatedComponent(fr2);
				}
			}
		
		}
		
		/* INTERFACE devoron.gameeditor.core.IDashboardComponent */
		
		public function getDashboardComponent():Component
		{
			return this;
		}
		
		public function getDashboardMinimalComponent():Component
		{
			return new JToggleButton("", new EmptyIcon(20, 20));
		}
		
		//**************************************************** ♪ ОБРАБОТЧИКИ СОБЫТИЙ ***************************************		
		
		/**
		 * Слушатель нажатия кнопки отображения контейнера данных.
		 * @param	e
		 */ /*protected function dataContainerBtnHandler(e:AWEvent):void
		   {
		   var btn:JToggleButton = JToggleButton(e.currentTarget);
		   btnsAndDataContainersFRs.get(btn).setVisible(btn.isSelected());
		 }*/
		
		/**
		 * Обработчик изменения настроек выбранного материала.
		 * @param	obj
		 */
		private function containerDataChangeHandler(obj:DataStructurObject):void
		{
			/*var dataObject:Object = containersTable.getData()[containersTable.getSelectedRow()];
			   currentContainerForm.collectDataFromContainer(dataObject.data.data);
			 containersTable.dispatchEvent(new AWEvent(AWEvent.ACT));*/
			super.dispatchEvent(new AWEvent(AWEvent.ACT));
		}
	
	}

}
