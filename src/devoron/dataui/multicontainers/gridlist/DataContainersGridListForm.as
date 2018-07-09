package devoron.components.multicontainers.gridlist
{
	import devoron.components.buttons.DSButton;
	import devoron.components.console.gui.maindisplay.ScriptButton;
	import devoron.components.data.GetSetFunctionsHash;
	import devoron.components.menus.CircleMenu;
	import devoron.components.ButtonsViewport;
	import devoron.dataui.DataContainerForm;
	import devoron.components.data.DataContainerTitleBar;
	import devoron.components.labels.DSLabel;
	import devoron.components.multicontainers.table.DataContainersForm;
	import devoron.components.multicontainers.table.IContainersControlPanel;
	import devoron.components.buttons.StateToggleButton;
	import devoron.data.core.DataObjectsHash;
	import devoron.studio.core.scenebrowser.CircleButton;
	import devoron.studio.tools.clipboard.ClipboardManager;
	import flash.display.BlendMode;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import org.aswing.AssetIcon;
	import org.aswing.AsWingConstants;
	import org.aswing.ButtonGroup;
	import org.aswing.decorators.ColorDecorator;
	import devoron.components.comboboxes.DSComboBox;
	import devoron.data.core.base.DataStructurObject;
	import devoron.data.core.DefaultDataFactory;
	import devoron.data.core.SimpleDataComponent;
	import devoron.studio.core.workspace.IPropertiesPanelComponent;
	import devoron.utils.ArrayNamesHelper;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.Container;
	import org.aswing.decorators.GradientBackgroundDecorator;
	import org.aswing.EmptyIcon;
	import org.aswing.event.AWEvent;
	import org.aswing.event.SelectionEvent;
	import org.aswing.event.TableCellEditEvent;
	import org.aswing.ext.Form;
	import org.aswing.ext.FormRow;
	import org.aswing.ext.GeneralGridListCellFactory;
	import org.aswing.ext.GridList;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntPoint;
	import org.aswing.Icon;
	import org.aswing.JButton;
	import org.aswing.JDropDownButton;
	import org.aswing.JLabel;
	import org.aswing.JOptionPane;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
	import org.aswing.JSeparator;
	import org.aswing.JSpacer;
	import org.aswing.JSprH;
	import org.aswing.JTable;
	import org.aswing.JTextField;
	import org.aswing.JToggleButton;
	import org.aswing.layout.BorderLayout;
	import org.aswing.layout.BoxLayout;
	import org.aswing.layout.CenterLayout;
	import org.aswing.layout.FlowLayout;
	import org.aswing.layout.FlowWrapLayout;
	import org.aswing.layout.HorizontalCenterLayout;
	import org.aswing.layout.SoftBoxLayout;
	import org.aswing.layout.VerticalCenterLayout;
	import org.aswing.LoadIcon;
	import org.aswing.table.DefaultTableModel;
	import org.aswing.util.HashMap;
	import org.aswing.util.ObjectUtils;
	import org.aswing.VectorListModel;
	
	/**
	 * Множественный табличный контейнер данных.
	 * @author Devoron
	 */
	public class DataContainersGridListForm extends DataContainerForm implements IPropertiesPanelComponent
	{
		[Embed(source="../../../../../assets/icons/preferences_icon20.png")]
		private var preferencesIcon:Class;
		
		private const WARNING_ICON:String = "../assets/icons/warning_icon20.png";
		private const GEOMETRY_ICON:String = "../assets/icons/geometry_icon20.png";
		protected var supportedContainerFormClasses:Array = [];
		
		protected var addContainerBtn:JButton;
		protected var removeContainerBtn:JButton;
		protected var copyContainerBtn:JButton;
		protected var containerTypesCB:DSComboBox;
		protected var currentContainerFR:FormRow;
		
		public var containerForms:HashMap;
		public var defaultDataFactory:DefaultDataFactory;
		
		protected var containersGridList:DataContainersGridList;
		protected var containersGridListScP:JScrollPane;
		protected var containersGridListForm:Form;
		private var showFullFormBtn:JToggleButton;
		private var fullFormFR:FormRow;
		private var containersTableFR:FormRow;
		protected var containersGridListModel:VectorListModel;
		protected var currentContainerForm:DataContainerForm;
		protected var currentContainerIdSDC:SimpleDataComponent;
		
		private var oneMinimum:Boolean;
		protected var showGridList:Boolean;
		protected var fullForm:Form;
		private var buttonsPanel:JPanel;
		private var buttonsGroup:ButtonGroup;
		//private var buttonsSP:ButtonsViewport;
		private var buttonsSP:JScrollPane;
		private var model:VectorListModel;
		//private var containersGridList:GridList;
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
		public function DataContainersGridListForm(supportedContainerFormClasses:Array, dataContainerName:String = "", dataContainerType:String = "", dataContainerIcon:Icon = null, dataCollectionMode:String = DataContainerForm.SINGLE_COMPONENT_DATA_COLLECTION, oneMinimum:Boolean = true, showGridList:Boolean = false, containersPanel:IContainersControlPanel = null)
		{
			super(dataContainerName, dataContainerType, dataContainerIcon, dataCollectionMode);
			this.containersControlPanel = containersPanel;
			this.showGridList = showGridList;
			this.oneMinimum = oneMinimum;
			this.supportedContainerFormClasses = supportedContainerFormClasses;
			
			dataObjects = new Array();
			
			if (!containersControlPanel)
			{
				
					//containersControlPanel = new ContainersAssetsControlPanel(dataContainerType);
					//containersControlPanel.addIContentViewListener(contentChange);
					//containersControlPanel.addActionListener(selectContentViewListener);
					//(containersControlPanel as ContainersAssetsControlPanel).selectedLB.addActionListener(showContainersTableBtnHandler);
			}
			
			super.setTextRenderer(DSLabel);
			
			containerForms = new HashMap();
			defaultDataFactory = new DefaultDataFactory();
			
			currentContainerIdSDC = new SimpleDataComponent(0);
			
			installComponents();
			
			var comps:Object = new Object();
			comps["selectedId"] = currentContainerIdSDC;
			comps[dataContainerType] = containersGridList;
			super.setDataContainerChangeComponents(comps);
			
			containersGridList.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			containersGridList.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
		
			// нужно добавление контейнеров групп
			// чтобы можно было переключиться между типами - базовая геометрия, внешняя, + группа, добавленная из AssetManager'a - например, дома, деревья, машины
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
				gtrace("нужно скопировать элементы из GridList");
				var selectedRows:Array = (containersGridList as JTable).getSelectedRows();
				//var data:Array = containersGridListModel.getData();
				var data:Array = containersGridListModel.toArray();
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
				gtrace("нужно вставить элементы в GridList");
				var data2:Array = ClipboardManager.instance.pasteToDataContainersTable(_dataContainerType) as Array;
				if (data2)
				{
					//var arr:Array = containersGridListModel.getData();
					var arr:Array = containersGridListModel.toArray();
					for each (var item2:*in data2)
					{
						//arr.push(item2)
						var n:String = getNewDataName();
						var obj:* = ObjectUtils.cloneObject(item2);
						/*arr.push(obj);
						 dataObjects.push(obj);*/
						//item2.name = n;
						addData(obj.data.data);
					}
					
					active = false;
					//containersGridListModel.setData(arr);
					containersGridListModel.clear();
					containersGridListModel.appendAll(arr);
					active = true;
				}
					// если тип таблицы соответствует массиву, который содержится в Clipboard, то можно установить его
					//containersTable as JTabl
					//Clipboard.instance.
			}
		}
		
		protected function installComponents():void
		{
			//createContainersComboBox();
			//createContainersButtons();
			//createContainersGridList();
			
			//fullForm = new Form();
			
			//controlPanelFR = super.addLeftHoldRow(0, containersControlPanel.getControlPanel());
			//containerTypesCB.setSelectedIndex(0);
			//buttonsGroup.setSelectedIndex(0);
			//containersGridList.setSelectedIndex(0);
			
			createContainersGridListForm();
			
			//lastSpacer = new JSpacer(new IntDimension(0, 5));
			//fullFormFR = super.addLeftHoldRow(0, fullForm);
			// пустой ряд, в который будет устанавливаться текущая форма материала
			
			//super.addLeftHoldRow(0, 0)
			
			//showFullFormBtn.setRelatedComponent(currentContainerFR);
			//showLightPickerManagerBtn.setRelatedObject(lightPickerManager, "popupOpened", lightPickerManager.show, "popupClosed", lightPickerManager.hide);
			/*containersTableFR = fullForm.*/
			addLeftHoldRow(0, containersGridListForm /* currentContainerFR*/ /*, fullForm*/);
			
			currentContainerFR = addLeftHoldRow(0, new DSLabel("dsjkfsdjfkljksdjfsdkjfsk"));
			
			createContainerForms();
			
			//currentContainerFR.setPreferredHeight(q
			///*containersTableFR = fullForm.*/addLeftHoldRow(0,  currentContainerFR/*, fullForm*/);
			///*containersTableFR = fullForm.*/addLeftHoldRow(0,  new DSLabel("dsjkfdjskfjdksjfksdjkfj")/*, fullForm*/);
			//currentContainerFR.setVisible(showGridList);
			currentContainerFR.setVisible(true);
		
		}
		
		private var dcf:DataContainersForm;
		
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
		
		protected function createContainersGridList():void
		{
		
		}
		
		private function showContainersGridListBtnHandler(e:AWEvent):void
		{
			containersGridListSP.getParent().getParent().setVisible((e.currentTarget as JToggleButton).isSelected());
		}
		
		private function showMenu():void
		{
			if (circleMenu.parent == null)
				stage.addChild(circleMenu);
			circleMenu.setVisible(true);
			
			//stage.setChildIndex(circleMenu, stage.numChildren - 1);
			
			var ds:Rectangle = addItemBtn.getBounds(stage);
			var pos:IntPoint = new IntPoint(ds.x - 200 * .5 + ds.width * .5, ds.y - 200 * .5 + ds.height * .5);
			
			circleMenu.x = pos.x;
			circleMenu.y = pos.y;
		}
		
		private function onHidden(e:AWEvent):void
		{
		
		}
		
		protected function circleMenuSelectionHandler(e:AWEvent):void
		{
			circleMenu.setVisible(false);
			//var editor:BaseEditor = circleMenu.getSelectedItem() as BaseEditor;
			//addDataStructur(editor.getDataStructurClass(), editor.getDataName(), editor.getModulIcon());
		}
		
		private function showFullFormBtnHandler(e:AWEvent):void
		{
			fullFormFR.setVisible(showFullFormBtn.isSelected());
		}
		
		protected function getNewDataName():String
		{
			return ArrayNamesHelper.createNewOrdinalName(containersGridList.getData(), "name", _dataContainerType)
		}
		
		// нужно обозначить функции получения и установки значения для нестандартного компонента - containersTable
		
		override public function setDataToContainer(data:Object):void
		{
			super.setDataToContainer(data);
			//containersControlPanel.setData(data[_dataContainerType]);
			//containersControlPanel.setData(data.material as Array);
			//containersControlPanel.setData(data.geometry as Array);
			//var dataObjects:Array = containerwsTable.getData();
			if (dataObjects.length > data.selectedId)
				containersGridList.getSelectionModel().setSelectionInterval(data.selectedId, data.selectedId);
		}
		
		override public function collectDataFromContainer(data:Object = null):Object
		{
			// если в таблице нет ни одного элемента, а по умолчанию должен быть как минимум один всегда
			// например, у меша ВСЕГДА должна быть геометрия и материал, матрица трансформации
			/*if (containersGridList.getData().length == 0 && oneMinimum)
			   {
			   containersControlPanel.setSelectedValueIndex(0);
			   addContainerBtnHandler(new AWEvent(AWEvent.ACT));
			 }*/
			
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
				
				if (comp is DataContainersGridList)
				{
					value = (comp as DataContainersGridList).getData();
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
		
		public function getModel():VectorListModel
		{
			return containersGridListModel;
		}
		
		public function setModel(model:VectorListModel):void
		{
			containersGridListModel = model;
			//containersGridListModel.toArray;
			containersGridList.setModel(model);
			containersGridList.setData(dataObjects);
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
			return fullForm;
		}
		
		public function getDashboardMinimalComponent():Component
		{
			return new JToggleButton("ds");
		}
		
		//**************************************************** ♪ ОБРАБОТЧИКИ СОБЫТИЙ ***************************************		
		
		/**
		 * Обработчик изменения настроек выбранного контейнера.
		 * @param	obj
		 */
		protected function containerDataChangeHandler(obj:DataStructurObject):void
		{
			var selId:int = containersGridList.getSelectedIndex();
			if (selId == -1)
				return;
			
			//var dataObjects:Array = containersTable.getData();
			//var dataObjects:Array = containersTable.getData();
			//dataObjects
			var dataObject:Object = dataObjects[selId];
			currentContainerForm.collectDataFromContainer(dataObject.data.data);
			containersGridList.dispatchEvent(new AWEvent(AWEvent.ACT));
		}
		
		public function addData(data1:DataStructurObject):void
		{
			var containerForm:DataContainerForm = containerForms.get(data1.dataName);
			var dataName:String = data1.dataName;
			//var data:DataStructurObject = data1[_dataContainerType];
			var data:DataStructurObject = data1;
			containerForm.setDataToContainer(data);
			data.addEventListener(Event.CHANGE, onChangeDSO);
			
			//var dataObjects:Array = containersTable.getData();
			dataObjects.push({name: getNewDataName(), data: {id: dataName, data: data}});
			containersGridList.setData(dataObjects);
			containersGridList.getSelectionModel().setSelectionInterval(dataObjects.length - 1, dataObjects.length - 1);
			
			containersControlPanel.setData(dataObjects);
		}
		
		private function onChangeDSO(e:Event):void
		{
			gtrace("2: " + (e.currentTarget as DataStructurObject));
			var isToHash:Boolean = DataObjectsHash.checkDSO((e.currentTarget as DataStructurObject));
			gtrace(isToHash);
		}
		
		protected function containersGridListSelectionHandler(e:SelectionEvent):void
		{
			//var selRows:Array = containersGridList.getSelectedRows();
			var selRows:Array = containersGridList.getSelectedIndices();
			if (!selRows)
				return;
			
			/*if (selRows.length > 1)
			 return;*/
			
			var selId:uint = selRows[0];
			currentContainerIdSDC.setData(selId);
			
			//var containerData:Object = dataObjects[selId];
			var containerData:Object = containersGridList.getData()[selId];
			//containerTypesCB.setSelectedItem(containerData.data.id);
			//currentContainerForm = containerForms.get(containerData.data.id);
			currentContainerForm = containerForms.get(containerData.dataContainerName);
			//containersControlPanel.setCurrentContainer(currentContainerForm);
			
			if (currentContainerForm)
			{
				var container:Container = (currentContainerFR.getComponent(0) as Container);
				//container.setBackgroundDecorator(new ColorDecorator(new ASColor(0xFF8000, 0.4)));
				container.removeAll();
				container.append(currentContainerForm);
				//container.revalidate();
				//currentContainerFR.revalidate();
					currentContainerFR.pack();
					//currentContainerForm.setDataToContainer(containerData.data.data);
					//currentContainerForm.setDataToContainer(containerData.data.data);
			}
		
			//containersControlPanel.setCurrentContainerIndex(selId);
		}
		
		public function copyContainers(indexes:Array):void
		{
			var selId:int;
			
			// если материал не выбран, то ничего предпринимать не следует
			//if (selId == -1)
			//return;
			
			//var containersData:Array = containersTable.getData()
			indexes = indexes.sort(Array.NUMERIC).reverse();
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
			
			containersGridList.setData(dataObjects);
			containersGridList.getSelectionModel().setSelectionInterval(dataObjects.length - 1, dataObjects.length - 1);
			
			containersControlPanel.setData(dataObjects);
		}
		
		protected function copyContainerBtnHandler(e:AWEvent):void
		{
			var selIndices:Array = containersGridList.getSelectedIndices();
			if (!selIndices)
				return;
			copyContainers(selIndices);
		}
		
		public function removeContainers(indicies:Array):void
		{
			var selId:int /* = containersTable.getSelectedRow()*/;
			
			// если объект не выбран, то ничего предпринимать не следует
			/*if (selId == -1)
			 return;*/
			
			var containersData:Array = containersGridList.getData();
			// хотя бы один объект всегда должен существовать
			if (oneMinimum && containersData.length <= 1)
				return;
			
			// сперва сортируем массив по возрастанию индексов удаляемых строк
			// потом изменяем порядок на обратный, т.к. большие индексы должны удаляться раньше
			// иначе происходит сдвиг строк и их неправильное удаление
			indicies = indicies.sort(Array.NUMERIC).reverse();
			for each (selId in indicies)
			{
				containersData[selId] = null;
				containersGridListModel.removeAt(selId);
			}
			
			// установить выбранной предыдущую структуру (или следующую, если  нет)
			var dataCount:uint = containersGridList.getData().length;
			if (dataCount > 0)
			{
				selId = selId < dataCount ? selId : dataCount - 1;
				containersGridList.getSelectionModel().setSelectionInterval(selId, selId);
			}
			
			containersControlPanel.setData(dataObjects);
		}
		
		private function selectContentViewListener(e:AWEvent):void
		{
			//var scriptPath:String = (e.currentTarget as ScriptButton)
			//AirMediator.currentMode::getFile(scriptPath, onScriptRead, true, errorHandler);
			
			if (!containersGridList)
				return;
			
			var selId:int = containersGridList.getSelectedIndex();
			
			// если объект не выбран, то ничего предпринимать не следует
			if (selId == -1)
				return;
			
			currentContainerIdSDC.setData(selId);
			
			//var containerType:String = containerTypesCB.getSelectedItem();
			
			var containerType:String = (containersControlPanel.getSelectedValue() as DataContainerForm).dataContainerName;
			var containerData:Object = defaultDataFactory.getData(containerType);
			currentContainerForm = containerForms.get(containerType);
			
			if (currentContainerForm)
			{
				(currentContainerFR.getComponent(0) as Container).removeAll();
				(currentContainerFR.getComponent(0) as Container).append(currentContainerForm);
				currentContainerForm.setDataToContainer(containerData);
				
				//var dataObjects:Array = containersTable.getData();
				dataObjects.splice(selId, 1, {name: dataObjects[selId].name, data: {id: currentContainerForm.dataContainerName, data: containerData}});
				containersGridList.setData(dataObjects);
				containersGridList.getSelectionModel().setSelectionInterval(selId, selId);
			}
		
		}
		
		//**************************************************** ♪ ОБРАБОТЧИКИ СОБЫТИЙ ***************************************		
		
		protected function addContainerBtnHandler(e:AWEvent):void
		{
			/*if (containerTypesCB.getSelectedIndex() == -1)
			 return;*/
			
			//var containerForm:DataContainerForm = containerForms.get(containerTypesCB.getSelectedItem());
			//var containerForm:DataContainerForm = containerForms.get((buttonsGroup.getSelectedButton() as ScriptButton).getNativePath());
			//var containerForm:DataContainerForm = dcf.containersGridList.getSelectedValue();
			var containerForm:DataContainerForm = containersControlPanel.getSelectedValue();
			var dataName:String = containerForm.dataContainerName;
			var data:DataStructurObject = defaultDataFactory.getData(dataName);
			containerForm.setDataToContainer(data);
			
			//var dataObjects:Array = containersTable.getData();
			dataObjects.push({name: getNewDataName(), data: {id: dataName, data: data}});
			containersGridList.setData(dataObjects);
			containersControlPanel.setData(dataObjects);
			containersGridList.getSelectionModel().setSelectionInterval(dataObjects.length - 1, dataObjects.length - 1);
		}
		
		protected function removeContainerBtnHandler(e:AWEvent):void
		{
			var selRows:Array = containersGridList.getSelectedIndices();
			if (!selRows)
				return;
			removeContainers(selRows);
		}
		
		private function showContainersTableBtnHandler(e:AWEvent):void
		{
			//containersTableFR.setVisible((containersControlPanel as ContainersAssetsControlPanel).selectedLB.isSelected());
			//containersTableFR.getParent().revalidate();
		}
		
		protected function onEditingStop(e:TableCellEditEvent):void
		{
			var containersData:Array = containersGridList.getData();
			var id:int = e.getRow();
			if (!ArrayNamesHelper.checkUnicalNameWithException(containersData, "name", e.getNewValue(), id))
			{
				var p:JOptionPane = JOptionPane.showMessageDialog("Warning!", "Object with name " + e.getNewValue() + " already exists", null, this, true, new LoadIcon(WARNING_ICON, 20, 20));
				p.setBackgroundDecorator(new ColorDecorator(new ASColor(0x500303)));
				//containersGridList.setValueAt(e.getOldValue(), e.getRow(), e.getColumn());
				containersGridListModel.replaceAt(e.getOldValue(), e.getRow());
			}
		}
		
		//**************************************************** ☼ СОЗДАНИЕ КОМПОНЕНТОВ ***************************************
		
		protected function createContainersGridListForm(dataName:String = "", model:VectorListModel = null):void
		{
			containersGridListForm = new Form();
			
			containersGridListModel = model ? model : new DataContainersGridListModel(dataObjects);
			containersGridList = new DataContainersGridList(containersGridListModel);
			containersGridList.addSelectionListener(containersGridListSelectionHandler);
			containersGridList.addEventListener(TableCellEditEvent.EDITING_STOPPED, onEditingStop);
			containersGridListScP = new JScrollPane(containersGridList, JScrollPane.SCROLLBAR_ALWAYS, JScrollPane.SCROLLBAR_NEVER);
			
			containersGridListForm.addLeftHoldRow(0, containersGridListScP);
		
			createControlElements(dataName);
		}
		
		protected function createContainerForms():void
		{
			// заполнение комбобокса типами материалов, сбор дефолтных данных, создание форм-контейнеров
			var data:DataStructurObject;
			var containerForm:DataContainerForm;
			var model:VectorListModel = new VectorListModel();
			
			for each (var containerFormClass:Class in supportedContainerFormClasses)
			{
				containerForm = new containerFormClass();
				data = containerForm.collectDataFromContainer() as DataStructurObject;
				data.dataName = containerForm.dataContainerName;
				data.dataType = containerForm.dataContainerType;
				
				defaultDataFactory.registerDataStructurObject(containerForm.dataContainerName, data);
				containerForm.addDataChangeListener(containerDataChangeHandler, null);
				containerForms.put(containerForm.dataContainerName, containerForm);
				//(containerTypesCB.getModel() as VectorListModel).append(containerForm.dataContainerName);
				//appendContainerButton(containerForm.dataContainerName, containerForm.icon);
				//model.append(containerForm);
				model.append(containerForm);
			}
			
			containersGridList.setModel(model);
			//containersControlPanel.setContainersModel(model);
			//containersControlPanel.setData(
		/*dcf.containersGridList.setModel(dcf.model);
		   dcf.containersGridList.setSelectedIndex(0);
		 dcf.containersGridList.repaintAndRevalidate();*/
		
			// установить модель в компонент отображения
			// установить выбранное значение
		}
		
		protected function createControlElements(dataName:String):void
		{
			addContainerBtn = createButton("add " + (dataName.length ? dataName : _dataContainerType), addContainerBtnHandler);
			removeContainerBtn = createButton("remove", removeContainerBtnHandler);
			copyContainerBtn = createButton("copy", copyContainerBtnHandler);
			containersGridListForm.addLeftHoldRow(2, 0, addContainerBtn, removeContainerBtn, copyContainerBtn);
		}
		
		/**
		 * Создать кнопку.
		 * @param	text
		 * @param	listener
		 * @return
		 */
		protected function createButton(text:String, listener:Function):JButton
		{
			//var btn:JButton = new JButton(text);
			var btn:JButton = new DSButton(text, null, listener, 81);
			/*btn.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			btn.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			var id:ColorDecorator = new ColorDecorator(new ASColor(0X000000, 0.08), new ASColor(0XFFFFFF, 0), 2);
			//var id:ColorDecorator = new ColorDecorator(new ASColor(0X000000, 0.08), new ASColor(0XFFFFFF, 0.24), 4);
			//id.setGaps(-2, 1, 1, -2);
			id.setGaps(-1, 0, 0, 1);
			btn.setBackgroundDecorator(id);
			btn.setPreferredWidth(81);
			btn.buttonMode = true;
			btn.setForeground(new ASColor(0xFFFFFF, 0.5));
			btn.setMaximumHeight(16);
			btn.addActionListener(listener);*/
			return btn;
		}
		
		private function onMouseOut(e:MouseEvent):void
		{
			(e.currentTarget as JButton).setForeground(new ASColor(0xFFFFFF, 0.5));
		}
		
		private function onMouseOver(e:MouseEvent):void
		{
			(e.currentTarget as JButton).setForeground(new ASColor(0xFFFFFF, 0.8));
		}
	
	}

}
