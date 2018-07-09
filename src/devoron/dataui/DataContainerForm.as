package devoron.dataui
{
	import devoron.components.IAtomComponent;
	import devoron.data.core.base.IDataContainer;
	import devoron.dataui.bindings.DataUIController;
	import devoron.dataui.bindings.DataUIModel;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.aswing.Component;
	import org.aswing.event.AWEvent;
	import org.aswing.ext.Form;
	import org.aswing.Icon;
	
	[Event(name="change",type="flash.events.Event")]
	
	/**
	 * DataContainerForm
	 * @author Devoron
	 */
	public class DataContainerForm extends Form implements IDataContainer, IAtomComponent
	{
		//private var dataContainerIcon:Icon;
		private var selectionRect:ClipboardSelectionRect;
		private var desktopFg:Sprite;
		private var dataUIModel:DataUIModel;
		protected var dataUIController:DataUIController;
		public static const SINGLE_COMPONENT_DATA_COLLECTION:String = "single";
		public static const MULTI_COMPONENT_DATA_COLLECTION:String = "multi";
		
		//public var dataChangeParams:DataStructurObject;
		
		
		/**
		 * DataContainerForm
		 *
		 * Контейнер данных, реализованный в виде формы
		 *
		 * var widthST = new JNumberStepper(0);
		   var heightST = new JNumberStepper(0);
		
		   var liveUpdateSDC:SimpleDataComponent = new SimpleDataComponent(true);
		   var liveUpdateFunctionSDC:SimpleDataComponent = new SimpleDataComponent("setSize");
		
		   super.addLeftHoldRow(0, new DSLabel("size"), 5, widthST, heightST);
		
		   super.setDataContainerChangeComponents({liveUpdate: liveUpdateSDC, liveUpdateFunction: liveUpdateFunctionSDC, width: widthST, height: heightST});
		 *
		 * @param	dataContainerName имя контейнера данных(материал цвета, геометрия куба, ускорение движения и пр.): // ColorMaterial, CubeGeometry, ShadowFilter
		 * @param	dataContainerType тип контейнера данных(материал, геометрия, поведение и пр.) //material, geometry, physik, transform, filter
		 * @param	dataContainerIcon иконка контейнера данных // используется при необходимости отобразить контейнер данных
		 * @param	dataCollectionMode режим считываения данных: SINGLE_COMPONENT_DATA_COLLECTION - при изменении данных считывает данные 
		 * из ИЗМЕНИВШЕГО ЗНАЧЕНИЕ КОМПОНЕНТА компонента, MULTI_COMPONENT_DATA_COLLECTION - изменение одного компонента приводит 
		 * к считываетыванию данных из ВСЕХ КОМПОНЕНТОВ
		 * @param	dataLiveMode данные обновляются частично прямо в целевых объектах, без сериализации
		 * @author Devoron
		 */
		public function DataContainerForm(dataContainerName:String = "", dataContainerType:String = "", dataContainerIcon:Icon = null, dataCollectionMode:String = DataContainerForm.SINGLE_COMPONENT_DATA_COLLECTION, dataLiveMode:Boolean = false)
		{
			super();
			
			// при установки модели в контроллер происходит проверка на всех уровнях родительского контейнера,
			// чтобы не было повторений
			dataUIModel = new DataUIModel(dataContainerName, dataContainerType, dataContainerIcon, dataLiveMode);
			dataUIController = new DataUIController(dataUIModel);
			
			
			//this.name = dataContainerName;
			//this.dataContainerIcon = dataContainerIcon;
			//this.dataCollectionMode = dataCollectionMode;

			
			// добавлено для SelectionRect'a
			selectionRect = new ClipboardSelectionRect(dataUIModel);
			desktopFg = new Sprite();
			desktopFg.mouseChildren = true;
		   //desktopFg.mouseEnabled = false;
			desktopFg.addEventListener(MouseEvent.MOUSE_DOWN, selectionRect.onMouseDown);
			super.addEventListener(AWEvent.PAINT, selectionRect.onPaint);
			super.addChild(selectionRect);
		}
		
		public function setDataContainerChangeComponents(propertiesAndComponents:Object):void
		{
			dataUIController.setDataContainerChangeComponents(propertiesAndComponents);
		}
		
		/**
		 * Функция получения значения из компонента.
		 * Требует переопределения для компонентов не включённых
		 * в список GetSetFunctionsHash.
		 * @param	comp
		 * @return
		 */
		protected function getGetValueFunction(comp:*):Function
		{
			return dataUIController.getGetValueFunction(comp);
		}
		
		/**
		 * Функция установки значения в компонент.
		 * Требует переопределения для компонентов не включённых
		 * в список GetSetFunctionsHash.
		 * @param	comp
		 * @return
		 */
		protected function getSetValueFunction(comp:*):Function
		{
			return dataUIController.getSetValueFunction(comp);
		}
		
		protected function registerGetValueFunction(componentClass:Class, functionName:String):void {
			dataUIController.registerGetValueFunction(componentClass, functionName);
		}
		
		protected function registerSetValueFunction(componentClass:Class, functionName:String):void {
			dataUIController.registerSetValueFunction(componentClass, functionName);
		}
		
		protected function unregisterGetValueFunction(componentClass:Class):void {
			dataUIController.unregisterGetValueFunction(componentClass);
		}
		
		protected function unregisterSetValueFunction(componentClass:Class):void {
			dataUIController.unregisterSetValueFunction(componentClass);
		}
		
		/**
		 * Добавление слушателей на компоненты.
		 * @usage Без проверки типа.
		 * @param	...rest
		 */
		public function addDataChangeListener(listener:Function, params:Object, ... comps):void
		{
			dataUIController.addDataChangeListener(listener, params, comps);
		}
		
		/**
		 * Удалить все слушатели.
		 */
		public function removeAllDataChangeListeners():void
		{
			dataUIController.removeAllDataChangeListeners();
		}
		
		/**
		 * Обработчик изменения данных
		 * @param	e
		 */
		protected function dataChangeHandler(e:Event):void
		{
			dataUIController.dataChangeHandler(e);
		}
		
		/* INTERFACE devoron.dataloader.IDataContainer */
		
		public function setDataToContainer(data:Object):void
		{
			dataUIController.setDataToContainer(data);
		}
		
		public function collectDataFromContainer(data:Object = null):Object {
			var obj:Object = dataUIController.collectDataFromContainer(data);
			return obj;
		}

		public function collectDataFromContainerExtended(data:Object):Object {
			return dataUIController.collectDataFromContainer(data);
		}
		
		public function getValueFunctions(comp:Component):Function 
		{
			return dataUIController.getValueFunctions(comp);
		}
		
		public function get propertiesAndComponents():Object 
		{
			return dataUIController.propsAndComps;
		}
		
		public function get active():Boolean 
		{
			return dataUIController.active;
		}
		
		public function set active(b:Boolean):void
		{
			dataUIController.active = b;
		}
		
		
		public function get dataContainerName():String 
		{
			return dataUIModel.dataContainerName;
		}
		
		public function set dataContainerName(value:String):void 
		{
			dataUIModel.dataContainerName = value;
		}
		
		public function get dataContainerType():String 
		{
			return dataUIModel.dataContainerType;
		}
		
		public function set dataContainerType(value:String):void 
		{
			dataUIModel.dataContainerType = value;
		}
		
		public function get dataContainerIcon():Icon 
		{
			return dataUIModel.dataContainerIcon;
		}
		
		public function set dataContainerIcon(value:Icon):void 
		{
			dataUIModel.dataContainerIcon = value;
		}
		
		public function get dataLiveMode():Boolean 
		{
			return dataUIModel.dataLiveMode;
		}
		
		public function set dataLiveMode(value:Boolean):void 
		{
			dataUIModel.dataLiveMode = value;
		}
		
		public function get dataCollectionMode():String 
		{
			return dataUIModel.dataCollectionMode;
		}
		
		public function set dataCollectionMode(value:String):void 
		{
			dataUIModel.dataCollectionMode = value;
		}
		
		
		
	
	}

}