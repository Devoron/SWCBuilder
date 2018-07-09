package devoron.aslc.moduls.project.data
{
	import devoron.data.VectorListModelDataComponent;
	import devoron.file.FileInfo;
	import devoron.utils.airmediator.AirMediator;
	import devoron.values.models.TreeModelValueComponent;
	import flash.filesystem.File;
	import flash.utils.Dictionary;
	import org.aswing.util.HashMap;
	
	public class SWCBuilderProject
	{
		private var fileList:Vector.<String>;
		private var rootPath:String;
		//private var _config:ProjectConfig;
		
		
		public static const TARGET_PLAYER:String = 'player';
		public static const TARGET_AIR:String = 'air';
		public static const TARGET_OTHER:String = 'other';
		
		//target player version
		public var targetPlayerVersion:String = '9.0.124';
		
		//paths
		public var sourcePaths:Vector.<String>;
		//public var libs:Vector.<String>;
		public var libsExtern:Vector.<String>;
		public var mainApp:String;
		//choose globals
		public var target:String;
		//load flex libs
		public var useFlex:Boolean = false;
		
		public var extractAbc:Boolean = false;
		public var createProjector:Boolean = false;
		
		//public var allComands:Vector.<CompilationCommand>;
		
		/*
		 * Проект должен иметь в себе набор команд для сборки.
		 * Команды образуются из парсинга ProjectConfig'a
		 *
		 */
		
		/**
		 * function onReady():void
		 */
		public function open(url:String, onReady:Function):void
		{
			fileList = new Vector.<String>();
			rootPath = url.replace(/\\/g, '/');
			if (rootPath.charAt(rootPath.length - 1) != '/')
				rootPath += '/';
			
			//debug('rootPath=' + rootPath);
			
			recListFiles(rootPath.substr(0, -1));
			
			//read config
			readTextFile(".dsproject", onFileRead);
		}
		
		public function onFileRead(str:String):void
		{
			//_config.load(XML(str));
		
			//onReady();
		}
		
		public function get path():String
		{
			return rootPath;
		}
		
		public function get name():String
		{
			var tmp:String = path.substr(0, -1);
			return tmp.substr(tmp.lastIndexOf('/') + 1);
		}
		
		private function recListFiles(path:String):void
		{
			//gtrace(path);
		/*var file:File = new File(path);
		   fileList.push(path.substr(rootPath.length));
		   if (!file.isDirectory)
		   return;
		   for each (var f:File in file.getDirectoryListing())
		   recListFiles(path + '/' + f.name);*/
		}
		
		public function isDirectory(path:String):Boolean
		{
			//return new File(rootPath).resolvePath(path).isDirectory
			var fi:FileInfo = new FileInfo();
			fi.nativePath = path;
			return fi.isDirectory;
		}
		
		public function listFiles():Vector.<String>
		{
			return fileList;
		}
		
		/**
		 * function onReady(source:String):void
		 */
		public function readTextFile(url:String, onReady:Function):void
		{
			//gtrace(url);
			var rootFile:FileInfo = new FileInfo();
			rootFile.nativePath = rootPath;
			//.resolvePath(url)
			var file:FileInfo = new FileInfo();
			file.nativePath = rootFile.nativePath + "\\" + url;
			filesReading[file] = true;
			onReadyFuncs.put(file.nativePath, onReady);
			AirMediator.getFile(file.nativePath, onTextFileLoaded, true);
		}
		
		private var onReadyFuncs:HashMap = new HashMap();
		
		private function onTextFileLoaded(fi:FileInfo):void
		{
			// лютая проверка ваще
			if (fi.data[0] == 239 && fi.data[1] == 187 && fi.data[2] == 191)
				fi.data.position = 3;
			
			//onReady(fi.data.readUTFBytes(fi.data.bytesAvailable));
			//onReadyFuncs.put(file.nativePath, onReady);
			
			var str:String = fi.data.readUTFBytes(fi.data.bytesAvailable);
			(onReadyFuncs.get(fi.nativePath) as Function).call(str);
			
			onReadyFuncs.remove(fi.nativePath);
			//onReady(fi.data.readUTFBytes(fi.data.bytesAvailable);
			delete filesReading[fi];
		}
		
		private var filesReading:Dictionary = new Dictionary;
		
		/**
		 * function onReady(data:ByteArray):void
		 */
		public function readBinFile(url:String, onReady:Function):void
		{
			/*if (url.indexOf('sdk://') == 0)
			{
				SDKCompiler.getSDKFile(url, onReady);
			}
			else
			{
				if (CONFIG::air)
				{
					var file:File = new File(rootPath).resolvePath(url);
					filesReading[file] = true;
					file.load();
					file.addEventListener(Event.COMPLETE, function(e:Event):void
					{
						onReady(file.data);
						delete filesReading[file];
					});
				}
			}*/
		}
		
		/**
		 * function onReady(success:Boolean):void
		 */
		public function saveFile(path:String, data:String, onReady:Function = null):void
		{
			//new File(rootPath).resolvePath(url)
			AirMediator.writeToFile(path, data, null, onReady);
		}
		
		public function unlink(url:String, onReady:Function = null):void
		{
			//gtrace(url);
			//var file:File = new File(rootPath).resolvePath(url);
		/*	if (file.isDirectory)
		   file.deleteDirectory(true);
		   else
		   file.deleteFile();
		   if (onReady != null)
		   onReady();*/
		}
		
		public function newDir(url:String, onReady:Function = null):void
		{
			//if (CONFIG::air)
			//{
				new File(rootPath).resolvePath(url).createDirectory();
				if (onReady != null)
					onReady();
			//}
		}
		
		/**
		 * Загрузить настройки проекта.
		 * @param	asprops
		 */
		public function load(asprops:XML):void
		{
			//sourcePaths = new Vector.<String>;
			//libs = new Vector.<String>;
			//libsExtern = new Vector.<String>;
			//
			//mainApp = asprops.@mainApplicationPath;
			//
			//if (asprops.compiler.@useApolloConfig == 'true')
			//target = TARGET_AIR;
			//else
			//target = TARGET_OTHER;
			//
			//if (asprops.compiler.@targetPlayerVersion.length())
			//targetPlayerVersion = String(asprops.compiler.@targetPlayerVersion);
			//
			//createProjector = asprops.minibuilder.@projector == 'true';
			//extractAbc = asprops.minibuilder.@extract == 'true';
			//
			//sourcePaths.push(asprops.compiler.@sourceFolderPath);
			//for each (var n:* in asprops.compiler.compilerSourcePath.compilerSourcePathEntry)
			//sourcePaths.push(n.@path);
			//
			//useFlex = true;
			//
			//for each (n in asprops.compiler.libraryPath.libraryPathEntry)
			//{
			//if (n.excludedEntries.length())
			//{
			//for each (var ex:* in n.excludedEntries.libraryPathEntry)
			//if (ex.@path.indexOf('framework.swc') != -1)
			//{
			//useFlex = false;
			//break;
			//}
			//}
			//
			////we have sdk libs
			//if (n.@kind == 4 && target == TARGET_OTHER)
			//target = TARGET_PLAYER;
			//
			//if (n.@kind == 1 && n.@linkType == 1)
			//libs.push(n.@path);
			//else if (n.@kind == 1 && n.@linkType == 2)
			////libsExtern.push(n.@path);
			//}
			//
			//if (target == TARGET_OTHER)
			//useFlex = false;
		}
		
		public function get appName():String
		{
			return mainApp.substring(mainApp.lastIndexOf('/') + 1, mainApp.lastIndexOf('.'));
		}
		
		public function doTemplate(template:XML):void
		{
			template.@mainApplicationPath = mainApp;
			template.applications.application.@path = mainApp;
			
			if (target == TARGET_AIR)
				template.compiler.@useApolloConfig = 'true';
			else if (target == TARGET_PLAYER)
			{
				var ex:XML = <libraryPathEntry kind="4" path=""><excludedEntries/></libraryPathEntry>;
				if (useFlex)
					ex.excludedEntries.appendChild(<libraryPathEntry kind="3" linkType="1" path="${PROJECT_FRAMEWORKS}/libs/flex.swc" useDefaultLinkType="false"/>);
				else
					ex.excludedEntries.appendChild(<libraryPathEntry kind="3" linkType="1" path="${PROJECT_FRAMEWORKS}/libs/framework.swc" useDefaultLinkType="false"/>);
				template.compiler.libraryPath[0].appendChild(ex);
			}
			
			if (createProjector)
				template.minibuilder.@projector = 'true';
			if (extractAbc)
				template.minibuilder.@extract = 'true';
		}
	
	}

}

