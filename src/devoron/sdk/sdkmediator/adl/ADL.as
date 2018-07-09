package devoron.sdk.sdkmediator.adl 
{
	import devoron.sdk.sdkmediator.ascsh.commands.CMD;
	import devoron.studio.moduls.code.data.CompilerMessage;
	import devoron.studio.moduls.code.tools.resultslist.CompilerMessagesList;
	import devoron.utils.ErrorInfo;
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.Event;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.system.ApplicationDomain;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	/**
	 * ADL
	 * @author Devoron
	 */
	public class ADL 
	{
		private var adlProcess:NativeProcess;
		private var domain:ApplicationDomain;
		private var workingDirectoryPath:String;
		
		private static var omg:Boolean = true;
		
		public function ADL() 
		{
			
		}
		
		/**
		 * Запуск оболочки ASCSH.
		 */
		public function startShell():void
		{
			// создаётся новый ApplicationDomain
			domain = new ApplicationDomain();
			
			adlProcess = new NativeProcess();
			adlProcess.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onStandardOutput);
			adlProcess.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onStandardError);
			adlProcess.addEventListener(NativeProcessExitEvent.EXIT, shellExit);
			
			var shellInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
			
			//F:\AIRSDK_Compiler\bin
			//shellInfo.executable = new File("C:\\Program Files (x86)\\Java\\jre1.8.0_121\\bin\\java.exe");
			//shellInfo.executable = new File("C:\\Program Files (x86)\\Java\\jre1.8.0_121\\bin\\java.exe");
			shellInfo.executable = new File("F:\\AIRSDK_Compiler\\bin\\adl.exe");
			
			var arg:Vector.<String> = new Vector.<String>;
			//arg.push("-jar");ewr
			//arg.push("F:\\AIRSDK_Compiler\\lib\\mxmlc-cli.jar");
			//arg.push("F:\\AIRSDK_Compiler\\lib\\ascsh.jar");
			//arg.push("F:\\AIRSDK_Compiler\\lib\\compiler.jar");
			
			//var omg:Array = tf2.getText().split("\n");
			//for (var j:int = 0; j < omg.length; j++) 
			//{
			//arg.push(omg[i]);
			//}
			
			//arg.push("F:\\Projects\\projects\\flash\\studio\\Studio13\\src\\Some.as");
			//arg.push("-load-config ");
			
			//if(omg){
			//arg.push("F:\\Projects\\projects\\flash\\studio\\Studio13\\config_adl.xml");
			//arg.push("F:\\Projects\\projects\\flash\\studio\\Studio13\\config_adl.xml");
			//omg = false;
			//}
			//else 
			//{
				//arg.push("F:\\Projects\\projects\\flash\\studio\\Studio13\\config_adl.xml");
				//arg.push("F:\\Projects\\projects\\flash\\studio\\Studio13\\application3.xml");
				//arg.push("F:\\Projects\\projects\\flash\\studio\\Studio13\\application.xml");
				arg.push("F:\\Projects\\projects\\flash\\studio\\Studio13\\application_adl.xml");
				//arg.push("--hui");
			//}
			
			
			
			//arg.push("F:\\Projects\\projects\\flash\\studio\\Studio13\\config_adl2.xml");
			//arg.push("F:\\Projects\\projects\\flash\\studio\\Studio13");
			//arg.push("-o");
			//arg.push("F:\\Projects\\projects\\flash\\studio\\Studio13\\src\\generated404.swf");
			//java.exe -jar lib/mxmlc.jar
			
			//shellInfo.executable = new File("F:\\AIRSDK_Compiler\\bin\\mxmlc.exe");
			//shellInfo.executable = new File("C:\\Program Files (x86)\\Java\\jre1.8.0_121\\bin\\java.exe -jar");
			
			//shellInfo.workingDirectory = new File(workingDirectoryTF.getText());
			shellInfo.workingDirectory = new File("F:\\Projects\\projects\\flash\\studio\\Studio13");
			
			shellInfo.arguments = arg;
			
			adlProcess.start(shellInfo);
			
		/*	var input2:IDataOutput = ascsh.standardInput;
			input2.writeUTFBytes(inputField.getText() + "\n");*/
		}
		
		
		public function setWorkingDirectory(workingDirectoryPath:String):void {
			this.workingDirectoryPath = workingDirectoryPath;
		}
		
		/**
		 * Запускает собственный процесс.
		 * @param	path Путь, по которому располагается исполняемый файл в операционной системе хоста.
		 * @param	arguments Аргументы командной строки, которые будут переданы процессу в момент запуска.
		 * @param	workingDirectory Путь, по которому располагается рабочий каталог для нового собственного процесса.
		 */
		public function startNativeProcess(path:String, arguments:Vector.<String> = null, workingDirectoryPath:String = null):Object
		{
			try
			{
				adlProcess = new NativeProcess();
				var processStartupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
				processStartupInfo.executable = new File(path);
				if (arguments)
					processStartupInfo.arguments = arguments;
				if (workingDirectoryPath)
					processStartupInfo.workingDirectory = new File(workingDirectoryPath);
				adlProcess.start(processStartupInfo);
				return adlProcess;
			}
			catch (e:Error)
			{
				trace(e.message);
				//messageTF.text = e.message;
				return new ErrorInfo(e.message);
			}
			
			return null;
		}
		
		public function runCommand(command:CMD):void {
			if(adlProcess){
				var input2:IDataOutput = adlProcess.standardInput;
				//input2.writeUTFBytes("compile 1" + "\n");
				input2.writeUTFBytes(command.getCode());
			}
			else
			{
				trace("■ not found acsh");
			}
		}
		
		
		private function shellExit(e:Event):void
		{
			trace(String(e));
		}
		
		private function onStandardError(e:ProgressEvent):void
		{
			//if (!ascsh) return;
			var output:IDataInput = adlProcess.standardError;
			var data:String = output.readUTFBytes(output.bytesAvailable);
			//trace("■" + data);
			
			//messagesModel
		/*	var mess:CompilerMessage = new CompilerMessage();
			mess.code = 2;
			mess.line = 0;
			mess.col = 0;
			mess.level = "Error";
			mess.path = "";
			mess.message = data;
			
			CodeEditorView.messagesModel.append(mess);*/
			decodeMessages(data);
		}
		
		private function decodeMessages(text:String):void
		{
			trace("text" + text);
			//statusOK = false;
			//var messages:Array = [];
			var messages:Vector.<CompilerMessage> = new Vector.<CompilerMessage>;
			for each (var line:String in text.replace(/\r?\n/g, '\r').split('\r'))
			{
				//if (line.indexOf('compile-ok') == 0) statusOK = true;
				var a:Array = line.split('|');
				if (a.length < 5) continue;
				var msg:CompilerMessage = new CompilerMessage;
				var i:int = 0;
				msg.code = a[i++];
				msg.line = a[i++];
				msg.col = a[i++];
				msg.level = a[i++];
				msg.path = a[i++];
				msg.message = a[i++];
				messages.push(msg);
			}
			//CompilerMessagesList.instance.messages = messages;
			//CompilerMessagesList.instance.revalidate();
		}
		
		private function onStandardOutput(e:ProgressEvent):void
		{
			//if (!ascsh) return;
			var output:IDataInput = adlProcess.standardOutput;
			var data:String = output.readUTFBytes(output.bytesAvailable);
			decodeMessages(data);
			trace("Ошибочка " + data);
		}
		
		public function run():void {
			
		}
		
		//public function writeCommand(command:Comm
		
	}

}