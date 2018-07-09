package devoron.dataui.bindings
{
	import org.aswing.components.IAtomComponent;
	import devoron.data.core.base.DataStructurObject;
	import devoron.data.core.base.IDataContainer;
	import devoron.data.GetSetFunctionsHash;
	import devoron.dataui.multicontainers.table.DataContainersTable;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import org.aswing.Component;
	import org.aswing.Icon;
	import org.aswing.util.HashMap;
	
	/**
	 * DataUIController
	 * @author Devoron
	 */
	public class DataUIController implements IDataContainer, IAtomComponent
	{
		public static const SINGLE_COMPONENT_DATA_COLLECTION:String = "single";
		public static const MULTI_COMPONENT_DATA_COLLECTION:String = "multi";
		
		protected var dataChangeComponents:Array;
		protected var dataChangeListener:Function;
		
		protected var model:DataUIModel;
		
		private var _parent:DataUIController;
		private var _active:Boolean;
		
		private var listenersController:ListenersController;
		
		public function DataUIController(dataUIModel:DataUIModel)
		{
			model = dataUIModel;
			listenersController = new ListenersController(dataUIModel);
		}
		
		public function get parent():DataUIController
		{
			return _parent;
		}
		
		public function getModel():DataUIModel
		{
			return model;
		}
		
		public function setModel(model:DataUIModel):DataUIModel
		{
			if (this.model != model)
			{
				
			}
			return model;
		}
		
		//**************************************************** IDataContainer ****************************************************
		
		/* INTERFACE devoron.data.core.base.IDataContainer */
		
		public function get dataContainerName():String
		{
			return model.dataContainerName;
		}
		
		public function get dataContainerType():String
		{
			return model.dataContainerType;
		}
		
		public function set dataContainerName(value:String):void
		{
			model.dataContainerName = value;
		}
		
		public function set dataContainerType(value:String):void
		{
			model.dataContainerType = value;
		}
		
		public function setDataToContainer(data:Object):void
		{
			active = false;
			model.setDataToContainer(data);
			active = true;
		}
		
		public function collectDataFromContainer(data:Object = null):Object
		{
			return model.collectDataFromContainer(data);
		}
		
		public function collectDataFromContainerExtended(data:Object):void
		{
			model.collectDataFromContainer(data);
		}
		
		public function setDataContainerChangeComponents(propsAndComps:Object):void
		{
			//this.valuesAndComps = valuesAndComps;
			
			var func:Function;
			
			for (var prop:String in propsAndComps)
			{
				var comp:* = propsAndComps[prop];
				model.propsAndComps[prop] = comp;
				model.compsAndProps[comp] = prop;
				
				func = getGetValueFunction(comp);
				//if (func == null)
				
				//throw new Error("Component " + getQualifiedClassName(comp) + " is not supported for DataContainerForm.");
				//Main_PRICE2000.tracer("2:Component " + getQualifiedClassName(comp) + " is not supported for DataContainerForm.");
				model.getValueFunctions.put(comp, func);
				
				func = getSetValueFunction(comp);
				//if (func == null)
				//throw new Error("Component " + getQualifiedClassName(comp) + " is not supported for DataContainerForm.");
				//Main_PRICE2000.tracer("2:Component " + getQualifiedClassName(comp) + " is not supported for DataContainerForm.");
				model.setValueFunctions.put(comp, func);
				
				if (model.dataCollectionMode == "single")
					addDataChangeListener(collectDataFromContainerExtended, model.dataChangeParams, comp);
				else
					addDataChangeListener(collectDataFromContainer, model.dataChangeParams, comp);
			}
		}
		
		/**
		 * Функция получения значения из компонента.
		 * Требует переопределения для компонентов не включённых
		 * в список GetSetFunctionsHash.
		 * @param	comp
		 * @return
		 */
		public function getGetValueFunction(comp:*):Function
		{
			return GetSetFunctionsHash.getGetValueFunction(comp);
		}
		
		/**
		 * Функция установки значения в компонент.
		 * Требует переопределения для компонентов не включённых
		 * в список GetSetFunctionsHash.
		 * @param	comp
		 * @return
		 */
		public function getSetValueFunction(comp:*):Function
		{
			return GetSetFunctionsHash.getSetValueFunction(comp);
		}
		
		public function registerGetValueFunction(componentClass:Class, functionName:String):void
		{
			GetSetFunctionsHash.registerGetValueFunction(componentClass, functionName);
		}
		
		public function registerSetValueFunction(componentClass:Class, functionName:String):void
		{
			GetSetFunctionsHash.registerSetValueFunction(componentClass, functionName);
		}
		
		public function unregisterGetValueFunction(componentClass:Class):void
		{
			GetSetFunctionsHash.unregisterGetValueFunction(componentClass);
		}
		
		public function unregisterSetValueFunction(componentClass:Class):void
		{
			GetSetFunctionsHash.unregisterSetValueFunction(componentClass);
		}
		
		public function getValueFunctions(comp:Component):Function
		{
			return getValueFunctions.get(comp);
		}
		
		public function get active():Boolean
		{
			return _active;
		}
		
		public function set active(b:Boolean):void
		{
			_active = b;
		}
		
		//**************************************************** ☼ ListenersController management ***************************************
		
		public function getListenersController():ListenersController {
			return listenersController;
		}
		
		public function setListenersController(lc:ListenersController):void {
			
		}
		
		/**
		 * Добавление слушателей на компоненты.
		 * @usage Без проверки типа.
		 * @param	...rest
		 */
		public function addDataChangeListener(listener:Function, params:Object, /*comps:Array */... comps):void
		{
			listenersController.addDataChangeListener(listener, params, comps);
		}
		
		/**
		 * Удалить все слушатели.
		 */
		public function removeAllDataChangeListeners():void
		{
			listenersController.removeAllDataChangeListeners();
		}
		
		/**
		 * Обработчик изменения данных
		 * @param	e
		 */
		public function dataChangeHandler(e:Event):void
		{
			listenersController.dataChangeHandler(e);
		}
		
		public function propsAndComps():Object 
		{
			return model.propsAndComps;
		}
		
		/* INTERFACE devoron.data.core.base.IDataContainer */
		
		public function get dataContainerIcon():Icon
		{
			return model.dataContainerIcon;
		}
		
		public function set dataContainerIcon(value:Icon):void
		{
			model.dataContainerIcon = value;
		}
	
	}

}