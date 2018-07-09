package devoron.utils.airmediator
{
	import devoron.data.core.base.IDataContainer;
	import devoron.file.FileInfo;
	import devoron.file.FileInfoPoint;
	import devoron.file.LOC;
	import devoron.file.NATIVE;
	import devoron.utils.airmediator.AirMediatorResponder;
	import devoron.utils.ErrorInfo;
	import flash.events.StatusEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import org.aswing.util.HashMap;
	
	use namespace LOC;
	
	/**
	 * AirMediator
	 * @author Devoron
	 */
	
	[Event(name="status",type="flash.events.StatusEvent")]
	
	public class AirMediator
	{
		//public namespace LOC;
		//public namespace NAT = "http://www.example.com/individual";
		
		private static var instance:AirMediator = null;
		
		private static var connectListeners:Vector.<Function> = new Vector.<Function>();
		
		// содержит все обработчики результатов изменений файлов key:path, value:Function
		public var watchChangeHandlers:Dictionary = new Dictionary(true);
		
		// содержит все обработчики результатов создания файлов key:path, value:Function
		public var watchCreateHandlers:Dictionary = new Dictionary(true);
		
		// содержит все обработчики результатов удаления файлов key:path, value:Function
		public var watchDeleteHandlers:Dictionary = new Dictionary(true);
		
		// содержит все обработчики перетаскивания файлов на приложение AirMediator
		public var dragAndDropHandlers:Vector.<Function> = new Vector.<Function>();
		
		public static var currentMode:Namespace = LOC;
		
		public static const BOOLEAN:String = "boolean";
		public static const BYTE:String = "byte";
		public static const BYTES:String = "bytes";
		public static const DOUBLE:String = "double";
		public static const FLOAT:String = "float";
		public static const INT:String = "int";
		public static const MULTI_BYTE:String = "multi_byte";
		public static const OBJECT:String = "object";
		public static const SHORT:String = "short";
		public static const UNSIGNED_INT:String = "unsigned_int";
		public static const UTF:String = "utf";
		public static const UTF_BYTES:String = "utf_bytes";
		
		public function AirMediator()
		{
			if (AirMediator.instance)
			{
				throw new Error("AirMediator already initialized!");
				return;
			}
		
		}
		
		/**
		 * Инициализация AirMediator'a.
		 */
		public static function init(ns:Namespace = LOC):void
		{
			if (!AirMediator.instance)
			{
				AirMediator.instance = new AirMediator();
				currentMode = ns;
				// сохранить класс(тип) объекта при шифровании объекта в формат AMF.
				registerClassAlias("devoron.file.FileInfoPoint", FileInfoPoint);
				//registerClassAlias("devoron.factories.LiveAsset", LiveAsset);
				registerClassAlias("devoron.file.FileInfo", FileInfo);
				registerClassAlias("devoron.utils.ErrorInfo", ErrorInfo);
				registerClassAlias("flash.utils.ByteArray", ByteArray);
				registerClassAlias("String", String);
				registerClassAlias("Array", Array);
				
				if (ns == NATIVE)
				{
					for each (var listener:Function in connectListeners)
					{
						listener.call(null, new StatusEvent(StatusEvent.STATUS, false, false, "connected", "status"));
							//isConnected = true;
					}
				}
				
			}
		}
		
		static public function initAsAir():void
		{
		
		}
		
		/**
		 * Установка локального соединения.
		 */
		public static function connect():void
		{
		/*if (AirMediator.instance.lcs.connected)
		   return;
		 AirMediator.instance.lcs.connect("app#AirMediator:toAirMediator");*/
		}
		
		/**
		 * Закрытие локального соединения.
		 */
		public static function disconnect():void
		{
		/*if (AirMediator.instance.lcs.connected)
		 AirMediator.instance.lcs.close();*/
		}
		
		/**
		 * Добавить слушатель изменения состояния соединения.
		 * @param	listener Слушатель. Принимает StatusEvent.
		 */
		public static function addConnectListener(listener:Function):void
		{
			//connectListeners.push(listener);
		}
		
		/**
		 * Удалить слушатель изменения состояния соединения.
		 * @param	listener
		 */
		public static function removeConnectListener(listener:Function):void
		{
		/*var id:int = connectListeners.indexOf(listener);
		   if(id>0)
		 connectListeners.removeAt(id);*/
		}
		
		public static function isConnected():Boolean
		{
			/*if (AirMediator.instance)
			   {
			   return AirMediator.instance.lcs.connected;
			   }
			 return false;*/
			return true;
		}
		
		/**
		 * Проверить соединение.
		 * Если соединение отсутствует, то при наличии обработчика ошибок,
		 * он будет вызван с аргументами - путь запрашиваемого объекта/процесса(String)
		 * и текстом "No local connection to AirMediator detected!".
		 * @param	path
		 * @param	errorHandler
		 * @return
		 */
		private static function checkConnection(path:String, errorHandler:Function = null):Boolean
		{
			/*if(AirMediator.instance){
			   if (!AirMediator.instance.lcs.connected)
			   {
			   if (errorHandler != null)
			   {
			   if (path != null)
			   {
			   errorHandler.call(null, path, "No local connection to AirMediator detected!");
			   }
			   else
			   {
			   errorHandler.call(null, path, "No local connection to AirMediator detected!");
			   }
			   }
			   return false;
			   }
			   return true;
			   }
			
			   if (errorHandler != null)
			   {
			   errorHandler.call(null, path, "AirMediator not inited!");
			 }*/
			return true;
		}
		
		//setDragAndDropedFiles
		
		/**
		 *
		 * @param	path Путь к контейнеру данных состоит из
		 * пути к группе ассетов, путь к отдельному ассету,
		 * путь к DataContainer
		 * Например, house2012.room2.room2:Door.mesh::
		 * @param	dataContainer
		 */
		public function setDataContainer(path:String, dataContainer:IDataContainer):void
		{
			// путь контейнеру данных
			// пакет с ресурсами, отдельные ресурсы типа. So
		
			// Во всех открытых редакторах происходит это при изменении
			// любого DataStructurObject'a (когда он выбран, то он становится заблокированным
			// для редактирования другими участниками процесса, как только пользователь перейдёт
			// на другой редакто или на другой объект в этом редакторе)
			// В списке ассетов blocked-ассеты должны отображаться с соответствующей иконкой.
			// И их невозможно выбирать, пока они не станут разблокированы.
			// Удалять участники группы могут только свои ассеты из таблицы.
			// Удалить. Переименовать. Перенести. Изменить.
			// Они будут обновлять ассеты друг у друга. И это - пиринговая сеть.
			// Хотя и локалки хватит для челвоек в одном помещении.
		}
		
		/**
		 * Установка перетасканных файлов на панель AirMediator.
		 * @param	files
		 */
		public function setDragAndDropedFiles(files:Array):void
		{
			for each (var func:Function in dragAndDropHandlers)
				func.call(null, files);
		}
		
		/**
		 * Устанавливает слушатель перетаскивания объектов на панель AirMediator.
		 * @param	func Слушатель окончания перетаскивания.
		 */
		public static function addDragAndDropListener(func:Function):void
		{
			if (!checkConnection(""))
				return;
			
			if (AirMediator.instance.dragAndDropHandlers.indexOf(func) == -1)
				AirMediator.instance.dragAndDropHandlers.push(func);
		}
		
		/**
		 * Удаляет слушатель перетаскивания объектов на панель AirMediator.
		 * @param	func Слушатель окончания перетаскивания.
		 */
		public static function removeDragAndDropListener(func:Function):void
		{
			var id:int = AirMediator.instance.dragAndDropHandlers.indexOf(func);
			if (id > -1)
				AirMediator.instance.dragAndDropHandlers.removeAt(id);
		}
		
		/**
		 * Запускает собственный процесс.
		 * @param	path Путь, по которому располагается исполняемый файл в операционной системе хоста.
		 * @param	arguments Аргументы командной строки, которые будут переданы процессу в момент запуска.
		 * @param	workingDirectory Путь, по которому располагается рабочий каталог для нового собственного процесса.
		 * @param	resultHandler Вызывается в случае успешного запуска. Принимает объект path(String) запускаемого процесса.
		 * @param	errorHandler Вызывается в случае ошибки запуска. Принимает объект path(String) запускаемого процесса и текст ошибки(String).
		 */
		public static function startNativeProcess(path:String, arguments:Vector.<String> = null, workingDirectory:String = null, resultHandler:Function = null, errorHandler:Function = null):void
		{
			//if (!checkConnection(path, errorHandler))
			//return;
			//AsyncToken(AirMediator.instance.lcs.remoteClient.startNativeProcess(path, arguments, workingDirectory)).addResponder(new AirMediatorResponder(path, resultHandler, errorHandler));
		}
		
		/**
		 * Попытка завершить собственный процесс.
		 * @param	path Путь, по которому располагается исполняемый файл в операционной системе хоста.
		 * @param	force  Должна ли программа при необходимости пытаться принудительно завершить собственный процесс.
		 * @param	resultHandler Вызывается в случае успешного завершения. Принимает объект path(String) завершаемого процесса.
		 * @param	errorHandler Вызывается в случае ошибки доступа по локальному соединению или завершения не запущенного процесса. Принимает объект path(String) завершаемого процесса и текст ошибки(String).
		 */
		public static function closeNativeProcess(path:String, force:Boolean = false, resultHandler:Function = null, errorHandler:Function = null):void
		{
			//if (!checkConnection(path, errorHandler))
			//return;
			//AsyncToken(AirMediator.instance.lcs.remoteClient.closeNativeProcess(path, force)).addResponder(new AirMediatorResponder(path, resultHandler, errorHandler));
		}
		
		/**
		 * Указывает, выполняется ли этот собственный процесс в настоящее время.
		 * @param	path Путь, по которому располагается исполняемый файл в операционной системе хоста.
		 * @param	resultHandler Вызывается в случае успешного завершения. Принимает объект path(String) интересуемого процесса и результат running(Boolean).
		 * @param	errorHandler Вызывается в случае ошибки доступа по локальному соединению или запроса не запущенного процесса. Принимает объект path(String) завершаемого процесса и текст ошибки(String).
		 */
		public static function isNativeProcessRunning(path:String, resultHandler:Function = null, errorHandler:Function = null):void
		{
			//if (!checkConnection(path, errorHandler))
			//return;
			//AsyncToken(AirMediator.instance.lcs.remoteClient.isNativeProcessRunning(path)).addResponder(new AirMediatorResponder(path, resultHandler, errorHandler));
		}
		
		/**
		 * Обеспечивает доступ к стандартному вводу этого собственного процесса.
		 * Этот канал используется для отправки данных этому процессу.
		 * @param	resultHandler
		 * @param	errorHandler
		 */
		public static function nativeProcessInputData(path:String, resultHandler:Function, data:ByteArray, errorHandler:Function = null):void
		{
			throw new Error("not working yet");
		}
		
		/**
		 * Закрывает поток ввода этого процесса. Некоторые программы командной строки ожидают закрытия потока ввода для запуска других операций.
		 * Закрытый поток нельзя открыть снова, пока процесс не завершит работу и будет запущен снова.
		 * @param	resultHandler
		 * @param	errorHandler
		 */
		public static function closeNativeProcessInputData(path:String, resultHandler:Function = null, errorHandler:Function = null):void
		{
			throw new Error("not working yet");
		}
		
		/**
		 * Обеспечивает доступ к стандартному вводу этого собственного процесса.
		 * Этот канал используется для отправки данных этому процессу.
		 * @param	resultHandler
		 * @param	errorHandler
		 */
		public static function nativeProcessOutputData(path:String, resultHandler:Function, data:ByteArray, errorHandler:Function = null):void
		{
			throw new Error("not working yet");
		}
		
		/**
		 * Закрывает поток ввода этого процесса. Некоторые программы командной строки ожидают закрытия потока ввода для запуска других операций.
		 * Закрытый поток нельзя открыть снова, пока процесс не завершит работу и будет запущен снова.
		 * @param	resultHandler
		 * @param	errorHandler
		 */
		public static function closeNativeProcessOutputData(path:String, resultHandler:Function = null, errorHandler:Function = null):void
		{
			throw new Error("not working yet");
		}
		
		/**
		 * Обеспечивает доступ к стандартному вводу этого собственного процесса.
		 * Этот канал используется для отправки данных этому процессу.
		 * @param	resultHandler
		 * @param	errorHandler
		 */
		public static function nativeProcessErrorData(path:String, resultHandler:Function, data:ByteArray, errorHandler:Function = null):void
		{
			throw new Error("not working yet");
		}
		
		/**
		 * Закрывает поток ввода этого процесса. Некоторые программы командной строки ожидают закрытия потока ввода для запуска других операций.
		 * Закрытый поток нельзя открыть снова, пока процесс не завершит работу и будет запущен снова.
		 * @param	resultHandler
		 * @param	errorHandler
		 */
		public static function closeNativeProcessErrorData(path:String, resultHandler:Function = null, errorHandler:Function = null):void
		{
			throw new Error("not working yet");
		}
		
		/**
		 * Возвращает FileInfo каталога рабочего стола.
		 * @param	resultHandler Принимает объект FileInfo каталога рабочего стола.
		 * @param	errorHandler Вызывается в случае ошибки доступа по локальному соединению.
		 */
		public static function getDesktopDirectory(resultHandler:Function, errorHandler:Function = null):void
		{
			var responder:AirMediatorResponder = new AirMediatorResponder(null, resultHandler, errorHandler);
			var fi:FileInfo = AirMediator.convertFileToFileInfo(File.desktopDirectory);
			var re:Object = new Object();
			re.result = fi;
			responder.responderResultFunction(re);
		
		}
		
		/**
		 * Возвращает FileInfo каталога с документами пользователя.
		 * @param	resultHandler Принимает объект FileInfo каталога с документами пользователя.
		 * @param	errorHandler Вызывается в случае ошибки доступа по локальному соединению.
		 */
		public static function getDocumentsDirectory(resultHandler:Function, errorHandler:Function = null):void
		{
			//if (CONFIG::air)
			//{
			var responder:AirMediatorResponder = new AirMediatorResponder(null, resultHandler, errorHandler);
			var fi:FileInfo = AirMediator.convertFileToFileInfo(File.documentsDirectory);
			var re:Object = new Object();
			re.result = fi;
			responder.responderResultFunction(re);
		/*}
		   else{
		   if (!checkConnection(null, errorHandler))
		   return;
		   AsyncToken(AirMediator.instance.lcs.remoteClient.getDocumentsDirectory()).addResponder(new AirMediatorResponder(null, resultHandler, errorHandler));
		 }*/
		}
		
		/**
		 * Возвращает FileInfo каталога пользователя.
		 * @param	resultHandler Принимает объект FileInfo каталога пользователя.
		 * @param	errorHandler Вызывается в случае ошибки доступа по локальному соединению.
		 */
		public static function getUserDirectory(resultHandler:Function, errorHandler:Function = null):void
		{
			//if (CONFIG::air)
			//{
			var responder:AirMediatorResponder = new AirMediatorResponder(null, resultHandler, errorHandler);
			var fi:FileInfo = AirMediator.convertFileToFileInfo(File.userDirectory);
			var re:Object = new Object();
			re.result = fi;
			responder.responderResultFunction(re);
		/*}
		   else{
		   if (!checkConnection(null, errorHandler))
		   return;
		   AsyncToken(AirMediator.instance.lcs.remoteClient.getUserDirectory()).addResponder(new AirMediatorResponder(null, resultHandler, errorHandler));
		 }*/
		
		}
		
		/**
		 *  Возвращается массив объектов FileInfo, в котором перечислены корневые каталоги файловой системы.
		 * @param	resultHandler Принимает объект Array, в котором перечислены корневые каталоги(FileInfo) файловой системы.
		 * @param	errorHandler Вызывается в случае ошибки доступа по локальному соединению.
		 */
		public static function getRootDirectories(resultHandler:Function, errorHandler:Function = null):void
		{
			/*	if (CONFIG::air)
			 {*/
			var responder:AirMediatorResponder = new AirMediatorResponder(null, resultHandler, errorHandler);
			
			var fis:Array = [];
			var file:File;
			var files:Array = File.getRootDirectories();
			for each (file in files)
				fis.push(AirMediator.convertFileToFileInfo(file));
			
			var re:Object = new Object();
			re.result = fis;
			responder.responderResultFunction(re);
		/*}
		   else{
		   if (!checkConnection(null, errorHandler))
		   return;
		   AsyncToken(AirMediator.instance.lcs.remoteClient.getRootDirectories()).addResponder(new AirMediatorResponder(null, resultHandler, errorHandler));
		 }*/
		}
		
		/**
		 * Получить файл.
		 * @param	path Путь к файлу.
		 * @param	resultHandler Принимает объект FileInfo запрашиваемого файла.
		 * @param	needDownload Eсли true, то свойство data у объекта FileInfo заполняется байтами загруженного файла
		 * @param	errorHandler Вызывается в случае ошибки загрузки, если needDownload true. Принимает путь(String)загружаемого файла и текст ошибки(String).
		 */
		public static function getFile(path:String, resultHandler:Function, needDownload:Boolean = false, errorHandler:Function = null):FileInfo
		{
			var responder:AirMediatorResponder = new AirMediatorResponder(path, resultHandler, errorHandler, needDownload);
			var file:File = new File(path);
			var fi:FileInfo = AirMediator.convertFileToFileInfo(file);
			var re:Object = new Object();
			re.result = fi;
			
			if (needDownload && file.exists)
			{
				var bytes:ByteArray = new ByteArray();
				var stream:FileStream = new FileStream();
				stream.open(file, FileMode.READ);
				stream.readBytes(bytes);
				stream.close();
				fi.data = bytes;
			}
			
			if (resultHandler)
				;
			responder.responderResultFunction(re);
			return fi;
		}
		
		public static function convertFileToFileInfo(file:File, deep:Boolean = false):FileInfo
		{
			var fileInfo:FileInfo = new FileInfo();
			fileInfo.name = file.name;
			fileInfo.extension = file.extension;
			fileInfo.icons = [];
			fileInfo.exists = file.exists;
			fileInfo.parentPath = file.parent ? file.parent.nativePath : "";
			
			//for each (var bd:BitmapData in file.icon.bitmaps) fileInfo.icons.push(bd.getPixels(bd.rect));
			
			fileInfo.icons = file.icon.bitmaps;
			
			fileInfo.isDirectory = file.isDirectory;
			fileInfo.isHidden = file.isHidden;
			fileInfo.nativePath = file.nativePath;
			fileInfo.exists = file.exists;
			fileInfo.type = file.type;
			if (file.exists)
			{
				fileInfo.size = file.size;
				fileInfo.modificationDate = file.modificationDate;
				fileInfo.creator = file.creator;
				fileInfo.creationDate = file.creationDate;
			}
			
			if (file.isDirectory && deep)
			{
				if (fileInfo.directoryListing == null)
					fileInfo.directoryListing = [];
				
				var listing:Array = file.getDirectoryListing();
				for each (var internalFile:File in listing)
				{
					fileInfo.directoryListing.push(convertFileToFileInfo(internalFile));
				}
				
			}
			
			return fileInfo;
		}
		
		/**
		 * Сохранить файл.
		 * @param	path Путь к файлу
		 * @param	data Массив байтов для записи.
		 * @param	resultHandler Вызывается в случае успешного сохранения. Принимает объект FileInfo сохранённого файла.
		 * @param	errorHandler Вызывается в случае ошибки сохранения. Принимает путь(String) сохраняемого файла и текст ошибки(String).
		 */
		static public function saveFile(path:String, data:ByteArray, resultHandler:Function = null, errorHandler:Function = null):void
		{
			//gtrace("Проверка соединения " + checkConnection(path, errorHandler));
			//if (!checkConnection(path, errorHandler))
			//return;
			//AsyncToken(AirMediator.instance.lcs.remoteClient.saveFile(path, data)).addResponder(new AirMediatorResponder(path, resultHandler, errorHandler));
			try
			{
				var fileStream:FileStream = new FileStream();
				var file:File = new File(path);
				fileStream.open(file, FileMode.WRITE);
				fileStream.writeBytes(data);
				fileStream.close();
				if (resultHandler != null)
					resultHandler.call(null, FileInfo.fileInfoFromFile(file, true));
			}
			catch (e:Error)
			{
				//errorHandler.call(null, path, e.message);
				trace(e.message, e.getStackTrace);
			}
		}
		
		/**
		 * Запись в файл.
		 * @param	path
		 * @param	data
		 * @param	type
		 * @param	params
		 * @param	resultHandler
		 * @param	errorHandler
		 */
		static public function writeToFile(path:String, data:*, type:String = "utf_bytes", params:Object = null, resultHandler:Function = null, errorHandler:Function = null):void
		{
			//gtrace("********* СЕРИАЛИЗАЦИЯ *********");
			var ba:ByteArray = new ByteArray();
			
			switch (type)
			{
				case BOOLEAN: 
					ba.writeBoolean(data);
					break;
				case BYTE: 
					ba.writeByte(data);
					break;
				case BYTES: 
					if (params)
						ba.writeBytes(data, params.offset, params.length);
					else
						ba.writeBytes(data)
					break;
				case DOUBLE: 
					ba.writeDouble(data);
					break;
				case FLOAT: 
					ba.writeFloat(data);
					break;
				case INT: 
					ba.writeInt(data);
					break;
				case MULTI_BYTE: 
					ba.writeMultiByte(data, params.charSet);
					break;
				case OBJECT: 
					ba.writeObject(data);
					break;
				case SHORT: 
					ba.writeShort(data);
					break;
				case UNSIGNED_INT: 
					ba.writeUnsignedInt(data);
					break;
				case UTF: 
					ba.writeUTF(data);
					break;
				case UTF_BYTES: 
					ba.writeUTFBytes(data);
					break;
			}
			
			AirMediator.saveFile(path, ba, resultHandler, errorHandler);
			//var file:File = new File(path);
		}
		
		/**
		 * Удалить файл.(Не путать с перемещением в корзину!)
		 * @param	path Путь к файлу.
		 * @param	resultHandler Вызывается в случае успешного удаления. Принимает объект FileInfo удалённого файла.
		 * @param	errorHandler Вызывается в случае ошибки удаления. Принимает путь(String) удаляемого файла и текст ошибки(String).
		 */
		static public function deleteFile(path:String, resultHandler:Function = null, errorHandler:Function = null):void
		{
			//if (!checkConnection(path, errorHandler))
			//return;
			//AsyncToken(AirMediator.instance.lcs.remoteClient.deleteFile(path)).addResponder(new AirMediatorResponder(path, resultHandler, errorHandler));
		}
		
		/**
		 * Переименовать все файлы в директории по регулярному выражению.
		 * @param	directoryPath Путь к директории.
		 * @param	pattern
		 */
		static public function renameFiles(directoryPath:String, pattern:RegExp, resultHandler:Function = null, errorHandler:Function = null):void
		{
			//if (fi.isDirectory){
			//for (var i:int = 0; i < fi.directoryListing.length; i++) 
			//{
			//var fi2:FileInfo = fi.directoryListing[i];
			//if (fi2.isDirectory)
			//AirMediator.getDirectory(fi2.nativePath, resultHandler, false);
			//else{
			//if (fi2.nativePath.lastIndexOf("Box.as") != -1){
			//AirMediator.getFile(fi2.nativePath, onFileLoaded, false);
			//}
			//}
			//
			//}
			//}
		}
		
		static public function removeFiles(directoryPath:String, pattern:RegExp):void
		{
		
		}
		
		/**
		 * Возвращает объект FileInfo, содержащий массив объектов FileInfo, связанных с файлами и каталогами, размещенными в каталоге, расположенном по пути path. Данные корневого каталога записываются в основные свойства, массив объектов FileInfo - в directoryListing.
		 * @param	path Путь к файлу или директории.
		 * @param	resultHandler Принимает объект FileInfoSet.
		 * @param	needDownload Если true  и если объект не является каталогом, то свойство data у объекта FileInfo заполняется байтами файла. Если в каталоге будут содержаться вложенные каталоги, то при флаге true попытка загрузить каталог вызовет обработчик ошибок.
		 * @param	errorHandler Вызывается в случае ошибки доступа по локальному соединению или если файл не является каталогом. Принимает путь(String) запрашиваемого каталога и текст ошибки(String).
		 */
		static public function getDirectory(path:String, resultHandler:Function, needDownload:Boolean = false, errorHandler:Function = null):void
		{
			/*	if (CONFIG::air)
			 {*/
			
			var responder:AirMediatorResponder = new AirMediatorResponder(path, resultHandler, errorHandler, needDownload);
			
			var file:File = new File(path);
			var fi:FileInfo = AirMediator.convertFileToFileInfo(file);
			
			var re:Object = new Object();
			
			if (file.exists)
			{
				var files:Array = file.getDirectoryListing();
				fi.directoryListing = [];
				for each (file in files)
					fi.directoryListing.push(AirMediator.convertFileToFileInfo(file));
				
				re.result = fi;
				responder.responderResultFunction(re);
				return;
			}
			
			if (!file.exists)
			{
				re.result = fi;
				responder.responderResultFunction(re);
				return;
			}
			
			if (!file.isDirectory)
			{
				re.result = new ErrorInfo("File is not a directory");
				responder.responderResultFunction(re);
				return;
			}
		
		/*}
		   else{
		   if (!checkConnection(path, errorHandler))
		   return;
		   AsyncToken(AirMediator.instance.lcs.remoteClient.getDirectory(path)).addResponder(new AirMediatorResponder(path, resultHandler, errorHandler, needDownload));
		 }*/
		}
		
		private static var getDirectoryDictionary_ResultHandlerMediators:HashMap = new HashMap();
		private static var getDirectoryDictionary_ErrorHandlerMediators:HashMap = new HashMap();
		
		static public function getDirectoryDictionary(path:String, resultHandler:Function, needDownload:Boolean = false, errorHandler:Function = null):void
		{
			getDirectoryDictionary_ResultHandlerMediators.put(path, resultHandler);
			getDirectoryDictionary_ErrorHandlerMediators.put(path, errorHandler);
			AirMediator.getDirectory(path, getDirectoryDictionary_ResultHandlerMediator, false, getDirectoryDictionary_ErrorHandlerMediator);
		}
		
		static private function getDirectoryDictionary_ResultHandlerMediator(fi:FileInfo):void
		{
			getDirectoryDictionary_ErrorHandlerMediators.remove(fi.nativePath);
			getDirectoryDictionary_ResultHandlerMediators.remove(fi.nativePath).call(null, fi);
		
			// nativePath : ByteArray
		
		}
		
		static private function getDirectoryDictionary_ErrorHandlerMediator(path:String, message:String):void
		{
		/*getDirectoryDictionary_ResultHandlerMediators.remove(fi.nativePath);
		 getDirectoryDictionary_ErrorHandlerMediators.remove(fi.nativePath).call(null, fi);*/
		}
		
		/**
		 * Создать директорию.
		 * @param	path Путь к директории
		 * @param	resultHandler Принимает объект FileInfo созданной директории.
		 * @param	errorHandler Вызывается в случае ошибки создания директории. Принимает путь(String) создаваемой директории и текст ошибки(String).
		 */
		public static function createDirectory(path:String, resultHandler:Function = null, errorHandler:Function = null):void
		{
			//if (!checkConnection(path, errorHandler))
			//return;
			//AsyncToken(AirMediator.instance.lcs.remoteClient.createDirectory(path)).addResponder(new AirMediatorResponder(path, resultHandler, errorHandler));
		}
		
		/**
		 * Перемещает файл или каталог в корзину.
		 * @param	path Путь к файлу или директории
		 * @param	resultHandler Вызывается в случае успешного удаления. Принимает объект FileInfo удалённого файла.
		 * @param	errorHandler Вызывается в случае ошибки создания директории. Принимает путь(String) создаваемой директории и текст ошибки(String).
		 */
		public static function moveToTrash(path:String, resultHandler:Function = null, errorHandler:Function = null):void
		{
			/*	if (CONFIG::air)
			 {*/
			var responder:AirMediatorResponder = new AirMediatorResponder(path, resultHandler, errorHandler);
			
			var re:Object = new Object();
			var file:File = new File(path);
			try
			{
				file.moveToTrash();
				var fi:FileInfo = AirMediator.convertFileToFileInfo(file);
				re.result = fi;
				responder.responderResultFunction(re);
			}
			catch (e:Error)
			{
				//return new ErrorInfo(e.message);
				
				re.result = new ErrorInfo(e.message);
				responder.responderResultFunction(re);
			}
			//return null;
			//var re:Object = new Object();
			re.result = null;
			responder.responderResultFunction(re);
		/*}
		   else{
		
		   if (!checkConnection(path, errorHandler))
		   return;
		   AsyncToken(AirMediator.instance.lcs.remoteClient.moveToTrash(path)).addResponder(new AirMediatorResponder(path, resultHandler, errorHandler));
		 }*/
		}
		
		/**
		 * Открывает файл в программе, назначенной в операционной системе для открытия данного типа файлов.
		 * @param path Путь к файлу
		 * @param	errorHandler Вызывается в случае ошибки открытия файла. Принимает путь(String) открываемого файла и текст ошибки(String).
		 */
		public static function openWithDefaultApplication(path:String, errorHandler:Function = null):void
		{
			//if (!checkConnection(path, errorHandler))
			//return;
			//AsyncToken(AirMediator.instance.lcs.remoteClient.openWithDefaultApplication(path)).addResponder(new AirMediatorResponder(path, null, errorHandler));
			try
			{
				var file:File = new File(path);
				if (file.exists)
				{
					file.openWithDefaultApplication();
					trace("dsjfkdjsk " + file.modificationDate);
				}
				else
				{
					throw new Error("File not exists " + path);
				}
			}
			catch (e:Error)
			{
				if (errorHandler != null)
				{
					errorHandler.call(null, path, e.message);
				}
			}
		}
		
		/**
		 * Удалить директорию.
		 * @param	path Путь к директории
		 * @param	deleteDirectoryContents Указывает, можно ли удалять каталог, содержащий файлы или подкаталоги. При значении false вызов этого метода создает исключение, если каталог содержит файлы или подкаталоги.
		 * @param	resultHandler Вызывается в случае успешного удаления. Принимает объект FileInfo удалённой директории.
		 * @param	errorHandler Вызывается в случае ошибки удаления. Принимает путь(String) удаляемой директории и текст ошибки(String).
		 */
		public static function deleteDirectory(path:String, deleteDirectoryContents:Boolean = false, resultHandler:Function = null, errorHandler:Function = null):void
		{
			//if (!checkConnection(path, errorHandler))
			//return;
			//AsyncToken(AirMediator.instance.lcs.remoteClient.deleteDirectory(path, deleteDirectoryContents)).addResponder(new AirMediatorResponder(path, resultHandler, errorHandler));
		}
		
		/**
		 * Перемещает файл или каталог из места, заданного pathFrom, в место, заданное параметром pathTo.
		 * @param	pathFrom Путь к исходному расположению файла
		 * @param	pathTo Путь к конечному расположению файла
		 * @param	resultHandler Вызывается в случае успешного перемещения. Принимает объект FileInfo перемещённого файла или каталога.
		 * @param	overwrite При значении false перемещение не выполняется, если файл target уже существует. При значении true в ходе операции сначала стираются все существующие файлы или каталоги с таким же именем.
		 * @param	errorHandler Вызывается в случае ошибки перемещения. Принимает путь(String) перемещаемого файла или директории и текст ошибки(String).
		 */
		public static function moveTo(pathFrom:String, pathTo:String, overwrite:Boolean = false, resultHandler:Function = null, errorHandler:Function = null):void
		{
			//if (!checkConnection(pathFrom, errorHandler))
			//return;
			//AsyncToken(AirMediator.instance.lcs.remoteClient.moveTo(pathFrom, pathTo, overwrite)).addResponder(new AirMediatorResponder(pathFrom, resultHandler, errorHandler));
		}
		
		/**
		 * Наблюдать изменения файла или каталога.
		 * @param	path Путь к файлу или каталогу.
		 * @param	resultHandler Вызывается в случае изменения файла или каталога. Принимает объект FileInfo, изменённого файла или каталога.
		 * @param	needDownload Если true и если объект не является каталогом, то свойство data у объекта FileInfo заполняется байтами загруженного файла.
		 * @param interval Интервал обновления данных в миллисекундах.
		 * @param	errorHandler Вызывается в случае ошибки загрузки, если needDownload true или нет локального соединения. Принимает путь(String) загружаемого файла и текст ошибки(String).
		 */
		public static function watchChangeFile(path:String, resultHandler:Function, needDownload:Boolean = false, interval:uint = 1000, errorHandler:Function = null):void
		{
			if (!checkConnection(path, errorHandler))
				return;
			if (AirMediator.instance.watchChangeHandlers[path] != undefined)
				return;
			//AirMediator.instance.watchChangeResponders[path] = new AirMediatorResponder(path, resultHandler, errorHandler, needDownload);
			AirMediator.instance.watchChangeHandlers[path] = resultHandler;
			//AsyncToken(AirMediator.instance.lcs.remoteClient.watchChange(path, interval)).addResponder(new Responder(AirMediator.instance.watchChangeResultHandler, AirMediator.instance.watchChangeErrorHandler));
		//AsyncToken(AirMediator.instance.lcs.remoteClient.watchDelete(path)).addResponder(new AirMediatorResponder(path, resultHandler, errorHandler));
			// костыль здесь
			//AsyncToken(AirMediator.instance.lcs.remoteClient.watchChange(path, interval)).addResponder(new AirMediatorResponder(path, resultHandler, errorHandler, needDownload));
			//AsyncToken(AirMediator.instance.lcs.remoteClient.watchChange(path, interval)).addResponder(new AirMediatorResponder(path, AirMediator.instance.watchChangeHandler, AirMediator.instance.watchChangeError, true));
		}
		
		/**
		 * Наблюдать изменения файла или каталога.
		 * @param	path Путь к файлу или каталогу.
		 * @param	resultHandler Вызывается в случае изменения файла или каталога. Принимает объект FileInfo, изменённого файла или каталога.
		 * @param	level Уровень вложенности. Если папка содержит внутренние папки, то нужно ли просматривать их.
		 * @param	needDownload Если true и если объект не является каталогом, то свойство data у объекта FileInfo заполняется байтами загруженного файла.
		 * @param interval Интервал обновления данных в миллисекундах.
		 * @param	errorHandler Вызывается в случае ошибки загрузки, если needDownload true или нет локального соединения. Принимает путь(String) загружаемого файла и текст ошибки(String).
		 */
		public static function watchChangeDirectory(path:String, resultHandler:Function, deepChange:Boolean = true, needDownload:Boolean = false, interval:uint = 1000, createdHandler:Function = null, deletedHandler:Function = null, errorHandler:Function = null):void
		{
			if (!checkConnection(path, errorHandler))
				return;
			if (AirMediator.instance.watchChangeHandlers[path] != undefined)
				return;
			//AirMediator.instance.watchChangeResponders[path] = new AirMediatorResponder(path, resultHandler, errorHandler, needDownload);
			AirMediator.instance.watchChangeHandlers[path] = resultHandler;
			// необходимо получить содержимое директории, которая добавлена для наблюдения
			// если внутри есть вложенные директории, то рекурсивно забрать их
			
			//AsyncToken(AirMediator.instance.lcs.remoteClient.watchChange(path, interval)).addResponder(new Responder(AirMediator.instance.watchChangeResultHandler, AirMediator.instance.watchChangeErrorHandler));
			
			// костыль здесь
			//AsyncToken(AirMediator.instance.lcs.remoteClient.watchChange(path, interval)).addResponder(new AirMediatorResponder(path, resultHandler, errorHandler, needDownload));
			//AsyncToken(AirMediator.instance.lcs.remoteClient.watchChange(path, interval)).addResponder(new AirMediatorResponder(path, AirMediator.instance.watchChangeHandler, AirMediator.instance.watchChangeError, true));
			
			/*if (createdHandler!=null){
			   AirMediator.watchCreate(path, createdHandler, needDownload, interval, errorHandler);
			 }*/
			
			if (deletedHandler != null)
			{
				AirMediator.watchDelete(path, deletedHandler, interval, errorHandler);
			}
			//var chProp:ChangeProperties;
			
			if (deepChange)
			{
				var changeProperties:ChangeProperties = new ChangeProperties(path, resultHandler, needDownload, interval, createdHandler, deletedHandler, errorHandler);
				changePropertiesHash.put(path, changeProperties);
				AirMediator.getDirectory(path, watchChangeDirectoryLevel, false, errorHandler);
			}
		
		}
		
		static private const changePropertiesHash:HashMap = new HashMap();
		
		//static private const watchChangeDirectoryLevelResultHandlers:HashMap = new HashMap();
		//static private const watchChangeDirectoryLevelErrorHandlers:HashMap = new HashMap();
		
		/**
		 * Подпись на изменение вложенной директории.
		 * @param	directory
		 */
		static private function watchChangeDirectoryLevel(directory:FileInfo):void
		{
			var chProp:ChangeProperties;
			var files:Array = directory.directoryListing;
			var fi:FileInfo;
			if (files.length > 0)
			{
				for each (fi in files)
				{
					chProp = changePropertiesHash.getValue(fi.parentPath) as ChangeProperties;
					chProp.files.put(fi.nativePath, fi);
					if (fi.isDirectory)
					{
						watchChangeDirectory(fi.nativePath, chProp.resultHandler, true, chProp.needDownload, chProp.interval, chProp.errorHandler);
					}
					else
					{
						watchChangeFile(fi.nativePath, chProp.resultHandler, chProp.needDownload, chProp.interval, chProp.errorHandler);
					}
						//if(chProp.files.indexOf(fi)
					
				}
			}
		}
		
		static private function getParentChangeDirectoryPath():void
		{
		
		}
		
		public function watchChangeHandler(changedFile:FileInfo):void
		{
			if (watchChangeHandlers[changedFile.nativePath] != undefined)
			{
				if (!changedFile.data)
					getFile(changedFile.nativePath, watchChangeHandlers[changedFile.nativePath], true);
			}
		}
		
		public function watchChangeError():void
		{
			//if(errorHandler!=null) errorHandler.call(null, fi, e.message);
		}
		
		/**
		 * Наблюдать создание файла или каталога.
		 * @param	path Путь к файлу
		 * @param	resultHandler Вызывается в случае создания файла или каталога. Принимает объект FileInfo, созданного файла или каталога.
		 * @param	needDownload Если true  и если объект не является каталогом, то свойство data у объекта FileInfo заполняется байтами созданного файла.
		 * @param interval Интервал обновления данных в миллисекундах.
		 * @param	errorHandler Вызывается в случае ошибки загрузки, если needDownload true или нет локального соединения. Принимает путь(String) загружаемого файла и текст ошибки(String).
		 */
		public static function watchCreate(path:String, resultHandler:Function, needDownload:Boolean = false, interval:uint = 1000, errorHandler:Function = null):void
		{
			//if (!checkConnection(path, errorHandler))
			//return;
			//AsyncToken(AirMediator.instance.lcs.remoteClient.watchCreate(path, needDownload)).addResponder(new AirMediatorResponder(path, resultHandler, errorHandler, needDownload));
		}
		
		/**
		 * Наблюдать удаление(перемещение) файла или каталога.
		 * @param	path Путь к файлу
		 * @param	resultHandler Вызывается в случае удаления(перемещения) файла или каталога. Принимает объект FileInfo, изменённого файла или каталога.
		 * @param interval Интервал обновления данных в миллисекундах.
		 * @param	errorHandler Вызывается в случае ошибки доступа по локальному соединению. Принимает путь(String) отменяемого для наблюдений файла.
		 */
		public static function watchDelete(path:String, resultHandler:Function, interval:uint = 1000, errorHandler:Function = null):void
		{
			//if (!checkConnection(path, errorHandler))
			//return;
			//gtrace("5:watch delete " + path);
			//AsyncToken(AirMediator.instance.lcs.remoteClient.watchDelete(path)).addResponder(new AirMediatorResponder(path, resultHandler, errorHandler));
		}
		
		/**
		 * Отменить наблюдение изменений файла или каталога.
		 * @param	path Путь к наблюдаемому файлу или каталогу.
		 * @param	errorHandler Вызывается в случае ошибки доступа по локальному соединению. Принимает путь(String) отменяемого для наблюдений файла.
		 */
		public static function unwatchChange(path:String, errorHandler:Function = null):void
		{
			//if (!checkConnection(path, errorHandler))
			//return;
			//delete AirMediator.instance.watchChangeHandlers[path];
			//AsyncToken(AirMediator.instance.lcs.remoteClient.unwatchChange(path)).addResponder(new AirMediatorResponder(path, null, errorHandler));
		}
		
		/**
		 * Отменить наблюдение создания файла или каталога.
		 * @param	path Путь к наблюдаемому файлу или каталогу.
		 * @param	errorHandler Вызывается в случае ошибки доступа по локальному соединению. Принимает путь(String) отменяемого для наблюдений файла.
		 */
		public static function unwatchCreate(path:String, errorHandler:Function = null):void
		{
			//if (!checkConnection(path, errorHandler))
			//return;
			//delete AirMediator.instance.watchCreateHandlers[path];
			//AsyncToken(AirMediator.instance.lcs.remoteClient.unwatchCreate(path)).addResponder(new AirMediatorResponder(path, null, errorHandler));
		}
		
		/**
		 * Отменить наблюдение удаления(перемещения) файла или каталога.
		 * @param	path Путь к наблюдаемому файлу или каталогу.
		 * @param	errorHandler Вызывается в случае ошибки доступа по локальному соединению. Принимает путь(String) отменяемого для наблюдений файла.
		 */
		public static function unwatchDelete(path:String, errorHandler:Function = null):void
		{
			//if (!checkConnection(path, errorHandler))
			//return;
			//delete AirMediator.instance.watchDeleteHandlers[path];
			//AsyncToken(AirMediator.instance.lcs.remoteClient.unwatchDelete(path)).addResponder(new AirMediatorResponder(path, null, errorHandler));
		}
		
		static protected function onTimer(e:TimerEvent):void
		{
			if (!AirMediator.isConnected())
			{
				AirMediator.disconnect();
				AirMediator.connect();
			}
		}
	
	}

}
import org.aswing.util.HashMap;

internal class ChangeProperties
{
	
	public var path:String;
	public var createdHandler:Function;
	public var deletedHandler:Function;
	public var resultHandler:Function;
	public var needDownload:Boolean;
	public var interval:uint;
	public var errorHandler:Function;
	public var files:HashMap = new HashMap();
	
	public function ChangeProperties(path:String, resultHandler:Function, needDownload:Boolean = false, interval:uint = 1000, createdHandler:Function = null, deletedHandler:Function = null, errorHandler:Function = null)
	{
		this.deletedHandler = deletedHandler;
		this.createdHandler = createdHandler;
		this.path = path;
		this.resultHandler = resultHandler;
		this.needDownload = needDownload;
		this.interval = interval;
		this.errorHandler = errorHandler;
	}

}