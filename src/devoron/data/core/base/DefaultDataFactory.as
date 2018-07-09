package devoron.data.core.base
{
	import devoron.studio.moduls.code.processors.CodeEditorView;
	import org.aswing.util.HashMap;
	
	/**
	 * DefaultDataFactory
	 * @author Devoron
	 */
	public class DefaultDataFactory implements IDataFactory
	{
		protected var defaultDatas:HashMap = new HashMap();
		
		public function DefaultDataFactory()
		{
		
		}
		
		/* INTERFACE devoron.data.core.IDataFactory */
		
		public function registerDataStructurObject(dataName:String, dso:DataStructurObject):void
		{
			defaultDatas.put(dataName, dso);
		}
		
		public function unregisterDataStructurObject(dataName:String):void
		{
			defaultDatas.remove(dataName);
		}
		
		public function getData(dataName:String):DataStructurObject
		{
			try {
				var dso:DataStructurObject =  (defaultDatas.get(dataName) as DataStructurObject).clone();
				if (dso)
				return dso;
			}
			catch (e:Error) {
			//trace(e);
			
			var stackTraceLines:Array = e.getStackTrace().split("\n");
				// последний элемент - это текст ошибки, поэтому его исключаем
				stackTraceLines.shift();
				//stackTraceLines.pop();
				var stackLen:uint = stackTraceLines.length;
				for (var i:int = 0; i < stackLen; i++) {
				var stackLine:String = stackTraceLines[i];	
				// пропустить начало строки "at "
				var messageNum:String = String(stackLen - i-1);
				var codePath:String = stackLine.substring(3, stackLine.indexOf("["));
				var filePath:String = stackLine.substring(stackLine.indexOf("[")+1, stackLine.lastIndexOf(":"));
				var lineNum:String = stackLine.substring(stackLine.lastIndexOf(":"), stackLine.length-1);
					stackTraceLines[i] = {messageNum:messageNum, codePath:codePath, filePath:filePath, line:lineNum}
				}
				
				
				//CodeEditorTab.stackTraceModel.appendAll(stackTraceLines);
				// вывод должен быть в OutpuPanel
				if(CodeEditorView.stackTraceModel)
				CodeEditorView.stackTraceModel.appendAll(stackTraceLines);
			
			//actionScripts
			//CodeEditorView.stackTraceModel.
			}
			return null;
		}
		
		public function isDataSupported(dataName:String):Boolean
		{
			var data:* = defaultDatas.get(dataName);
			return (data != null && data != undefined);
		}
		
	
	}

}