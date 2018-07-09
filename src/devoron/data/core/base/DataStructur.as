package devoron.data.core.base

{
	import devoron.data.core.serializer.ISerializable;
	import devoron.data.core.base.IDataContainersManager;
	import devoron.data.core.history.HistoryMediator;
	import devoron.data.core.history.HistoryPoint;
	import devoron.data.core.history.IHistoryMediator;
	import devoron.data.core.serializer.ICompositeSerializer;
	import devoron.data.core.serializer.ISerializer;
	import devoron.data.core.serializer.Serializer;
	import devoron.data.core.UID;
	import devoron.values.font.ASFontValue;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	import org.aswing.ASColor;
	import org.aswing.Border;
	import org.aswing.geom.IntDimension;
	import org.aswing.tree.DefaultTreeModel;
	import org.aswing.util.HashMap;
	import org.aswing.util.ObjectUtils;
	
	
	/**
	 * Структура данных, которая поддерживает работу
	 * с контейнерами данных интерфейса IDataContainer.
	 * @author Devoron
	 */
	public class DataStructur implements IDataContainersManager, ISerializable
	{
		public var uid:String; // уникальный идентификатор этой структуры(используется для связки с другими структурами, в swc-exporter'e и пр.)
		
		public var dataName:String; // имя данных
		public var dataType:String; // тип данных
		public var dataChangeTimestamp:Number; // время изменения данных
		public var path:String; // путь к структуре данных - нативный путь или ссылка в интернете (корневая папка + путь в иерархии)
		public var dataCode:String; // сериализованная структура данных
		
		public var useHistory:Boolean = false;
		public static var dataContainersNames:Array = new Array(); // имена контейнеров данных - ["ColorMaterial123", "CubeGeometry_d", "SomeTransformMatrix" и т.д.]
		public var dataContainersHash:HashMap = new HashMap(); // закэшированные данные - одинаковые контейнеры DSO - тип : [ссылки на контейнеры в разных структурах данных]
		public var dataContainersBingings:HashMap = new HashMap(); // связанные DSO(синхронизируют изменения)
		
		private static var defaultDatas:HashMap = new HashMap(); // данные по умолчанию
		private var useDefaultDatas:Boolean; // использовать ли дефолтные данные или каждый раз собирать новые
		protected var targetDataStructurClass:Class; // класс наследника - для инкапсуляции клонирования MeshData, ShaderData, TerrainData и прочих DataStructur
		public var dataContainers:HashMap = new HashMap(); // имена контейнеров && данные в них
		
		protected var _serializable:Boolean = false; // готовность к сериализации
		protected var _serializeObservers:Vector.<ISerializeObserver> = new Vector.<ISerializeObserver>(); // объект, получающий сериализованные данные
		
		protected var _relatedObject:* = null; // связанный объект - конечный результат обработки структуры данных например LookAndFeel, BitmapFont, Mesh, Sound3D и т.д.
		//protected var _blocked
		protected var _serializer:ICompositeSerializer; // сериализатор струтуры данных - композитный, потому что задействуются разные типы
		protected var _historyMediator:IHistoryMediator; // сериализатор струтуры данных - композитный, потому что задействуются разные типы
		
		public static var defaultSerializer:ICompositeSerializer = new Serializer();
		public static var defaultHistoryMediator:IHistoryMediator = new HistoryMediator();
		
		public function DataStructur(useDefaultDatas:Boolean = true, useHistory:Boolean = true, targetDataStructurClass:Class=null)
		{
			this.targetDataStructurClass = targetDataStructurClass;
			this.useHistory = useHistory;
			this.useDefaultDatas = useDefaultDatas;
			uid = UID.create();
			//uid = "_B1E60BA0C49CA2A99711BAEE76683CCF2A51B192";
			//this.serializer = defaultSerializer;
			//this.serializer = defaultSerializer;
			//SerializerBase
			//serializer.setSerializerShema(
		}
		
		/* INTERFACE devoron.dataloader.IDataContainersManager */
		
		public function getDataContainersCount():int
		{
			return dataContainers.size();
		}
		
		/**
		 * Добавление контейра данных и снятие с него дефолтных данных,
		 * если необходимо. Дефолтные данные записываются в хэш,
		 * который находится между всеми структурами данных.
		 * Необходимо, чтобы структуры данных могли посылать в 
		 * хэш свои данные, но читать из него - только по какому-то доступу.
		 * Например, по коду, вписанному внутрь(в какой-то блок) айдишников, это 
		 * позволит разграничить доступ к дефолтным данным для разных структур
		 * данных.
		 * @param	dataContainer
		 */
		public function addDataContainer(dataContainer:IDataContainer):void
		{
			var dataContainerName:String = dataContainer.dataContainerName;
			
			var data:DataStructurObject = new DataStructurObject();
			data.dataName = dataContainer.dataContainerName;
			data.dataType = dataContainer.dataContainerType;
			
			if (dataContainersNames.indexOf(dataContainerName) == -1)
			{
				dataContainersNames.push(dataContainerName);
				//gtrace("4:" + dataContainerName);
			}
			
			if (useDefaultDatas)
			{
				// если контейнер данных добавляется впервые
				if (defaultDatas.get(dataContainerName) == null)
				{
					dataContainer.collectDataFromContainer(data);
					defaultDatas.put(dataContainerName, data);
				}
				
				// создать копию дефолтных данных
				data = (defaultDatas.get(dataContainerName) as DataStructurObject).clone();
			}
			else
			{
				dataContainer.collectDataFromContainer(data);
			}
			
			data.dataStructur = this;
			//DataStructurEvent
			if (useHistory) {
				//data.addEventListener(Event.CHANGE, onDSOChange);
				data.addEventListener(DataStructurEvent.DATA_STRUCTUR_OBJECT_ADDED, onDataStructurObjectAdded);
			}
			
			if (dataContainers.get(dataContainerName) != null)
				data = dataContainers.get(dataContainerName);
			else
				dataContainers.put(dataContainerName, data);
			
			dataContainer.setDataToContainer(data);
			
			// если нужно, то сериализовать структуру
			if (_serializable)
				serialize();
		}
		
		
		protected function onDataStructurObjectChange(e:DataStructurEvent):void
		{
			
			//var dsoString:String = 
			
			//gtrace("2: change dso " + (e.currentTarget as DataStructurObject).toString() + " timestamp " + (e.currentTarget as DataStructurObject).timestamp);
			// Да, здесь мы получаем стринговое представление DSO
			// но в идеале бы получить старое и новое значения DSO
			// потом отправляем его в отдельный поток, послав туда же 
			// History.createPoint(this, dso, oldValue, newValue);
			// создётся точка в истории - запись в БД
			// Нistory.undo()
			// History.redo()
			historyMediator.getHistory(this).registerPoint(new HistoryPoint(this, e.currentTarget as DataStructurObject));
			
		}
		
		protected function onDataStructurObjectAdded(e:DataStructurEvent):void 
		{
			historyMediator.getHistory(this).registerPoint(new HistoryPoint(this, e.currentTarget as DataStructurObject));
		}
		
		protected function onDataStructurObjectRemoved(e:DataStructurEvent):void 
		{
			///historyMediator.getHistory(this).registerPoint(new HistoryPoint(this, e.currentTarget as DataStructurObject));
			//data.removeEventListener(DataStructurEvent.DATA_STRUCTUR_OBJECT_REMOVED, onDataStructurObjectRemoved);
			//e.currentTarget as 
		}
		
		public function removeDataByContainerName(dataContainerName:String):void
		{
			if (dataContainers)
				var data:DataStructurObject = dataContainers.remove(dataContainerName) as DataStructurObject;
			
				if (useHistory) {
				//data.addEventListener(Event.CHANGE, onDSOChange);
				// это событие должно генерироваться, когда контейнер отписался от всех событий
				// уничтожил свои данные и т.д.
				data.addEventListener(DataStructurEvent.DATA_STRUCTUR_OBJECT_REMOVED, onDataStructurObjectRemoved);
			}
				
			//if (useHistory)
				//data.addEventListener(Event.CHANGE, onDSOChange);
				
			// если нужно, то сериализовать структуру
			if (_serializable)
				serialize();
		}
		
		
		public function getDataContainersNames():Array
		{
			return dataContainers.keys();
		}
		
		public function getDataByContainerName(dataContainerName:String):Object
		{
			return dataContainers.get(dataContainerName);
		}
		
		public function getDataContainer(dataContainerName:String):IDataContainer{
			//getDataContainer
			//return null;
			
			return dataContainers.get(dataContainerName);
		}
		
		public function setDataByName(data:Object, dataName:String):void
		{
			if (useDefaultDatas)
			{
				// если контейнер данных добавляется впервые
				if (defaultDatas.get(dataName) == null)
				{
					//dataContainer.collectDataFromContainer(data);
					defaultDatas.put(dataName, data);
				}
				
				// создать копию дефолтных данных
				data = (defaultDatas.get(dataName) as DataStructurObject).clone();
			}
			/*else
			   {
			   dataContainer.collectDataFromContainer(data);
			 }*/
			
			data.dataStructur = this;
			
			if (dataContainers.get(dataName) != null)
				data = dataContainers.get(dataName);
			else
				dataContainers.put(dataName, data);
			
			//dataContainer.setDataToContainer(data);
			
			// если нужно, то сериализовать структуру
			if (_serializable)
				serialize();
		}
		
		public function removeDataContainer(dataContainer:IDataContainer):void
		{
			dataContainers.remove(dataContainer.dataContainerName);
		}
		
		public function clone():IDataContainersManager
		{
			var dataStructur:DataStructur = targetDataStructurClass ? new targetDataStructurClass : new DataStructur();
			dataStructur.dataName = dataName;
			dataStructur.dataType = dataType;
			
			var dataContainerName:String;
			var dataContainerNames:Array = dataContainers.keys();
			for each (dataContainerName in dataContainerNames)
			{
				dataStructur.dataContainers.put(dataContainerName, dataContainers.get(dataContainerName));
			}
			dataStructur.serializable = _serializable;
			var serializeObserver:ISerializeObserver;
			for each (serializeObserver in _serializeObservers)
			{
				dataStructur.addSerializeObserver(serializeObserver);
			}
			return dataStructur;
		}
		
		public function dispose():void
		{
			var dataContainerName:String;
			for each (dataContainerName in dataContainers.keys())
			{
				dataContainers.get(dataContainerName).removeAllExternalResources();
				dataContainers.remove(dataContainerName);
			}
			dataContainers = null;
			_serializeObservers.length = 0;
		}
		
		public function get serializable():Boolean
		{
			return _serializable;
		}
		
		public function set serializable(value:Boolean):void
		{
			_serializable = value;
			if (value)
				serialize();
		}
		
		public function addSerializeObserver(observer:ISerializeObserver):void
		{
			if (_serializeObservers.indexOf(observer) == -1)
				_serializeObservers.push(observer);
		}
		
		public function removeSerializeObserver(observer:ISerializeObserver):void
		{
			if (_serializeObservers.indexOf(observer) != -1)
				_serializeObservers.removeAt(_serializeObservers.indexOf(observer));
		}
		
		public function get relatedObject():*
		{
			return _relatedObject;
		}
		
		public function set relatedObject(value:*):void
		{
			_relatedObject = value;
		
		}
		
		public function serializePart():String
		{
			//gtrace("ЧАСТИЧНАЯ СЕРИАЛИЗАЦИЯ");
			
			// В СЛУЧАЕ ЧАСТИЧНОЙ СЕРЕАЛИЗАЦИИ МЫ СОБИРАЕМ ВСЕ ДАННЫЕ ИЗ
			// ТОГО КОНТЕЙНЕРА, КОТОРЫЙ БЫЛ ИНЦИАТОРОМ СЕРИАЛИЗАЦИИ
			// ЗНАЧИТ, ЭТО ГДЕ-ТО ДОЛЖНО БЫТЬ ОТМЕЧЕНО, А ПОТОМ СТЁРТО
			// СОБРАННЫЕ ДАННЫЕ В ВИДЕ СТРОКИ МЫ ЗАМЕНЯЕМ В СТРУКТУРЕ ДАННЫХ
			// И СООБЩАЕМ, ЧТО СТРУКТУРА ДАННЫХ ГОТОВА К ПАРСИНГУ
			
			if (!_serializable || _serializeObservers.length == 0)
				return "";
			
			// сериализованные данные
			var serializedData:String = "";
			// имя контейнера данных
			var dataContainerName:String;
			// данные в контейнере данных
			var dso:DataStructurObject;
			
			serializedData += "{"
			//serializedData += qutes(dataType) + ":" + "{";
			
			// выделить группы - объекты с одинаковым dataType
			var groupsDataType:HashMap = new HashMap();
			var group:Array;
			
			for each (dataContainerName in dataContainers.keys())
			{
				dso = DataStructurObject(dataContainers.get(dataContainerName));
				group = groupsDataType.get(dso.dataType);
				
				if (!group)
					groupsDataType.put(dso.dataType, [dso]);
				else
					group.push(dso);
			}
			
			var type:String;
			
			for each (type in groupsDataType.keys())
			{
				group = groupsDataType.get(type);
				
				// если количество контейнеров одного типа в группе больше чем один
				// то нужно открыть массив, иначе - это один отдельный контейнер
				if (group.length > 1)
					serializedData += qutes(type) + ":" + "[";
				else
					serializedData += qutes(type) + ":" + "{";
				
				for (var i:int = 0; i < group.length; i++)
				{
					dso = group[i];
					
					if (group.length > 1)
						serializedData += "{";
					
					serializedData += qutes("id") + ":" + qutes(dso.dataName) + ",";
					serializedData += qutes("data") + ":" + "{";
					
					var dataIsEmpty:Boolean = true;
					
					// запись свойства
					for (var item:String in dso)
					{
						dataIsEmpty = false;
						
						if (dso[item] is String)
							serializedData += qutes(item) + " : " + qutes(dso[item]) + ",";
						
						else if (dso[item] is Array)
						{
							serializedData = serializeArray(item, serializedData, dso[item]);
							/*var arr:Array = dso[item];
							   serializedData += qutes(item) + " : " + "[";
							   for each (var value:*in arr)
							   {
							
							   if (value is String || value is Number || value is int || value is uint || value is Boolean)
							   {
							   serializedData += String(value) + ",";
							   }
							
							   else if (value is Object)
							   {
							   serializedData = serializeObject(serializedData, value);
							   }
							
							   }
							   // удаление последней запятой
							   if (arr.length > 0)
							   serializedData = serializedData.substring(0, serializedData.length - 1);
							 serializedData += "]" + ","*/
						}
						
						else
							serializedData += qutes(item) + " : " + dso[item] + ",";
					}
					
					// удаление последней запятой
					if (!dataIsEmpty)
						serializedData = serializedData.substring(0, serializedData.length - 1);
					
					serializedData += "}";
					
					if (group.length > 1)
					{
						serializedData += "}";
						if (i != (group.length - 1))
							serializedData += ","
					}
					
				}
				
				// если количество контейнеров в группе больше чем один
				// то нужно закрыть массив, иначе - это один отдельный контейнер
				if (group.length > 1)
				{
					serializedData += "]";
					serializedData += ",";
				}
				else
				{
					serializedData += "}";
					serializedData += ",";
				}
				
			}
			
			// удаление последней запятой
			serializedData = serializedData.substring(0, serializedData.length - 1);
			//serializedData += "}";
			
			serializedData += "}";
			
			dataCode = serializedData;
			
			for each (var so:ISerializeObserver in _serializeObservers)
				so.setSerializedData(this, serializedData);
			
			return serializedData;
		}
		
		/**
		 * Сериализация структуры.
		 * Сбор всех свойств со всех DataStructurObject и запись
		 * их в одну строковую переменную (по умолчанию в формате JSON).
		 */
		public function serialize():String
		{
			if (!_serializable || _serializeObservers.length == 0)
				return "";
				
			// сериализованные данные
			var serializedData:String = "";
			// имя контейнера данных
			var dataContainerName:String;
			// данные в контейнере данных
			var dso:DataStructurObject;
			
			serializedData += "{"
			//serializedData += qutes(dataType) + ":" + "{";
			
			// выделить группы - объекты с одинаковым dataType
			var groupsDataType:HashMap = new HashMap();
			var group:Array;
			
			for each (dataContainerName in dataContainers.keys())
			{
				dso = DataStructurObject(dataContainers.get(dataContainerName));
				group = groupsDataType.get(dso.dataType);
				
				if (group==null)
					groupsDataType.put(dso.dataType, [dso]);
				else
					group.push(dso);
			}
			
			var type:String;
			
			for each (type in groupsDataType.keys())
			{
				group = groupsDataType.get(type);
				
				// если количество контейнеров одного типа в группе больше чем один
				// то нужно открыть массив, иначе - это один отдельный контейнер
				if (group.length > 1)
					serializedData += qutes(type) + ":" + "[";
				else
					serializedData += qutes(type) + ":" + "{";
				
				for (var i:int = 0; i < group.length; i++)
				{
					dso = group[i];
					
					if (group.length > 1)
						serializedData += "{";
					
					serializedData += qutes("id") + ":" + qutes(dso.dataName) + ",";
					serializedData += qutes("data") + ":" + "{";
					
					var dataIsEmpty:Boolean = true;
					
					// запись свойства
					for (var item:String in dso)
					{
						if (type == "componentData")
						trace("ds0");
						
						dataIsEmpty = false;
						
						if (dso[item] is String)
							serializedData += qutes(item) + " : " + qutes(dso[item]) + ",";
							
						
							 else if  (dso[item] is Number || dso[item] is int || dso[item] is uint || dso[item] is Boolean)
							   {
							   serializedData += qutes(item) + " : " + dso[item] + ",";
							   }
							
						else if (dso[item] is Array)
						{
							serializedData = serializeArray(item, serializedData, dso[item]);
							
							//trace(serializedData);
							
						/*	var arr2:Array = dso[item];
							if (arr2[arr2.length - 1] is Object){
								gtrace("dsfjkdsj");
							}*/
							//if ((dso[item] as Array)[length - 1]){
								//gtrace("dsfjk");
							//}
							
							/*var arr:Array = dso[item];
							   serializedData += qutes(item) + " : " + "[";
							   for each (var value:*in arr)
							   {
							
							   if (value is String || value is Number || value is int || value is uint || value is Boolean)
							   {
							   serializedData += String(value) + ",";
							   }
							
							   else if (value is Object)
							   {
							   serializedData = serializeObject(serializedData, value);
							   }
							
							   }
							   // удаление последней запятой
							   if (arr.length > 0)
							   serializedData = serializedData.substring(0, serializedData.length - 1);
							 serializedData += "]" + ","*/
						}
						
							else if (dso[item] is IntDimension){
								//serializedData += qutes(item) + " : " + qutes(dso[item]) + ",";
								serializedData += qutes(item) + " : " + "{";
								
								
								serializedData += qutes("id") + ":" + qutes("IntDimension") + ",";
							serializedData += qutes("data") + ":" + "{";
							serializedData +=  qutes("width") + ":" +(dso[item] as IntDimension).width+ ",";
							serializedData +=  qutes("height") + ":" +(dso[item] as IntDimension).height;
								serializedData += "}"+ "}"+ ",";
								
							}
							//serializedData = serializeIntDimension(serializedData, dso[item]);
						
						else if (dso[item] is Object){
							serializedData += qutes(item) + " : " + "{";
							
							serializedData += qutes("id") + ":" + qutes(item) + ",";
							serializedData += qutes("data") + ":";
							serializedData = serializeObject(serializedData, dso[item]);
								if (dso[item] is ASFontValue){
								serializedData = serializedData.substring(0, serializedData.length - 2)
								serializedData += "}";
							}
							else if (dso[item].type=="border"){
								serializedData = serializedData.substring(0, serializedData.length - 2)
								serializedData += "}";
							}
							//serializedData += /*"}"+*/ ",";
							
							serializedData += "}"+ /*"}"*/",";
							
							
							//if (item = "font")
							//gtrace("djfsksj");
							
						
							
						}
						
						//else if (dso[item] is ASFontValue){
						//serializedData = serializeObject(serializedData, dso[item]);
						//serializedData += qutes(dso[item]) + ":";
					//serializedData = serializeObject(serializedData, dso[item]);
					//serializedData += qutes(item) + " : " + qutes(dso[item]) + ",";
						//}
							//serializedData += qutes(item) + " : " + dso[item] + ",";
					}
					
					// удаление последней запятой
					if (!dataIsEmpty && (serializedData.charAt(serializedData.length-1)==","))
						serializedData = serializedData.substring(0, serializedData.length - 1);
					
					serializedData += "}";
					
					if (group.length > 1)
					{
						serializedData += "}";
						if (i != (group.length - 1))
							serializedData += ","
					}
					
				}
				
				// если количество контейнеров в группе больше чем один
				// то нужно закрыть массив, иначе - это один отдельный контейнер
				if (group.length > 1)
				{
					serializedData += "]";
					serializedData += ",";
				}
				else
				{
					serializedData += "}";
					serializedData += ",";
				}
				
			}
			
			// удаление последней запятой
			if(serializedData.charAt(serializedData.length-1)==",")
			serializedData = serializedData.substring(0, serializedData.length - 1);
			//serializedData += "}";
			
			serializedData += "}";
			
			dataCode = serializedData;
			
			for each (var so:ISerializeObserver in _serializeObservers)
			if(so!=null)
				so.setSerializedData(this, serializedData);
			
			return serializedData;
		}
		
		protected function serializeArray(item:String, serializedData:String, arr:Array):String
		{
			return _serializer.serialize(item, serializedData, arr);
		}
		
		protected function serializeObject(serializedData:String, value:Object):String
		{
			return _serializer.serialize(serializedData, value);
		}
		
		protected function serializeIntDimension(serializedData:String, value:Object):String
		{
			
			//serializedData = serializedData.substring(0, serializedData.length - 2)
			return _serializer.serialize(serializedData, value);
		}
		
		
		/**
		 * Возвращает массив уникальных путей к embed ассетам.
		 * @param	dataStructurs структуры данных, из dso которых будут считаны пути
		 * @return
		 */
		public function getAssetsPaths():Array {
			// обойти все DataStructurs
			var ds:DataStructur = this;
			var dso:DataStructurObject;
			var dsos:Array = ds.dataContainers.values();
			var l:uint = dsos.length;
			var i:uint = 0;
			var urls:Array = [];
			var value:*;
			
			while (i < l) {
				dso = dsos[i];
			
				for (var prop:String in dso)
				{ // nextName/nextNameIndex
				value = dso[prop];
				if (value is Array || value is Vector.<*>)
				{
					var arr:Array = [];
					var thisArr:Array =value;
					for each (var item:* in thisArr)
					{
						/*if (value is String) {
						if(value.indexOf("$url_") == 0){
						if (urls.indexOf(dso[prop] == -1){
							urls.push(dso[prop]);
						}
					}*/
						}
				}
				else if (value is String) {
					if (value.indexOf("$url_") == 0) {
						if (urls.indexOf(dso[prop]) == -1) {
							urls.push(dso[prop]);
						}
					}
					/*if(value.indexOf("$url_") == 0){
					if (urls.indexOf(dso[prop] == -1){
					urls.push(dso[prop]);
					}
				}*/
				}
				
			}
				i++;
			}
			// в каждой DataStructur обойти каждый DSO
			// составить массив уникальных url'ов
			// загрузить массив файлов по путям
			
			return urls;
		}
		
		private function qutes(str:String):String
		{
			return '"' + str + '"';
		}
		
			public function get serializer():ICompositeSerializer 
		{
			return _serializer;
		}
		
		public function set serializer(value:ICompositeSerializer):void 
		{
			_serializer = value;
		}
		
		public function get historyMediator():IHistoryMediator 
		{
			if (_historyMediator)
			return _historyMediator;
			return defaultHistoryMediator;
		}
		
		public function set historyMediator(value:IHistoryMediator):void 
		{
			_historyMediator = value;
		}
	
	}

}