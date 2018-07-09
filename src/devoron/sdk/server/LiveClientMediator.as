package devoron.sdk.server 
{
	import devoron.studio.codeeditor.events.CodeEvent;
	import devoron.studio.compiler.RemoteScope;
	import flash.events.Event;
	import flash.events.GlobalEventDispatcher;
	import org.as3commons.asblocks.api.IClassType;
	import org.as3commons.asbook.api.IASBookAccess;
	/**
	 * LiveClientMediator
	 * @author Devoron
	 */
	public class LiveClientMediator implements ILiveClientController
	{
		public var history:Array;
		
		public function LiveClientMediator(/*client:LiveClient*/) 
		{
			
			
			
			//GlobalEventDispatcher.instance.addEventListener(LiveServerEvent.ADD_SWC, onAddSWC);	// отслеживать добавление новой swc - если таковая была добавлена, то отправить её swf байты в live studio client с командой "addSWC"
			//GlobalEventDispatcher.instance.addEventListener(LiveServerEvent.ADD_CLASS, onAddSWC);	// отслеживать добавление нового класса - команда "addClass" и 
			//
			//GlobalEventDispatcher.instance.addEventListener(LiveServerEvent.ADD_METHOD, onMethodCodeAdded);
			//GlobalEventDispatcher.instance.addEventListener(LiveServerEvent.CHANGE_FIELD, onAddSWC);
			//GlobalEventDispatcher.instance.addEventListener(LiveServerEvent.CHANGE_METHOD, onAddSWC);
			//GlobalEventDispatcher.instance.addEventListener(LiveServerEvent.REMOVE_CLASS, onAddSWC);
			//GlobalEventDispatcher.instance.addEventListener(LiveServerEvent.REMOVE_FIELD, onAddSWC);
			//GlobalEventDispatcher.instance.addEventListener(LiveServerEvent.REMOVE_METHOD, onAddSWC);
			//GlobalEventDispatcher.instance.addEventListener(LiveServerEvent.REMOVE_SWC, onAddSWC);
			//GlobalEventDispatcher.instance.addEventListener(LiveServerEvent.GENERATE_SCRIPT, scriptGenerationHandler);
			
			
			
			// можно попробовать устроить медиатор именно через мост через Brige
			
			
			
			//if (stage)
				//initStage();
			//else
				//addEventListener(Event.ADDED_TO_STAGE, initStage);
			//server.addEventListener(LiveServerEvent.ADD_SWC, onAddSWC);
		}
		
		protected function onMethodCodeAdded(e:CodeEvent):void 
		{
			var liveGenerator:LiveGenerator = new LiveGenerator();
			//liveGenerator.generateScriptFromFunctionBody(remoteScope:RemoteScope, body:String, domain:ScriptDomain = null, compiler:AS3CodeCompiler = null):ScriptBytecode
		}
		
		protected function scriptGenerationHandler(e:CodeEvent):void 
		{
			//GlobalEventDispatcher.instance.dispatchEvent(new CodeEvent(CodeEvent.GENERATE_SCRIPT, compiledScript.name, "mu.hui", compiledScript.bytes);
			//var methodName:String = e.targetCompilationUnitPath;
			//var nm:String = methodName.split(":")[1];
				/*var classScope:RemoteScope = LiveCodeStrategy.scopeProxy;
				classScope[nm] = compiledScript.exe;
				compiledScript.name = methodName;
				compiledScript.addEventListener(ScriptEvent.LOAD, onScriptLoad);
				compiledScript.addEventListener(ScriptErrorEvent.SCRIPT_ERROR, onScriptError);
				compiledScript.load();*/
		}
		
		
		/* INTERFACE devoron.live.server.ILiveClientController */
		
		public function prepareScope(classType:IClassType, access:IASBookAccess):RemoteScope
		{
			var scopeFactory:ScopeFactory = new ScopeFactory();
			return scopeFactory.prepareScope(classType, access);
		}
		
		protected function onAddSWC(e:CodeEvent):void 
		{
			//history.push(e
		}
		
		
		
		
		private function initStage(e:Event = null):void
		{
			//removeEventListener(Event.ADDED_TO_STAGE, initStage);
			
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
			
			// 1. 
			//server.createGUI();
		
		/*AirMediator.addConnectListener(onConnectToAir);
		   AirMediator.init();*/
			   //init();
		}
		
		
	}

}