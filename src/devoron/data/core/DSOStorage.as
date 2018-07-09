package devoron.data.core
{
	import devoron.data.core.base.DataStructurObject;
	import devoron.data.core.base.IDataContainer;
	import devoron.data.core.DSOStorage;
	import devoron.file.FileInfo;
	import devoron.utils.airmediator.AirMediator;
	import flash.events.Event;
	import flash.net.ObjectEncoding;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import org.aswing.util.HashMap;
	
	/**
	 * DSOStorage
	 * @author Devoron
	 */
	public class DSOStorage
	{
		public static const SHARED_OBJECT:String = "shared_object";
		public static const FILE:String = "file";
		public static const CLOUD:String = "cloud";
		
		private var storagePath:String;
		private var hash:HashMap = new HashMap();
		private var currentMode:String;
		
		private var sharedObject:Object;
		private var cloudObject:URLLoader;
		
		public function DSOStorage(sharedObjectNameOrUrl:String, type:String = "shared_object")
		{
			init(sharedObjectNameOrUrl);
		}
		
		/**
		 * Если тип хралища - SharedObject, то создаётся или запрашивается
		 * объект SharedObject
		 * @param	sharedObjectNameOrUrl
		 */
		private function init(sharedObjectNameOrUrl:String, type:String = "shared_object"):void
		{
			switch (type)
			{
				case SHARED_OBJECT: 
					sharedObject = SharedObject.getLocal(sharedObjectNameOrUrl);
					break;
				case FILE: 
					// здесь нужна связь с Air-mediatorom
					break;
				case CLOUD: 
					cloudObject = new URLLoader();
					// здесь соединяемся с облаком
					// кстати, самое время просто отправить запрос на сайт
					break;
			}
		}
		
		public function saveDSO(dsoName:String, data:DataStructurObject, resultHandler:*, errorHandler:Function = null):void
		{
			var stream:ByteArray = new ByteArray();
			stream.objectEncoding = ObjectEncoding.AMF3; // ByteArray defaults to AMF3
			stream.writeObject(data);
			stream.position = 0;
			
			switch (currentMode)
			{
				case SHARED_OBJECT: 
					//recentSettings.push(date);
					//sharedObject.clear();
					
					sharedObject.data[dsoName] = stream;
					sharedObject.flush();
					break;
				case FILE: 
					hash.put(storagePath + "\\" + dsoName + ".ddso", {resultHandler: resultHandler, errorHandler: errorHandler});
					AirMediator.saveFile(storagePath + "\\" + dsoName + ".ddso", stream /*onDSOComplete, true, errorHandler*/);
					break;
				case CLOUD: 
					// сделать запрос к облаку на получение DSO
					// возможно, я сделаю работу с облаком через AirMediator
					var vars:URLVariables = new URLVariables();
					vars['dsoName'] = dsoName + ".ddso";
					vars['data'] = stream;
					request = new URLRequest(storagePath+"\\saveDSO.php"); // адрес вашего скрипта 'http://flapps.ru/script.php'
					request.method = URLRequestMethod.POST;
					request.data = vars;
					//loader.addEventListener(Event.COMPLETE, onComplete);
					cloudObject.load(request);
					
					break;
			}
		
			//AirMediator.saveFile(
		}
		
		private function onComplete(event:Event):void
		{
			// выводим полученные данные в поле result_tf
			//result_tf.text=loader.data;
		}
		
		public function getAllDSO(resultHandler:*, errorHandler:Function = null):void
		{
		
		}
		
		/**
		 * Получить все DSO в хранилище как Dictionary {имя DSO: строковое представление содержимого DataContainer}
		 * @param	resultHandler
		 * @param	errorHandler
		 */
		public function getAllDSOAsDictionary(resultHandler:*, errorHandler:Function = null):void
		{
		
		}
		
		/**
		 * Получить все DSO в хранилище как HashMap {имя DSO: строковое представление содержимого DataContainer}
		 * @param	resultHandler
		 * @param	errorHandler
		 */
		public function getAllDSOAsHashMap(resultHandler:*, errorHandler:Function = null):void
		{
		
		}
		
		private var dsoForSaving:HashMap;
		private var dsoForSavingResultHandler:Function;
		private var dsoForSavingErrorHandler:Function;
		private var request:URLRequest;
		
		public function saveDSODictionary(dsoDictionary:Dictionary, resultHandler:*, errorHandler:Function = null /*, clearStorage:Boolean = false*/):void
		{
			dsoForSaving = HashMap.fromDictionary(dsoDictionary);
			dsoForSavingResultHandler = resultHandler;
			dsoForSavingErrorHandler = errorHandler;
			saveNextFromDictionary();
		}
		
		public function saveDSOHashMap(dsoHashMap:HashMap, resultHandler:*, errorHandler:Function = null /*, clearStorage:Boolean = false*/):void
		{
			dsoForSaving = dsoHashMap;
			dsoForSavingResultHandler = resultHandler;
			dsoForSavingErrorHandler = errorHandler;
			saveNextFromDictionary();
		}
		
		private function saveNextFromDictionary():void
		{
			if (dsoForSaving)
			{
				var names:Array = dsoForSaving.keys();
				if (names.length > 0)
				{
					var dso:DataStructurObject = dsoForSaving.remove(names[0]);
					saveDSO(dso.dataName, dso, saveNextFromDictionary);
				}
				else
				{
					if (dsoForSavingResultHandler != null)
						dsoForSavingResultHandler.call(null);
				}
				
			}
		}
		
		/**
		 * функция-обработчик или контейнер данных
		 * IDataContainer
		 */
		public function getDSO(dsoName:String, resultHandler:*, errorHandler:Function = null):void
		{
			// SharedObject реализует точно такой же интерфейс работы с путём, как и остальные
			// прочесть данные из SharedObject
			// DSOStorage - это ByteArray (AMF3), в который записан сериализованный Dictionary {имя DSO: строковое представление содержимого DataContainer}
			
			// прочесть данные из файла
			//AirMediator.getFile(
			switch (currentMode)
			{
				case SHARED_OBJECT: 
					var ba:ByteArray = sharedObject.data[dsoName];
					ba.position = 0;
					var data:String = ba.readUTF();
					var dso:Object;
					try
					{
						dso = JSON.parse(data);
					}
					catch (e:Error)
					{
						if (errorHandler != null)
							errorHandler.call(null, storagePath + "\\" + dsoName + ".ddso" + " " + e.message);
						return;
					}
					
					if (resultHandler is IDataContainer)
					{
						resultHandler.setDataToContainer(dso)
					}
					else if (resultHandler is Function)
					{
						resultHandler.call(null, dso);
					}
					
					break;
				case FILE: 
					hash.put(storagePath + "\\" + dsoName + ".ddso", {resultHandler: resultHandler, errorHandler: errorHandler});
					AirMediator.getFile(storagePath + "\\" + dsoName + ".ddso", onDSOComplete, true, errorHandler);
					break;
				case CLOUD: 
					// сделать запрос к облаку на получение DSO
					// возможно, я сделаю работу с облаком через AirMediator
					
					break;
			
			}
		
		}
		
		/**
		 * Обработчик загрузки файла, содержащего DSO.
		 * Устанавливает DS
		 * @param	fi
		 */
		private function onDSOComplete(fi:FileInfo):void
		{
			var ba:ByteArray = fi.data;
			ba.position = 0;
			var data:String = ba.readUTF();
			
			var dso:Object;
			var handlers:Object = hash.get(fi.nativePath);
			
			// получить JSON-объект из ByteArray-файла, который представляет из
			// себя записанный DSO
			try
			{
				dso = JSON.parse(data);
			}
			catch (e:Error)
			{
				hash.remove(fi.nativePath);
				if (handlers.errorHandler != null)
					handlers.errorHandler.call(null, fi.nativePath + " " + e.message);
				return;
			}
			
			var resultHandler:* = handlers.resultHandler;
			
			if (resultHandler is IDataContainer)
			{
				resultHandler.setDataToContainer(data)
			}
			else if (resultHandler is Function)
			{
				resultHandler.call(null, data);
			}
		}
		
		/**
		 * функция-обработчик или
		 */
		public function getDataStructur():void
		{
		
		}
	
	}

}