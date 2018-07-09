package devoron.components.multicontainers.tabbedpane
{
	import devoron.components.buttons.DSButton;
	import devoron.components.comboboxes.DSComboBox;
	import devoron.dataui.DataContainerForm;
	import devoron.components.data.GetSetFunctionsHash;
	import devoron.components.labels.DSLabel;
	import devoron.components.menus.CircleMenu;
	import devoron.components.multicontainers.table.ContainersAssetsControlPanel;
	import devoron.components.multicontainers.table.DataContainersTable;
	import devoron.components.multicontainers.table.DataContainersTableModel;
	import devoron.components.multicontainers.table.IContainersControlPanel;
	import devoron.data.core.DataObjectsHash;
	import devoron.data.core.base.DataStructurObject;
	import devoron.data.core.DefaultDataFactory;
	import devoron.data.core.SimpleDataComponent;
	import devoron.studio.core.scenebrowser.CircleButton;
	import devoron.studio.tools.clipboard.ClipboardManager;
	import devoron.utils.ArrayNamesHelper;
	import devoron.utils.gtrace;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import org.aswing.ButtonGroup;
	import org.aswing.Component;
	import org.aswing.Container;
	import org.aswing.event.AWEvent;
	import org.aswing.event.SelectionEvent;
	import org.aswing.event.TableCellEditEvent;
	import org.aswing.ext.Form;
	import org.aswing.ext.FormRow;
	import org.aswing.ext.GridList;
	import org.aswing.Icon;
	import org.aswing.JButton;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
	import org.aswing.JSeparator;
	import org.aswing.JSpacer;
	import org.aswing.JTable;
	import org.aswing.JToggleButton;
	import org.aswing.table.DefaultTableModel;
	import org.aswing.util.HashMap;
	import org.aswing.VectorListModel;
	
	/**
	 * Множественный табличный контейнер данных.
	 * @author Devoron
	 */
	public class DataContainersTabbedPaneForm extends DataContainerForm
	{
		private const WARNING_ICON:String = "../assets/icons/warning_icon20.png";
		protected var supportedContainerFormClasses:Array = [];
		
		protected var addContainerBtn:JButton;
		protected var removeContainerBtn:JButton;
		protected var copyContainerBtn:JButton;
		protected var containerTypesCB:DSComboBox;
		protected var currentContainerFR:FormRow;
		
		protected var containerForms:HashMap;
		public var defaultDataFactory:DefaultDataFactory;
		
		protected var containersTP:DataContainersTabbedPane;
		protected var containersTableScP:JScrollPane;
		private var containersTabbedPaneForm:Form;
		private var showFullFormBtn:JToggleButton;
		private var fullFormFR:FormRow;
		private var containersTableFR:FormRow;
		protected var containersTableModel:DefaultTableModel;
		private var currentContainerForm:DataContainerForm;
		protected var currentContainerIdSDC:SimpleDataComponent;
		private var oneMinimum:Boolean;
		private var fullForm:Form;
		private var buttonsPanel:JPanel;
		private var buttonsGroup:ButtonGroup;
		//private var buttonsSP:ButtonsViewport;
		private var buttonsSP:JScrollPane;
		private var model:VectorListModel;
		private var containersGridList:GridList;
		private var addItemBtn:CircleButton;
		private var circleMenu:CircleMenu;
		private var showContainersGridListBtn:JToggleButton;
		private var containersGridListSP:JScrollPane;
		
		protected var separator:JSeparator;
		protected var lastSpacer:JSpacer;
		
		protected var dataObjects:Array;
		protected var containersControlPanel:IContainersControlPanel;
		protected var controlPanelFR:FormRow;
		
		/**
		 *
		 * @param	supportedContainerFormClasses
		 * @param	dataContainerName
		 * @param	dataContainerType
		 * @param	dataContainerIcon
		 * @param	dataCollectionMode
		 * @param	oneMinimum Необходимо минимум одно значение иметь в списке.
		 */
		public function DataContainersTabbedPaneForm(supportedContainerFormClasses:Array, dataContainerName:String = "", dataContainerType:String = "", dataContainerIcon:Icon = null, dataCollectionMode:String = DataContainerForm.SINGLE_COMPONENT_DATA_COLLECTION, oneMinimum:Boolean = true, containersPanel:IContainersControlPanel = null)
		{
			super(dataContainerName, dataContainerType, dataContainerIcon, dataCollectionMode);
			this.containersControlPanel = containersPanel;
			this.oneMinimum = oneMinimum;
			this.supportedContainerFormClasses = supportedContainerFormClasses;
			
			dataObjects = new Array();
			
			if (!containersControlPanel)
			{
				
			}
			
			super.setTextRenderer(DSLabel);
			
			containerForms = new HashMap();
			defaultDataFactory = new DefaultDataFactory();
			
			currentContainerIdSDC = new SimpleDataComponent(0);
			
			// create all components: control panel, tabbed pane and add to modul form
			installComponents();
			
			var comps:Object = new Object();
			comps["selectedId"] = currentContainerIdSDC;
			comps[dataContainerType] = containersTP;
			//super.setDataContainerChangeComponents(comps);
		
			//containersTP.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			//containersTP.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
		
			// нужно добавление контейнеров групп
			// чтобы можно было переключиться между типами - базовая геометрия, внешняя, + группа, добавленная из AssetManager'a - например, дома, деревья, машины
		}
		
		protected function setControlPanel(controlPanel:IContainersControlPanel):void
		{
			containersControlPanel = new ContainersAssetsControlPanel(dataContainerType);
			//containersControlPanel.addIContentViewListener(contentChange);
			containersControlPanel.addActionListener(selectContentViewListener);
			(containersControlPanel as ContainersAssetsControlPanel).selectedLB.addActionListener(showContainersTableBtnHandler);
		}
		
		protected function installComponents():void
		{
			//createContainersComboBox();
			//createContainersButtons();
			//createContainersGridList();
			
			fullForm = new Form();
			
			//controlPanelFR = super.addLeftHoldRow(0, containersControlPanel.getControlPanel());
			//containerTypesCB.setSelectedIndex(0);
			//buttonsGroup.setSelectedIndex(0);
			//containersGridList.setSelectedIndex(0);
			
			//createContainersTableForm();
			
			//lastSpacer = new JSpacer(new IntDimension(0, 5));
			fullFormFR = super.addLeftHoldRow(0, fullForm);
			// пустой ряд, в который будет устанавливаться текущая форма материала
			
			currentContainerFR = fullForm.addLeftHoldRow(0, 0);
			
			//super.addLeftHoldRow(0, 0)
			
			//showFullFormBtn.setRelatedComponent(currentContainerFR);
			//showLightPickerManagerBtn.setRelatedObject(lightPickerManager, "popupOpened", lightPickerManager.show, "popupClosed", lightPickerManager.hide);
			
			createContainerForms();
		
		}
		
		//private var dcf:DataContainersForm;
		
		public function setContainersControlPanel(controlPanel:IContainersControlPanel):void
		{
			if (controlPanel == null)
			{
				if (containersControlPanel)
				{
					containersControlPanel.getControlPanel().removeFromContainer();
					//containersControlPanel.getControlPanel() = null;
					controlPanelFR.setVisible(false);
				}
					//controlPanelFR.
					//containersControlPanel.getControlPanel()
			}
		}
		
		protected function createContainerForms():void
		{
			// заполнение комбобокса типами материалов, сбор дефолтных данных, создание форм-контейнеров
			var data:DataStructurObject;
			var containerForm:DataContainerForm;
			var model:VectorListModel = new VectorListModel();
			
			for each (var containerFormClass:Class in supportedContainerFormClasses)
			{
				/*containerForm = new containerFormClass();
				   data = containerForm.collectDataFromContainer() as DataStructurObject;
				   data.dataName = containerForm.dataContainerName;
				   data.dataType = containerForm.dataContainerType;
				
				   defaultDataFactory.registerDataStructurObject(containerForm.dataContainerName, data);
				   containerForm.addDataChangeListener(containerDataChangeHandler, null);
				   containerForms.put(containerForm.dataContainerName, containerForm);*/
					   //(containerTypesCB.getModel() as VectorListModel).append(containerForm.dataContainerName);
					   //appendContainerButton(containerForm.dataContainerName, containerForm.icon);
					   //model.append(containerForm);
					   //model.append(containerForm);
			}
		
			//containersControlPanel.setContainersModel(model);
			//containersControlPanel.setData(
		/*dcf.containersGridList.setModel(dcf.model);
		   dcf.containersGridList.setSelectedIndex(0);
		   dcf.containersGridList.repaintAndRevalidate();*/
		
			   // установить модель в компонент отображения
			   // установить выбранное значение
		}
		
		protected function getNewDataName():String
		{
			//return ArrayNamesHelper.createNewOrdinalName(containersTP.getData(), "name", _dataContainerType)
			return "new name";
		}
		
		// нужно обозначить функции получения и установки значения для нестандартного компонента - containersTable
		
		override public function setDataToContainer(data:Object):void
		{
			super.setDataToContainer(data);
			if (containersControlPanel)
				containersControlPanel.setData(data[_dataContainerType]);
			//containersControlPanel.setData(data.material as Array);
			//containersControlPanel.setData(data.geometry as Array);
			//var dataObjects:Array = containerwsTable.getData();
		/*if (dataObjects.length > data.selectedId)
		   containersTP.getSelectionModel().setSelectionInterval(data.selectedId, data.selectedId);*/
		}
		
		override public function collectDataFromContainer(data:Object = null):Object
		{
			// если в таблице нет ни одного элемента, а по умолчанию должен быть как минимум один всегда
			// например, у меша ВСЕГДА должна быть геометрия и материал, матрица трансформации
			
			if (containersTP)
			{
				if (containersTP.getData().length == 0 && oneMinimum)
				{
					containersControlPanel.setSelectedValueIndex(0);
					addContainerBtnHandler(new AWEvent(AWEvent.ACT));
				}
			}
			
			data = data == null ? new DataStructurObject() : data;
			data.dataName = _dataContainerName;
			data.dataType = _dataContainerType;
			data.dataLiveMode = _dataLiveMode;
			
			//dataStructurObject.active = _active;
			//dataStructurObject.useUrls = _useUrls;
			var value:*;
			
			for (var prop:String in propsAndComps)
			{
				var comp:* = propsAndComps[prop];
				
				if (comp is DataContainersTable)
				{
					value = (comp as DataContainersTable).getData();
				}
				else if (comp is SimpleDataComponent)
				{
					value = (comp as SimpleDataComponent).getData();
				}
				else
				{
					if (!getValueFunctions.get(comp))
					{
						var func:Function = GetSetFunctionsHash.getSetValueFunction(comp);
						if (func != null)
						{
							getValueFunctions.put(comp, func);
							func.call();
						}
					}
					else
					{
						value = (getValueFunctions.get(comp) as Function).call();
					}
				}
				
				//if(data
				data[prop] = value;
					//data[prop] = null;
			}
			return data;
		}
		
		public function getModel():DefaultTableModel
		{
			return containersTableModel;
		}
		
		public function setModel(model:DefaultTableModel):void
		{
			containersTableModel = model;
			model.setData(dataObjects);
			//containersTP.setModel(model);
		}
		
		/*	override public function collectDataFromContainer(data:Object = null):Object
		   {
		   if (containersTable.getData().length == 0 && oneMinimum)
		   {
		   containersControlPanel.setSelectedValueIndex(0);
		   addContainerBtnHandler(new AWEvent(AWEvent.ACT));
		   }
		
		   return super.collectDataFromContainer(data);
		   }*/
		
		/* INTERFACE devoron.gameeditor.core.IPropertiesPanelComponent */
		
		public function getDashboardComponent():Component
		{
			return this;
		}
		
		public function getDashboardMinimalComponent():Component
		{
			return new JToggleButton("ds");
		}
		
		//**************************************************** ♪ ОБРАБОТЧИКИ СОБЫТИЙ ***************************************		
		
		private function showFullFormBtnHandler(e:AWEvent):void
		{
			fullFormFR.setVisible(showFullFormBtn.isSelected());
		}
		
		private function onFocusOut(e:FocusEvent):void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onFocusIn(e:FocusEvent):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			if ((e.keyCode == Keyboard.C) && e.ctrlKey)
			{
				gtrace("нужно скопировать элементы из таблицы");
				var selectedRows:Array = (containersTP as JTable).getSelectedRows();
				var data:Array = containersTableModel.getData();
				var saved:Array = [];
				for each (var item:uint in selectedRows)
				{
					//saved.push((data[item] as DataStructurObject).clone());
					saved.push(data[item]);
				}
				
				/*	if (comp is DataContainersTable)
				   {
				   value = (comp as DataContainersTable).getData();
				   }*/
				ClipboardManager.instance.copyFromDataContainersTable(saved, _dataContainerType);
			}
			if ((e.keyCode == Keyboard.V) && e.ctrlKey)
			{
				gtrace("нужно вставить элементы в таблицу");
				var data2:Array = ClipboardManager.instance.pasteToDataContainersTable(_dataContainerType) as Array;
				if (data2)
				{
					var arr:Array = containersTableModel.getData();
					for each (var item2:* in data2)
					{
						//arr.push(item2)
						var n:String = getNewDataName();
							//var obj:* = ObjectUtils.cloneObject(item2);
						/*arr.push(obj);
						   dataObjects.push(obj);*/
							   //item2.name = n;
							   //addData(obj.data.data);
					}
					
					active = false;
					containersTableModel.setData(arr);
					active = true;
				}
					// если тип таблицы соответствует массиву, который содержится в Clipboard, то можно установить его
					//containersTable as JTabl
					//Clipboard.instance.
			}
		}
		
		/**
		 * Обработчик изменения настроек выбранного контейнера.
		 * @param	obj
		 */
		protected function containerDataChangeHandler(obj:DataStructurObject):void
		{
		/*var selId:int = containersTP.getSelectedRow();
		   if (selId == -1)
		   return;*/
		
			   //var dataObjects:Array = containersTable.getData();
			   //var dataObjects:Array = containersTable.getData();
			   //dataObjects
		/*var dataObject:Object = dataObjects[selId];
		   currentContainerForm.collectDataFromContainer(dataObject.data.data);
		   containersTP.dispatchEvent(new AWEvent(AWEvent.ACT));*/
		}
		
		private function addContainerBtnHandler(e:AWEvent):void
		{
		/*if (containerTypesCB.getSelectedIndex() == -1)
		   return;*/
		
			   //var containerForm:DataContainerForm = containerForms.get(containerTypesCB.getSelectedItem());
			   //var containerForm:DataContainerForm = containerForms.get((buttonsGroup.getSelectedButton() as ScriptButton).getNativePath());
			   //var containerForm:DataContainerForm = dcf.containersGridList.getSelectedValue();
		/*var containerForm:DataContainerForm = containersControlPanel.getSelectedValue();
		   var dataName:String = containerForm.dataContainerName;
		   var data:DataStructurObject = defaultDataFactory.getData(dataName);
		   containerForm.setDataToContainer(data);*/
		
			   //var dataObjects:Array = containersTable.getData();
		/*dataObjects.push({name: getNewDataName(), data: {id: dataName, data: data}});
		   containersTP.setData(dataObjects);
		   containersControlPanel.setData(dataObjects);
		   containersTP.getSelectionModel().setSelectionInterval(dataObjects.length - 1, dataObjects.length - 1);*/
		}
		
		public function addData(data1:DataStructurObject):void
		{
		/*var containerForm:DataContainerForm = containerForms.get(data1.dataName);
		   var dataName:String = data1.dataName;
		   //var data:DataStructurObject = data1[_dataContainerType];
		   var data:DataStructurObject = data1;
		   containerForm.setDataToContainer(data);
		   data.addEventListener(Event.CHANGE, onChangeDSO);
		
		   //var dataObjects:Array = containersTable.getData();
		   dataObjects.push({name: getNewDataName(), data: {id: dataName, data: data}});
		   containersTP.setData(dataObjects);
		   containersTP.getSelectionModel().setSelectionInterval(dataObjects.length - 1, dataObjects.length - 1);
		
		   containersControlPanel.setData(dataObjects);*/
		}
		
		private function onChangeDSO(e:Event):void
		{
			gtrace("2: " + (e.currentTarget as DataStructurObject));
			var isToHash:Boolean = DataObjectsHash.checkDSO((e.currentTarget as DataStructurObject));
			gtrace(isToHash);
		}
		
		private function containersTableSelectionHandler(e:SelectionEvent):void
		{
		/*var selRows:Array = containersTP.getSelectedRows();
		   if (!selRows)
		   return;*/
		
		/*if (selRows.length > 1)
		   return;*/
		
		/*var selId:uint = selRows[0];
		   currentContainerIdSDC.setData(selId);
		
		   var containerData:Object = dataObjects[selId];
		   //containerTypesCB.setSelectedItem(containerData.data.id);
		   currentContainerForm = containerForms.get(containerData.data.id);
		   containersControlPanel.setCurrentContainer(currentContainerForm);
		
		   if (currentContainerForm)
		   {
		   (currentContainerFR.getComponent(0) as Container).removeAll();
		   (currentContainerFR.getComponent(0) as Container).append(currentContainerForm);
		   currentContainerForm.setDataToContainer(containerData.data.data);
		   }
		
		   containersControlPanel.setCurrentContainerIndex(selId);*/
		}
		
		public function copyContainers(indexes:Array):void
		{
			//var selId:int;
		
			// если материал не выбран, то ничего предпринимать не следует
			//if (selId == -1)
			//return;
		
			//var containersData:Array = containersTable.getData()
		/*indexes = indexes.sort(Array.NUMERIC).reverse();
		   var containerData:Object;
		   for each (selId in indexes)
		   {
		   //containersData[selId] = null;
		   //containersTableModel.removeRow(selId);
		
		   containerData = ObjectUtils.cloneObject(dataObjects[selId]);
		   //containerData = (dataObjects[selId]).clone();
		   containerData.name = getNewDataName();
		   dataObjects.push(containerData);
		   }
		
		   containersTP.setData(dataObjects);
		   containersTP.getSelectionModel().setSelectionInterval(dataObjects.length - 1, dataObjects.length - 1);
		
		   containersControlPanel.setData(dataObjects);*/
		}
		
		private function copyContainerBtnHandler(e:AWEvent):void
		{
		/*var selRows:Array = containersTP.getSelectedRows();
		   if (!selRows)
		   return;
		   copyContainers(selRows);*/
		}
		
		public function removeContainers(indexes:Array):void
		{
			var selId:int /* = containersTable.getSelectedRow()*/;
			
			// если объект не выбран, то ничего предпринимать не следует
			/*if (selId == -1)
			   return;*/
			
			var containersData:Array = containersTP.getData();
			// хотя бы один объект всегда должен существовать
			if (oneMinimum && containersData.length <= 1)
				return;
		
			// сперва сортируем массив по возрастанию индексов удаляемых строк
			// потом изменяем порядок на обратный, т.к. большие индексы должны удаляться раньше
			// иначе происходит сдвиг строк и их неправильное удаление
		/*indexes = indexes.sort(Array.NUMERIC).reverse();
		   for each (selId in indexes)
		   {
		   containersData[selId] = null;
		   containersTableModel.removeRow(selId);
		   }*/
		
			   // установить выбранной предыдущую структуру (или следующую, если  нет)
		/*var dataCount:uint = containersTP.getData().length;
		   if (dataCount > 0)
		   {
		   selId = selId < dataCount ? selId : dataCount - 1;
		   containersTP.getSelectionModel().setSelectionInterval(selId, selId);
		   }
		
		   containersControlPanel.setData(dataObjects);*/
		}
		
		private function selectContentViewListener(e:AWEvent):void
		{
			//var scriptPath:String = (e.currentTarget as ScriptButton)
			//AirMediator.currentMode::getFile(scriptPath, onScriptRead, true, errorHandler);
		
		/*if (!containersTP)
		   return;
		
		   var selId:int = containersTP.getSelectedRow();
		 */
			 // если объект не выбран, то ничего предпринимать не следует
		/*	if (selId == -1)
		   return;
		
		   currentContainerIdSDC.setData(selId);*/
		
			   //var containerType:String = containerTypesCB.getSelectedItem();
		
		/*var containerType:String = (containersControlPanel.getSelectedValue() as DataContainerForm).dataContainerName;
		   var containerData:Object = defaultDataFactory.getData(containerType);
		   currentContainerForm = containerForms.get(containerType);
		
		   if (currentContainerForm)
		   {
		   (currentContainerFR.getComponent(0) as Container).removeAll();
		   (currentContainerFR.getComponent(0) as Container).append(currentContainerForm);
		   currentContainerForm.setDataToContainer(containerData);*/
		
			   //var dataObjects:Array = containersTable.getData();
		/*dataObjects.splice(selId, 1, {name: dataObjects[selId].name, data: {id: currentContainerForm.dataContainerName, data: containerData}});
		   containersTP.setData(dataObjects);
		   containersTP.getSelectionModel().setSelectionInterval(selId, selId);*/
			   //}
		
		}
		
		//**************************************************** ♪ ОБРАБОТЧИКИ СОБЫТИЙ ***************************************		
		
		private function removeContainerBtnHandler(e:AWEvent):void
		{
		/*var selRows:Array = containersTP.getSelectedRows();
		   if (!selRows)
		   return;
		   removeContainers(selRows);*/
		}
		
		private function showContainersTableBtnHandler(e:AWEvent):void
		{
		/*containersTableFR.setVisible((containersControlPanel as ContainersAssetsControlPanel).selectedLB.isSelected());
		   containersTableFR.getParent().revalidate();*/
		}
		
		private function onEditingStop(e:TableCellEditEvent):void
		{
		/*var containersData:Array = containersTP.getData();
		   var id:int = e.getRow();
		   if (!ArrayNamesHelper.checkUnicalNameWithException(containersData, "name", e.getNewValue(), id))
		   {
		   var p:JOptionPane = JOptionPane.showMessageDialog("Warning!", "Object with name " + e.getNewValue() + " already exists", null, this, true, new LoadIcon(WARNING_ICON, 20, 20));
		   p.setBackgroundDecorator(new ColorDecorator(new ASColor(0x500303)));
		   containersTP.setValueAt(e.getOldValue(), e.getRow(), e.getColumn());
		   }*/
		}
		
		//**************************************************** ☼ СОЗДАНИЕ КОМПОНЕНТОВ ***************************************
		
		protected function createContainersTabbedPaneForm(dataName:String = "", model:DataContainersTableModel = null):void
		{
		/*containersTabbedPaneForm = new Form();
		   containersTableModel = model ? model : new DataContainersTableModel(dataObjects);
		   containersTP = new DataContainersTable(containersTableModel);
		   containersTP.addSelectionListener(containersTableSelectionHandler);
		   containersTP.addEventListener(TableCellEditEvent.EDITING_STOPPED, onEditingStop);
		   containersTableScP = new JScrollPane(containersTP, JScrollPane.SCROLLBAR_ALWAYS, JScrollPane.SCROLLBAR_NEVER);
		   containersTableScP.setPreferredSize(new IntDimension(267, 100));
		
		   containersTabbedPaneForm.addLeftHoldRow(0, containersTableScP);
		
		   createControlElements(dataName);
		
		   containersTableFR = fullForm.addLeftHoldRow(0, containersTabbedPaneForm);
		   containersTableFR.setVisible(showTable);*/
		}
		
		protected function createControlElements(dataName:String):void
		{
		/*addContainerBtn = createButton("add " + (dataName.length ? dataName : _dataContainerType), addContainerBtnHandler);
		   removeContainerBtn = createButton("remove", removeContainerBtnHandler);
		   copyContainerBtn = createButton("copy", copyContainerBtnHandler);
		   containersTabbedPaneForm.addLeftHoldRow(2, 0, addContainerBtn, removeContainerBtn, copyContainerBtn);*/
		}
		
		/**
		 * Создать кнопку.
		 * @param	text
		 * @param	listener
		 * @return
		 */
		protected function createButton(text:String, listener:Function):JButton
		{
			var btn:DSButton = new DSButton(text);
			btn.setPreferredWidth(81);
			btn.setMaximumHeight(16);
			return btn;
		}
	
	}

}
