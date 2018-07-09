package devoron.sdk.aslc.core.utils
{
	import org.as3commons.asblocks.api.IFunction;
	import org.as3commons.asblocks.api.IMethod;
	import org.as3commons.asblocks.api.IParameter;
	import org.as3commons.asblocks.impl.MethodNode;
	import org.as3commons.asblocks.utils.ASTUtilities;
	import devoron.utils.airmediator.AirMediator;
	import devoron.file.FileInfo;
	import org.as3commons.asblocks.api.IMember;
	import org.as3commons.asblocks.api.IStatement;
	import org.as3commons.asblocks.api.IStatementContainer;
	import org.aswing.event.AWEvent;
	import org.aswing.VectorListModel;
	
	/**
	 * ASLCClassGenerator
	 * @author Devoron
	 */
	public class ASLCClassGenerator
	{
		
		public function ASLCClassGenerator()
		{
		
		}
		
		public function createMainLive(allClasses:Array):void
		{
			var code:String = "";
			code += "package\n";
			code += "{\n"
			
			// здесь должен быть импорт всех live-классов
			
			code += "import flash.display.Sprite;\n";
			//code += "set namespace flash_proxy;\n";
			code += "public class LiveMain extends Sprite\n";
			code += "{\n";
			
			// поля
			// конструктор
			code += "public function LiveMain(targetClass:*=null)\n";
			code += "{\n";
			//code += "super(targetClass);\n";
			//code += "this.targetClass = targetClass;";
			
			
			for each (var item:FileInfo in allClasses)
			{
				//var n:String = 
				code += item.name.split(".")[0] + ";\n";
			}
			
			code += "}\n";
			
			/*	code += "private static function get img1995():*{\n";
			   code += "return 'null'\n";
			   code += "}\n";
			
			   code += "private function exe_2():*{\n";
			   code += "return 'null'\n";
			 code += "}\n";*/
			
			// в тело этой функции должен быть записан код функции, которая была скомпилирована как live
			// скорее всего импорты тоже придётся втыкать в класс
			/*	code += "public function exe(targetLivecodeClass:Proxy):* {\n";
			   code += "this.targetLivecodeClass = targetLivecodeClass;\n";
			   //code += "with(super){\n";
			   code += methodBody + "\n";
			   //code += "}\n";
			
			 code += "}\n";*/
			
			//code += "override flash_proxy function getProperty(name:*):*\n";
			//code += "{\n";
			//code += "trace('поиск внутри' + name);\n";
			//code += "return values.get(name);\n";
			//code += "}\n";
			
			code += "}\n";
			code += "}\n";
			
			//AirMedit
			//var str:String = codeTA.getText();
			AirMediator.writeToFile("F:/Projects/projects/flash/studio/Studio13/src/LiveMain.as", code);
		}
		
		/**
		 * Создать инъекционный класс, который принесёт метод в систему на стороне рантайм.
		 *
		 * тела методов необходимо получить из тех, которые были выбраны в качестве лив-методов
		 *
		 * @param	methodBody
		 */
		//public function createInjectionClass(methodBody:String):String
		public function createInjectionClass(member:IMember):String
		{
			if (!member)
			throw new Error("member must not be null");
			
			//var mnd:MethodNode = member as MethodNode;
			//for each (var item: in ) 
			//{
				
			//}
			
			var methodBody:String/* = member.node.stringValue()*/;
			var code:String = "";
			code += "package RUNTIME_MXMLC_TEST\n";
			code += "{\n"
			code += "import flash.utils.Proxy;\n";
			code += "import flash.utils.flash_proxy;\n";
			code += "use namespace flash_proxy;\n";
			//code += "set namespace flash_proxy;\n";
			code += "dynamic public class InjectionClass1 extends RemoteClassScope\n";
			code += "{\n";
			
			// поля
			code += "private var simplevar:uint = 2000;\n";
			code += "protected var simplevar2:uint;\n";
			code += "public static var simplevar1995:uint;\n";
			code += "public var simplevar3:uint;\n";
			
			// конструктор
			code += "public function InjectionClass1(targetClass:*=null)\n";
			code += "{\n";
			//code += "super(targetClass);\n";
			//code += "this.targetClass = targetClass;";
			code += "}\n";
			
			code += "private static function get img1995():*{\n";
			code += "return 'null'\n";
			code += "}\n";
			
			code += "private function exe_2():*{\n";
			code += "return 'null'\n";
			code += "}\n";
			
			// в тело этой функции должен быть записан код функции, которая была скомпилирована как live
			// скорее всего импорты тоже придётся втыкать в класс
			code += "public function exe(...args):* {\n";
			//code += "this.targetLivecodeClass = targetLivecodeClass;\n";
			//code += "with(super){\n";
			//code += methodBody + "\n";
			
			// в скомпилированном виде это будет выглядеть так, будто переменная объявлена внутри функции
			var params:Vector.<IParameter> = (member as IFunction).parameters;
			for (var i:int = 0; i < params.length; i++) 
			{
				var param:IParameter = params[i];
				
				//code += "var " + param.name + " = args." + param.name+";\n";
				code += "var " + param.name + " = args[" + i+"];\n";
				
			}
			
			
			
			code += generateInjectionClass(member);
			
			//code += "}\n";
			
			code += "}\n";
			
			//code += "override flash_proxy function getProperty(name:*):*\n";
			//code += "{\n";
			//code += "trace('поиск внутри' + name);\n";
			//code += "return values.get(name);\n";
			//code += "}\n";
			
			code += "}\n";
			code += "}\n";
			
			
			trace(code);
			//AirMedit
			//var str:String = codeTA.getText();
			//AirMediator.writeToFile("F:/Projects/projects/flash/studio/Studio13/src/RUNTIME_MXMLC_TEST/InjectionClass1.as", code);
			return code;
		}
		
		public function generateInjectionClass(member:IMember):String 
		{
			var statements:Vector.<IStatement> = (member as IStatementContainer).statements;
			var statements2:String = ASTUtilities.initText(member.node);
			//trace(statements2);
			var allStatements:Array = [];
			for each (var statementNode:IStatement in statements)
			{
				//allStatements.push(ASTUtilities.printNode(statementNode.node));
				allStatements.push(ASTUtilities.initText(statementNode.node));
				//trace("stat " + String(statementNode));
			}
			
			return allStatements.join("\n");
		}
	
	}

}