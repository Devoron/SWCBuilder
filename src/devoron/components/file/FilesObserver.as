package devoron.file
{
	import adobe.utils.CustomActions;
	import away3d.containers.ObjectContainer3D;
	import away3d.core.base.Geometry;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.events.ParserEvent;
	import away3d.library.AssetLibrary;
	import away3d.library.assets.IAsset;
	import away3d.loaders.parsers.AWD2Parser;
	import away3d.loaders.parsers.AWDParser;
	import away3d.loaders.parsers.ImageParser;
	import away3d.loaders.parsers.ParserBase;
	import away3d.materials.MaterialBase;
	import away3d.materials.TextureMaterial;
	import away3d.textures.Texture2DBase;
	import com.adobe.air.filesystem.events.FileMonitorEvent;
	import com.adobe.air.filesystem.FileMonitor;
	import flash.filesystem.File;
	//import devoron.utils.searchandreplace.workers.SearchAndReplaceWorker.src.devoron.file.FilesObserver;
	//import devoron.audio.parsers.MP3Parser;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display3D.textures.TextureBase;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.net.FileReference;
	import flash.net.LocalConnection;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import org.aswing.util.HashMap;
	
	//import gui.grid.GridParser;
	//import preloader.PackageParser;
	
	/**
	 * ...
	 * @author Svyatoslav Sokolov
	 */
	public class FilesObserver
	{
		public static const INCLUDED_PARSERS:Vector.<Class> = Vector.<Class>([AWD2Parser, ImageParser, /* ParticleAnimationParser, ParticleGeometryParser, ParticleGroupParser, MP3Parser, GridParser*/]);
		private static var observeInterval:uint;
		private static var isInited:Boolean = false;
		private static var iniLoader:URLLoader;
		private static var iniFile:Array;
		private static var observeTimer:Timer;
		private static var pathToIniFile:String;
		private static var filesLoader:URLLoader;
		private static var swfLoader:Loader;
		private static var currentFileId:uint;
		private static var currentParser:ParserBase;
		private static var lastAddedFiles:Vector.<String> = new Vector.<String>();
		private static var fr:FileReference;
		private static var filesToLoad:Vector.<URLRequest> = new Vector.<URLRequest>();
		private static var filesToLoadIds:Vector.<uint> = new Vector.<uint>();
		static private var context:LoaderContext;
		
		private static var localConnection:LocalConnection;
		
		private static const AIR_MODE:String = "air_mode";
		private static const FLASH_MODE:String = "air_mode";
		
		private static var fileMonitors:Vector.<FileMonitor> = new Vector.<FileMonitor>();
		
		private static var pfa:HashMap = new HashMap(); // paths to files(String) as keys, {modificationDate:String, listener:Function, parsing:Boolean, args:args} as value
		
		/**
		 * Добавление файла для наблюдения. 
		 * @param	pathToFile
		 * @param	functionOnChange
		 * @args аргументы передаваемые в функцию
		 */
		public static function addFileToObserve(path:String, changeListener:Function, needDownload:Boolean = false, parsing:Boolean = false, ...args):void
		{
			//var path2:String = path.replace(/\\/g, '\\\\');
			
			//text = text.replace(/\\/g, '/');
			//pfa.put(fm.file.nativePath, {modificationDate: "", listener: changeListener, args: args, parsing: parsing});
			
			//if (localConnection)
				//localConnection.send("app#AirMediator:toAirMediator", "execute", "watchFile", {path: path, listener: fileProcessBegin, interval: 1000});
			//watchChange(path, 1000, changeListener, needDownload, parsing, args);
			watchChange(path, 200, changeListener, needDownload, parsing, args);
		}
		
		private static function watchChange(path:String, interval:uint, changeListener:Function, needDownload:Boolean=false, parsing:Boolean = false, ...args):void
		{
			//messageTF.text = "watch change: " + path;
			var fm:FileMonitor
			for each (fm in fileMonitors)
				if (fm.file.nativePath == path)
					return;
					
			fm = new FileMonitor(new File(path), interval);
			
			pfa.put(fm.file.nativePath.replace(/\\/g, '\\'), {modificationDate: "", listener: changeListener, args: args, parsing: parsing});
			
			if (needDownload)
				fm.addEventListener(FileMonitorEvent.CHANGE, watchingFileChangeHandler2);
			else
				fm.addEventListener(FileMonitorEvent.CHANGE, watchingFileChangeHandler);
			fm.watch();
			fileMonitors.push(fm);
		}
		
		private static function watchingFileChangeHandler(e:FileMonitorEvent):void
		{
			var file:File = e.file;
			try
			{
				var fileInfo:FileInfo = FileInfo.fileInfoFromFile(file);
				//messageTF.text = file.modificationDate.toTimeString();
				//AsyncToken(lcs.remoteClient.watchChangeHandler(fileInfo)).addResponder(new Responder(null, null));
				
				
				//pfa.put(path, {modificationDate: "", listener: changeListener, args: args, parsing: parsing});
				//var func:Function = ((pfa.get(file.nativePath) as Object).listener as Function);
				var func:Object = pfa.get(file.nativePath) as Object;
				func.listener.call(null, fileInfo);
				//"F:\\Projects\\projects\\flash\\studio\\Studio13\\assets\\images\\3736.jpg"
				//"F:\\Projects\\projects\\flash\\studio\\Studio13\\assets\\images\\3736.jpg"
			}
			catch (e:Error)
			{
				trace(e);
				//messageTF.text = e.message;
			}
		}
		
		private static function watchingFileChangeHandler2(e:FileMonitorEvent):void
		{
			var file:File = e.file;
			try
			{
				var fileInfo:FileInfo = FileInfo.fileInfoFromFile(file, true);
				//messageTF.text = file.modificationDate.toTimeString();
				//AsyncToken(lcs.remoteClient.watchChangeHandler(fileInfo)).addResponder(new Responder(null, null));
				//file.nativePath = 
				
				
				//var path:String = file.nativePath.replace(/\\/g, '\\');
				var func:Object = pfa.get(file.nativePath) as Object;
				trace(func);
				if (func)
				if("listener" in func)
				func.listener.call(null, fileInfo);
			}
			catch (e:Error)
			{
				trace(e);
				//messageTF.text = e.message;
			}
		}
		
		public static function removeFileToObserve(path:String):void
		{
			pfa.remove(path);
			
			var fm:FileMonitor
			for each (fm in fileMonitors){
				if (fm.file.nativePath == path){
				fm.unwatch();
				fileMonitors.splice(fileMonitors.indexOf(fm), 1)
				}
			}
				
				
					//return;
			
		/*	if (localConnection)
				localConnection.send("app#AirMediator:toAirMediator", "execute", "unwatchFile", {path: path});*/
		}
		
		/**
		 * Инициализация наблюдателя.
		 * @param	pathToIniFile
		 * @param	observeInterval
		 */
		public static function init(localConnection:LocalConnection = null, pathToIniFile:String = "../assets/updates.ini", observeInterval:uint = 200):void
		{
			if (isInited)
				return;
			
			FilesObserver.observeInterval = observeInterval;
			FilesObserver.pathToIniFile = pathToIniFile;
			FilesObserver.localConnection = localConnection;
			
			if (!localConnection)
			{
				iniLoader = new URLLoader();
				iniLoader.addEventListener(Event.COMPLETE, onIniFileLoaded);
				iniLoader.addEventListener(IOErrorEvent.IO_ERROR, onIniFileLoadingError);
				
				observeTimer = new Timer(observeInterval);
				observeTimer.addEventListener(TimerEvent.TIMER, loadIniFile);
				observeTimer.start();
				
				filesLoader = new URLLoader();
				filesLoader.addEventListener(Event.COMPLETE, onChangedFileLoadingComplete);
				filesLoader.addEventListener(IOErrorEvent.IO_ERROR, onChangedFileLoadingError);
				filesLoader.dataFormat = URLLoaderDataFormat.BINARY;
			}
			
			isInited = true;
		}
		
		/**
		 * Начало обработки наблюдаемого файла.
		 * (С проверкой того, что файл наблюдаем)
		 * (Вызывается после получения данных от ini-файла
		 * или командой из LocalConnection от AirMediator'a)
		 * Добавляет путь к файлу в массив файлов для загрузки,
		 * приостанавливает наблюдение и вызывает загрузку первого файла.
		 * @param	pathToFile
		 */
		public static function fileProcessBegin(path:String, dateModification:String = ""):void
		{
			gtrace("file process begin " + path);
			var fileObj:Object = pfa.get(path);
			if (fileObj)
			{
				if (fileObj.parsing == true)
				{
					filesToLoad.push(new URLRequest(path));
					pauseObserve();
					filesLoader.load(filesToLoad[0]);
				}
				{
					if (fileObj.args.lenght > 0)
						fileObj.listener.call(null, fileObj.args);
					else
						fileObj.listener.call();
				}
			}
		}
		
		/**
		 * Завершение обработки наблюдаемого файла.
		 * (файл распарсен, битые данные, неудача загрузки и др.)
		 * Удаляет файл из массива файлов подлежащих загрузке,
		 * а после проверяет, есть ли ещё файлы для загрузке и, если есть, то загружает следующий
		 * файл, иначе - вызывает функцию - продолжить наблюдение.
		 */
		private static function fileProcessEnd():void
		{
			filesToLoad.removeAt(0);
			filesToLoadIds.removeAt(0);
			if (filesToLoad.length != 0)
				filesLoader.load(filesToLoad[0]);
			else
				continueObserve();
		}
		
		/**
		 * Продолжить наблюдение.
		 */
		private static function continueObserve():void
		{
			observeTimer.start();
		}
		
		/**
		 * Приостановить наблюдение.
		 */
		private static function pauseObserve():void
		{
			observeTimer.stop();
		}
		
		//**************************************************** FLASH - MODE ***************************************	
		
		/**
		 * Загрузка ini-файла.
		 * @param	e
		 */
		private static function loadIniFile(e:TimerEvent):void
		{
			iniLoader.load(new URLRequest(pathToIniFile));
		}
		
		/**
		 * Обработчик завершения загрузки ini-файла.
		 * @param	e
		 */
		private static function onIniFileLoaded(e:Event):void
		{
			var lines:Array = (e.target as URLLoader).data.split("\n");
			var line:String;
			// циклом по всем строчкам файла
			for each (line in lines)
			{
				var data:Array = line.split("&");
				var path:String = data[0];
				var date:String = data[1];
				var file:Object = pfa.get(path);
				
				if (!file)
				{
					if (file.modificationDate != date)
					{
						file.modificationDate = date;
						fileProcessBegin(path);
					}
				}
			}
		}
		
		private static function onIniFileLoadingError(e:IOErrorEvent):void
		{
			gtrace("3:Ini file loading error " + e.text);
		}
		
		//**************************************************** AIR - MODE ***************************************	
		
		//**************************************************** ♪ FILE LOADING EVENT HANDLERS ***************************************	
		
		/**
		 * Обработчик завершения загрузки изменённого файла.
		 * Получает парсер согласно расширению файла, устанавливает на парсер необходимые слушатели
		 * событий и запускает парсинг.
		 * @param	e
		 */
		private static function onChangedFileLoadingComplete(e:Event):void
		{
			var parsingField:String = URLRequest(filesToLoad[0]).url;
			var extension:String = (parsingField.substring(parsingField.indexOf(".") + 1, parsingField.length)).toLowerCase();
			
			currentParser = getParserFromExtension(extension);
			
			if (!currentParser)
			{
				gtrace("3:No parser for " + URLRequest(filesToLoad[0]).url);
				fileProcessEnd();
				return;
			}
			currentParser.addEventListener(ParserEvent.PARSE_ERROR, onParseError);
			currentParser.addEventListener(ParserEvent.PARSE_COMPLETE, onParseComplete);
			currentParser.addEventListener(AssetEvent.TEXTURE_SIZE_ERROR, onTextureSizeError);
			currentParser.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete);
			currentParser.parseAsync((e.currentTarget as URLLoader).data);
		}
		
		/**
		 * Ошибка в загрузке изменённого файла.
		 * Удалить незагруженный файл из массива файлов, подлежащих загрузке.
		 * Если есть ещё файлы для загрузки, то продолжить загрузку.
		 * @param	e
		 */
		private static function onChangedFileLoadingError(e:IOErrorEvent):void
		{
			gtrace("3:Change file loading error " + e.text);
			fileProcessEnd();
		}
		
		/**
		 * Обработчик завершения загрузки изменённого swf.
		 * @param	e
		 */
		private static function onChangedSwfLoadingComplete(e:Event):void
		{
			//var id:uint = filesToLoadIds[0];
			//functionsOnChange[id].call(null, swfLoader.content);
		
			//swfLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onChangedFileLoadingError);
			//swfLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onChangedSwfLoadingComplete);
		
			//fileProcessEnd();
		}
		
		//**************************************************** ♪ PARSER EVENT HANDLERS  ***************************************	
		
		/**
		 * Обработчик ошибки размера текстуры.
		 * @param	e
		 */
		private static function onTextureSizeError(e:AssetEvent):void
		{
			gtrace("3:Texture size must be power of two! " + URLRequest(filesToLoad[0]).url);
			fileProcessEnd();
		}
		
		/**
		 * Обработчик ошибки парсинга.
		 * @param	e
		 */
		private static function onParseError(e:ParserEvent):void
		{
			gtrace("3:Pasing error " + URLRequest(filesToLoad[0]).url);
			fileProcessEnd();
		}
		
		/**
		 * Обработчик завершения создания ассета.
		 * @param	e
		 */
		private static function onAssetComplete(e:AssetEvent):void
		{
			gtrace(e.asset.assetType);
			if (filesToLoad.length > 0)
			{
				var id:uint = filesToLoadIds[0];
				
				var fileObj:Object = pfa.get(URLRequest(filesToLoad[0]).url);
				
				//if(fileObj.args!=null) fileObj.listener.call(null, e.asset, argsForFunctions[id][0], argsForFunctions[id]);
				if (fileObj.args != null)
					fileObj.listener.call(null, e.asset, fileObj.args);
				else
					fileObj.listener.call(null, e.asset);
			}
		}
		
		/**
		 * Обработчик завершения парсинга.
		 * @param	e
		 */
		private static function onParseComplete(e:ParserEvent):void
		{
			currentParser.removeEventListener(ParserEvent.PARSE_ERROR, onParseError);
			currentParser.removeEventListener(ParserEvent.PARSE_COMPLETE, onParseComplete);
			currentParser.removeEventListener(AssetEvent.TEXTURE_SIZE_ERROR, onTextureSizeError);
			currentParser.removeEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete);
			
			fileProcessEnd();
		}
		
		/**
		 * Получить парсер для данного типа файла.
		 * @param	byteArray
		 * @return
		 */
		private static function getParserFromExtension(extension:String):ParserBase
		{
			switch (extension)
			{
				case "awd": 
					return new AWD2Parser;
					break;
				case "atf": 
					return new ImageParser;
					break;
				case "png": 
					return new ImageParser;
					break;
				case "awp": 
					//return new ParticleAnimationParser;
					break;
				case "jpeg": 
					//return new ParticleGeometryParser;
					break;
				/*case "mp3":
				   return new MP3Parser;
				   break;*/
				case "swf": 
				{
					//var id:uint = filesToLoadIds[0];
					//functionsOnChange[id].call(null, byteArray);
				}
					break;
			}
			return null;
		}
	
	}

}