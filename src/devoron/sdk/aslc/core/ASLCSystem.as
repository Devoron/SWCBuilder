package devoron.sdk.aslc.core
{
	import devoron.aslc.core.ICodeController;
	import devoron.file.FileInfo;
	import devoron.file.FilesObserver;
	import devoron.sdk.aslc.core.bytecode.BytecodeController;
	import devoron.sdk.aslc.core.bytecode.events.BytecodeControllerEvent;
	import devoron.sdk.aslc.core.code.events.CodeControllerEvent;
	import devoron.sdk.aslc.core.code.ICodeController;
	import devoron.sdk.compiler.as3code.ClassProxy;
	import devoron.studio.moduls.code.events.CodeEvent;
	import flash.utils.getQualifiedClassName;
	import org.aswing.util.HashMap;
	
	/**
	 * ASLCSystem
	 * @author Devoron
	 */
	public class ASLCSystem
	{
		private static var instance:ASLCSystem;
		public var swfController:BytecodeController;
		private var codeController:ICodeController;
		
		public var allClassProxies:HashMap;
		
		public function ASLCSystem()
		{
			allClassProxies = new HashMap();
		}
		
		/**
		 * 
		 * @param	instance
		 * @return ClassProxy для конкретного инстанса этого класса
		 */
		public static function getClassProxy(target:*):ClassProxy {
			return instance.getClassProxyForInstance(target);
		}
		
		public function getClassProxyForInstance(target:*):ClassProxy 
		{
			try {
				var className:String = getQualifiedClassName(target);
				//trace(className);
				// по имени класса осуществляется поиск в словаре всех прокси 
				//allClassProxies.put(className)
				var classProxy:ClassProxy = allClassProxies.get(className);
				
				return classProxy;
				if (!classProxy) {
					//classProxy = new ClassProxy(
				}
				
			}
			catch (e:Error) {
				
			}
			
			return null;
		}
		
		public static function init(codeController:ICodeController = null, swfController:BytecodeController = null):ASLCSystem
		{
			if (instance)
				throw new Error("ASLCSystem already inited");
			
			instance = new ASLCSystem();
			instance.setCodeController(codeController);
			instance.setSwfController(swfController);
			return instance;
		}
		
		public function setCodeController(codeController:ICodeController):void
		{
			this.codeController = codeController;
			codeController.addEventListener(CodeControllerEvent.APPEND_MEMBER, onMemberAppend);
			codeController.addEventListener(CodeControllerEvent.REMOVE_MEMBER, onMemberRemoved);
			codeController.addEventListener(CodeControllerEvent.CHANGE_MEMBER, onMemberChanged);
		
		}
		
		public function setSwfController(swfController:BytecodeController):void
		{
			this.swfController = swfController;
			swfController.addEventListener(BytecodeControllerEvent.MEMBER_BYTECODE_COMPLETE, onMemberBytecodeComplete);
			//swfController.addEventListener(CodeEvent.APPEND_MEMBER, onMemberAppend);
			//swfController.addEventListener(CodeEvent.APPEND_MEMBER, onMemberRemoved);
			//swfController.addEventListener(CodeEvent.APPEND_MEMBER, onMemberChanged);
		
		}
		
		public function processSourceCode(sourceCode:String, path:String, targetMethods:HashMap = null):void
		{
			codeController.processSourceCode(sourceCode, path, targetMethods);
		}
		
		/**
		 * Обработчик события генерация байткода для live-методов и полей.
		 * @param	e
		 */
		private function onMemberBytecodeComplete(e:BytecodeControllerEvent):void
		{
			// далее - отправить байткод в рантайм - через клиент
		}
		
		/**
		 * Обработчик добавления нового IMember в исходном коде.
		 * @param	e
		 */
		public function onMemberAppend(e:CodeControllerEvent):void
		{
			trace(e);
			
			// регистрировать добавление в истории
			// сделать инъекцию для этого элемента кода
			
			//swfController
			
			// создать команду для swfController'a
			//if (!swfController)
				//throw new Error("SWF controller not defined in ASLCSystem");
			
			// для method'a или field'a компилируется swf, на основе данных от контроллера кода
			// 
			//var elementCodeBA:ByteArray = e.data;
			//swfController.compile(/*elementCodeBA*/);
			//swfController.compile();
			
			// register source code for observe
			
		}
		
		/**
		 * Обработчик добавления нового IMember в исходном коде.
		 * @param	e
		 */
		public function onMemberRemoved(e:CodeEvent):void
		{
		
		}
		
		/**
		 * Обработчик добавления нового IMember в исходном коде.
		 * @param	e
		 */
		public function onMemberChanged(e:CodeEvent):void
		{
		
		}
		
		public function setSelectedFile(fi:FileInfo):void
		{
			
			
			// необходимо открыть файл
			//AirMediator.openWithDefaultApplication(fi.nativePath);
			//dispatchEvent
			observeSourceCodeFile(fi.nativePath);
			codeController.setSelectedFile(fi);
		}
		
		private function observeSourceCodeFile(nativePath:String):void 
		{
			//AirMediator.watchChangeFile(nativePath, onFileChanged);
			FilesObserver.init();
			FilesObserver.addFileToObserve(nativePath, onFileChanged);
			//FilesObserver.
		}
		
		private function onFileChanged(fi:FileInfo):void 
		{
			codeController.setSelectedFile(fi);
		}
	
	}

}