package devoron.dataui.multicontainers.toogle
{
	import devoron.data.core.base.DefaultDataFactory;
	import devoron.data.core.base.SimpleDataComponent;
	import devoron.studio.core.workspace.components.dashboard.IDashboardComponent;
	import devoron.components.buttons.AboutButtonUI2;
	import devoron.components.labels.DSLabel;
	import devoron.components.comboboxes.DSComboBox;
	import devoron.dataui.DataContainerForm;
	import devoron.data.core.base.DataStructurObject;
	import devoron.utils.ArrayNamesHelper;
	import org.aswing.AbstractButton;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.Container;
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
	public class DataContainersToogleForm extends DataContainerForm implements IDashboardComponent
	{
		protected var supportedContainerFormClasses:Array;
		
		protected var containerForms:HashMap;
		protected var defaultDataFactory:DefaultDataFactory;
		protected var controlButtonsFR:FormRow;
		protected var btnsAndDataContainersFRs:HashMap;
		
		public function DataContainersToogleForm(supportedContainerFormClasses:Array, dataContainerName:String = "", dataContainerType:String = "", dataContainerIcon:Icon = null, dataCollectionMode:String = DataContainerForm.SINGLE_COMPONENT_DATA_COLLECTION)
		{
			super(dataContainerName, dataContainerType, dataContainerIcon, dataCollectionMode);
			
			this.supportedContainerFormClasses = supportedContainerFormClasses;
			containerForms = new HashMap();
			defaultDataFactory = new DefaultDataFactory();
			btnsAndDataContainersFRs = new HashMap();
			
			createContainerForms();
			
			super.addLeftHoldRow(0, [0, 5]);
			
			var comps:Object = new Object();
			comps[dataContainerType] = this;
			super.setDataContainerChangeComponents(comps);
		}
		
		// нужно обозначить функции получения и установки значения для нестандартного компонента - DataContainersToogleForm
		
		override protected function getGetValueFunction(comp:*):Function
		{
			if (comp is DataContainersToogleForm)
				return comp.getData;
			return super.getGetValueFunction(comp);
		}
		
		override protected function getSetValueFunction(comp:*):Function
		{
			if (comp is DataContainersToogleForm)
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
			controlButtonsFR = super.addLeftHoldRow(5, 0);
			
			// сбор дефолтных данных, создание форм-контейнеров и toogle-кнопок для каждого DataContainerForm
			var dataContainerBtn:JToggleButton;
			var data:DataStructurObject;
			var dataContainer:DataContainerForm;
			var containerFR:FormRow;
			
			for each (var containerFormClass:Class in supportedContainerFormClasses)
			{
				dataContainer = new containerFormClass();
				data = dataContainer.collectDataFromContainer() as DataStructurObject;
				data.dataName = dataContainer.dataContainerName;
				data.dataType = dataContainer.dataContainerType;
				
				containerFR = super.addLeftHoldRow(0, dataContainer);
				defaultDataFactory.registerDataStructurObject(dataContainer.dataContainerName, data.clone());
				dataContainer.addDataChangeListener(containerDataChangeHandler, null);
				containerForms.put(dataContainer.dataContainerName, dataContainer);
				
				dataContainerBtn = createControlButton(dataContainer.dataContainerIcon) as JToggleButton;
				
				Container(controlButtonsFR.getComponent(0)).append(dataContainerBtn);
				
				btnsAndDataContainersFRs.put(dataContainerBtn, containerFR);
			}
		}
		
		protected function createControlButton(ico:Icon):AbstractButton
		{
			var btn:JToggleButton = new JToggleButton("", ico);
			btn.setPreferredSize(new IntDimension(30, 30));
			btn.setUI(new AboutButtonUI2());
			btn.buttonMode = true;
			btn.setSelected(true);
			btn.addActionListener(dataContainerBtnHandler);
			return btn;
		}
		
		
		public function getDashboardComponent():Component 
		{
			return this;
		}
		
		public function getDashboardMinimalComponent():Component 
		{
			return new JToggleButton("ds");
		}
		
		//**************************************************** ♪ ОБРАБОТЧИКИ СОБЫТИЙ ***************************************		
		
		/**
		 * Слушатель нажатия кнопки отображения контейнера данных.
		 * @param	e
		 */
		protected function dataContainerBtnHandler(e:AWEvent):void
		{
			var keys:Array = btnsAndDataContainersFRs.keys();
			/**
			 *
			 *
			 *
			 * СТРАШНЫЙ КОСТЫЛЬ
			 *
			 */
			for (var i:int = 0; i < keys.length; i++)
			{
				btnsAndDataContainersFRs.get(keys[i]).setVisible(false);
			}
			
			var btn:JToggleButton = JToggleButton(e.currentTarget);
			btnsAndDataContainersFRs.get(btn).setVisible(btn.isSelected());
		}
		
		public function setSelected(id:int)
		{
			var keys:Array = btnsAndDataContainersFRs.keys();
			/**
			 *
			 *
			 *
			 * СТРАШНЫЙ КОСТЫЛЬ
			 *
			 */
			for (var i:int = 0; i < keys.length; i++)
			{
				btnsAndDataContainersFRs.get(keys[i]).setVisible(false);
			}
			
			//var btn:JToggleButton = JToggleButton(e.currentTarget);
			btnsAndDataContainersFRs.get(keys[id]).setVisible(true);
		}
		
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
