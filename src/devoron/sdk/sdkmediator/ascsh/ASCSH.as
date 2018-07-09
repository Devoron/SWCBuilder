package devoron.sdk.sdkmediator.ascsh
{
	//import devoron.aslc.libraries.LibrariesForm;
	import devoron.aslc.moduls.output.OutputForm;
	import devoron.sdk.data.CompilerMessage;
	import devoron.sdk.runtime.errors.ErrorValue;
	import devoron.sdk.sdkmediator.ascsh.commands.CMD;
	//import devoron.studio.core.managers.output.core.IOutputManagerProvider;
	//import devoron.studio.moduls.code.tools.resultslist.CompilerMessagesList;
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
	
	//import flash.desktop.NativeProcess;
	
	/**
	 * ASCSH
	 * @author Devoron
	 */
	public class ASCSH
	{
		private var shellProcess:NativeProcess;
		private var domain:ApplicationDomain;
		private var workingDirectoryPath:String;
		
		public function ASCSH()
		{
		
		}
		
		/**
		 * Запуск оболочки ASCSH.
		 */
		public function startShell(javaPath:String = null, args:Vector.<String> = null):void
		{
			// создаётся новый ApplicationDomain
			domain = new ApplicationDomain();
			
			shellProcess = new NativeProcess();
			shellProcess.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onStandardOutput);
			shellProcess.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onStandardError);
			shellProcess.addEventListener(NativeProcessExitEvent.EXIT, shellExit);
			
			var shellInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
			
			//F:\AIRSDK_Compiler\bin
			//shellInfo.executable = new File("C:\\Program Files (x86)\\Java\\jre1.8.0_121\\bin\\java.exe");
			//shellInfo.executable = new File("C:\\Program Files (x86)\\Java\\jre1.8.0_171\\bin\\java.exe");
			shellInfo.executable = new File("C:\\Program Files (x86)\\Java\\jre1.8.0_60\\bin\\java.exe");
			
			var arg:Vector.<String> = new Vector.<String>;
			
			if (args != null)
			{
				arg = args;
			}
			else
			{
				//taskset -c 1,2 java....... 
				
				arg.push("-Xmn1024M");
				
				arg.push("-jar");
				//arg.push("F:\\AIRSDK_Compiler\\lib\\mxmlc-cli.jar");
				arg.push("F:\\AIRSDK_Compiler\\lib\\ascsh.jar");
					//arg.push("F:\\flex_sdk_4.6\\lib\\fcsh.jar");
				
			}
			
			//arg.push("F:\\AIRSDK_Compiler\\lib\\compiler.jar");
			
			//var omg:Array = tf2.getText().split("\n");
			//for (var j:int = 0; j < omg.length; j++) 
			//{
			//arg.push(omg[i]);
			//}
			
			//arg.push("F:\\Projects\\projects\\flash\\studio\\Studio13\\src\\Some.as");
			//arg.push("-load-config ");
			//arg.push("F:\\Projects\\projects\\flash\\studio\\Studio13\\src\\config.xml");
			//arg.push("-o");
			//arg.push("F:\\Projects\\projects\\flash\\studio\\Studio13\\src\\Some.swf");
			//java.exe -jar lib/mxmlc.jar
			
			//shellInfo.executable = new File("F:\\AIRSDK_Compiler\\bin\\mxmlc.exe");
			//shellInfo.executable = new File("C:\\Program Files (x86)\\Java\\jre1.8.0_121\\bin\\java.exe -jar");
			
			//shellInfo.workingDirectory = new File(workingDirectoryTF.getText());
			//workingDirectoryPath = "F:\\AIRSDK_Compiler\\lib\\";
			//workingDirectoryPath = "F:\\";
			//workingDirectoryPath = "F:\\Projects\\projects\\flash\\studio\\Studio13";
			workingDirectoryPath = "F:\\";
			shellInfo.workingDirectory = new File(workingDirectoryPath);
			
			shellInfo.arguments = arg;
			
			shellProcess.start(shellInfo);
		
		/*	var input2:IDataOutput = ascsh.standardInput;
		 input2.writeUTFBytes(inputField.getText() + "\n");*/
		}
		
		public function stopShell():void
		{
			// временно
			// необходимо определиться с флагом force
			shellProcess.exit();
		}
		
		public function setWorkingDirectory(workingDirectoryPath:String):void
		{
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
				shellProcess = new NativeProcess();
				var processStartupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
				processStartupInfo.executable = new File(path);
				if (arguments)
					processStartupInfo.arguments = arguments;
				if (workingDirectoryPath)
					processStartupInfo.workingDirectory = new File(workingDirectoryPath);
				shellProcess.start(processStartupInfo);
				return shellProcess;
			}
			catch (e:Error)
			{
				trace(e.message);
				return new ErrorInfo(e.message);
			}
			
			return null;
		}
		
		public function runCommand(command:CMD):void
		{
			if (shellProcess)
			{
				var input2:IDataOutput = shellProcess.standardInput;
				//input2.writeUTFBytes("compile 1" + "\n");
				input2.writeUTFBytes(command.getCode());
				//input2.writeUTFBytes("help"+);
				//trace("запуск команды " + command.getCode());
				
				OutputForm.log("ASCSH command " + command.getCode());
			}
			else
			{
				//trace("■ not found acsh");
				
				OutputForm.log("ASCSH ERROR shellProcess not exists" );
			}
		}
		
		private function shellExit(e:Event):void
		{
			trace(String(e));
		}
		
		private function onStandardError(e:ProgressEvent):void
		{
			//if (!ascsh) return;
			var output:IDataInput = shellProcess.standardError;
			//var data:String = output.readUTFBytes(output.bytesAvailable);
			
			var data:String = output.readMultiByte(output.bytesAvailable, "ansi");
			//trace("~: ошибка " + data);
			
			OutputForm.log("ASCSH error: " + data);
			
			
			// костыль!!
			//parseError(data);
			var messages:Vector.<CompilerMessage> = decodeMessages(data);
			
			if (data.lastIndexOf("Compile status: 2") != -1)
			{
				//LibrariesForm.m2.graphics.clear();
				//LibrariesForm.m2.graphics.beginFill(0X75EA00, 0.5);
				//LibrariesForm.m2.graphics.beginFill(0XFF0000 * Math.random(), 0.5);
				//m2.graphics.drawRect(0, 4, 8, 3);
				//LibrariesForm.m2.graphics.drawCircle(0, 0, 2);
				//LibrariesForm.m2.graphics.endFill();
			}
			
			if (data.lastIndexOf("Compile status: 0") != -1)
			{
				//LibrariesForm.m2.graphics.clear();
				//LibrariesForm.m2.graphics.beginFill(0X75EA00, 0.5);
				//m2.graphics.drawRect(0, 4, 8, 3);
				//LibrariesForm.m2.graphics.drawCircle(0, 0, 2);
				//LibrariesForm.m2.graphics.endFill();
			}
			// нужно создать выводящий поток и вывести их куда-то
			//CompilerMessagesList.instance.messages = messages;
		}
		
		//public function setMessagesResiver(ouputManagerProvider:IOutputManagerProvider, messagesType:Class):void
		//{
		
		//}
		
		private function decodeMessages(text:String):Vector.<CompilerMessage>
		{
			//statusOK = false;
			//var messages:Array = [];
			var messages:Vector.<CompilerMessage> = new Vector.<CompilerMessage>;
			for each (var line:String in text.replace(/\r?\n/g, '\r').split('\r'))
			{
				//if (line.indexOf('compile-ok') == 0) statusOK = true;
				var a:Array = line.split('|');
				if (a.length < 5)
					continue;
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
			
			return messages;
		}
		
		private function parseError(data:String):void
		{
			var arr:Array = data.split("Ошибка");
			var path:String = data.split("(")[0];
			var line:String = data.substr(path.length + 1).split(")")[0];
			var position:String = (data.substr(path.length + line.length + 3).split(" "))[2];
			//var message:String = (data.substr(path.length + line.length + 3)
			//var position:String = position[0]
			var p1:int = data.indexOf("Предупреждение");
			var p2:int = data.indexOf("Ошибка");
			var last:String = (data.substr(p1 > p2 ? p1 : p2));
			var description:String = last.split("\n")[0];
			var citat:String = last.split("\n")[2];
			
			var errorValue:ErrorValue = new ErrorValue();
			errorValue.path = path;
			errorValue.line = line;
			errorValue.position = position;
			errorValue.description = description;
			errorValue.citat = citat;
			
			trace("добавление ошибки " + errorValue);
		
			//CodeEditorView.stackTraceModel.append(errorValue);
			//CodeEditorView.stackTraceList.revalidate();
		
		/*var compilerMessage:CompilerMessage = new CompilerMessage();
		   compilerMessage.code = 2;
		   compilerMessage.col = position;
		   compilerMessage.level = position;
		   compilerMessage.col = position;
		 compilerMessage.col = position;*/
		
		/*trace("путь " + path);
		   trace("линия " + line);
		   trace("позиция " + position);
		   trace("описание " + description);
		 trace("цитата " + citat);*/
			 //trace(data);
		
			// костыль!!!
			//if(p2>-1)
			//StudioRuntimeGUI.errorsModel.append(errorValue);
			//if(p2>-1)
		
			//trace("HUI " + description);
		}
		
		private function onStandardOutput(e:ProgressEvent):void
		{
			//if (!ascsh) return;
			var output:IDataInput = shellProcess.standardOutput;
			//var data:String = output.readUTFBytes(output.bytesAvailable);
			//var data:String = output.readMultiByte(output.bytesAvailable, "utf-8");
			var data:String = output.readMultiByte(output.bytesAvailable, "ansi");
			//gtrace(data);
			//trace(data);
			
			OutputForm.log("ASCSH out: " + data);
			
			if (data.lastIndexOf("Compile status: 0") != -1)
			{
			/*	LibrariesForm.m2.graphics.clear();
				LibrariesForm.m2.graphics.beginFill(0X75EA00, 0.5);
				LibrariesForm.m2.graphics.drawCircle(0, 0, 2);
				LibrariesForm.m2.graphics.endFill();*/
			}
			
			if (data.lastIndexOf("bytes written ") != -1)
			{
				var words:Array = data.split(" ");
				//history size 2023412 points ~ 0.03 mb
				
				//LibrariesForm.sizeLB.setText(words[0] + " " + words[words.length - 2] + " " + words[words.length - 1]);
				//LibrariesForm.sizeLB.revalidate();
			}
		
		/*if (data.lastIndexOf("Compile status: 0") != -1) {
		   LibrariesForm.m2.graphics.clear();
		   //LibrariesForm.m2.graphics.beginFill(0X75EA00, 0.5);
		   LibrariesForm.m2.graphics.beginFill(0X75EA00*Math.random(), 1);
		   //m2.graphics.drawRect(0, 4, 8, 3);
		   LibrariesForm.m2.graphics.drawCircle(0, 0, 2);
		   LibrariesForm.m2.graphics.endFill();
		 }*/
			 //decodeMessages(data);
		
		}
		
		public function run():void
		{
		
		}
	
		//public function writeCommand(command:Comm
	
	}

}