package devoron.sdk.aslc.core.utils.compare
{
	import org.as3commons.asblocks.utils.ASTUtilities;
	//import org.as3commons.asblocks.ASTUtilities;
	//import org.as3commons.asblocks.utils.ASTUtilities;
	import devoron.sdk.aslc.core.utils.compare.FieldNodeCompareResult;
	import flash.utils.ByteArray;
	import org.as3commons.asblocks.api.IMethod;
	import org.as3commons.asblocks.api.IParameter;
	import org.as3commons.asblocks.api.IStatement;
	import org.as3commons.asblocks.api.IStatementContainer;
	import org.as3commons.asblocks.impl.DeclarationStatementNode;
	import org.as3commons.asblocks.impl.FieldNode;
	import org.as3commons.asblocks.impl.MethodNode;
	import org.as3commons.bytecode.abc.MethodInfo;
	import org.aswing.util.HashMap;
	
	/**
	 * ScriptNodeComparator
	 * @author Devoron
	 */
	public class ScriptNodeComparator
	{
		private var methodsHash:HashMap;
		private var iStatementContainer;
		private var methodQName:String;
		private var methodsParametersHash:HashMap;
		private var methodsStatememtsHash:HashMap;
		
		public function ScriptNodeComparator()
		{
		
		}
		
		public function compareFields(newMethod:FieldNode, oldMethod:FieldNode):FieldNodeCompareResult
		{
			return null;
		}
		
		
		private function compareStatementContainers(statementsA:Vector.<IStatement>, statementsB:Vector.<IStatement>):Boolean {
			return true;
			var allStatements = new Vector.<String>();
			
			iStatementContainer.statements.length = 0;
			//var stat:IStatement = iStatementContainer.addStatement("var MEssAGE:String");
			
			var statements:Vector.<IStatement> = iStatementContainer.statements;
			
			// именно здесь должны быть изъяты выражения в теле функции заменены на новые
			
			var statementsContainer:Vector.<IStatement> = new Vector.<IStatement>();
			//this.statementsHash.put(methodNode.qualifiedName, statementsContainer);
			
			// итак, я получил содержимое функции
			
			allStatements = this.methodsStatememtsHash.get(methodQName);
			var methodBody:String;
			var oldMethodBody:String = methodsHash.get(methodQName);
			
			// если выражения уже есть, то произвести сравнение содержимого функции
			if (oldMethodBody != null /* && oldMethodBody!=""*/)
			{
				// произвести сравнение тел прежнего и нового метода
				allStatements = new Vector.<String>();
				methodsStatememtsHash.put(methodQName, allStatements);
				// массив байтов - я действительно могу перегнать allStatements в байты и отдать их через событие
				for each (var statementNode:IStatement in statements)
				{
					allStatements.push(ASTUtilities.initText(statementNode.node));
					statementsContainer.push(statementNode);
					throw new Error("process statement");
					//processStatement(statementNode);
				}
				methodBody = allStatements.join("\n");
				
				// все выражения метода заменить на реферс к методу из лив-хранилища
				
				// если тело было метода было изменено
				if (methodBody != oldMethodBody)
				{
					methodsHash.put(methodQName, methodBody);
					var ba:ByteArray = new ByteArray();
					ba.writeMultiByte(methodBody, "utf-8");
						//LiveServerDomain
					
						//generateScriptForMethod
						//GlobalEventDispatcher.instance.dispatchEvent(new CodeEvent(CodeEvent.CHANGE_METHOD, "", methodQName, ba));
				}
				
			}
			// если нет, то создать новые
			else
			{
				statements = iStatementContainer.statements;
				
				allStatements = new Vector.<String>();
				methodsStatememtsHash.put(methodQName, allStatements);
				// массив байтов - я действительно могу перегнать allStatements в байты и отдать их через событие
				var numb:int = 0;
				for each (var statementNode:IStatement in statements)
				{
					if (statementNode is DeclarationStatementNode)
					{
						trace("numb " + numb);
					}
					
					//allStatements.push(ASTUtilities.initText(statementNode.node));
					statementsContainer.push(statementNode);
					//processStatement(statementNode);
					throw new Error("process statement");
					
					numb++;
				}
				methodBody = allStatements.join("\n");
				methodsHash.put(methodQName, methodBody);
				var ba2:ByteArray = new ByteArray();
				ba2.writeMultiByte(methodBody, "utf-8");
				ba2.position = 0;
				//trace("ДОСТУПНО БАЙТ " + ba2.length);
				
				//trace("вывод тела " + methodBody);
				
				//processedMethodHash.put(methodQName, 
				
				//GlobalEventDispatcher.instance.dispatchEvent(new CodeEvent(CodeEvent.ADD_METHOD, "", methodQName, methodNode.visibility.toString(), ba2));
					//GlobalEventDispatcher.instance.dispatchEvent(new CodeEvent(CodeEvent.ADD_METHOD, "", methodQName, ba2));
			}
			
			//result.methodInfo = new MethodInfo();
			//methodInfo.
			
			//fillParameters(newMethod.parameters);
			
			// если поля идентичны, то ничего предпринимат не нужно
			/*if (constEquals && typesEquals && staticEquals && initializerEquals && visibilityEquals)
			   {
			   gtrace("5:Поля идентичны " + filedName);
			   }
			   else
			   {
			   gtrace("5:Поле изменилось " + filedName);
			   //istory
			
			   // установить новое поле
			   fieldsHash.put(filedQName, fieldNode);
			
			   History.registerFieldPoint(fieldNode, constEquals, typesEquals, staticEquals, visibilityEquals, oldInitializer, initializerEquals);
			   // скомпилировать поле и всё такое
			
			 }*/
			
			//var old
			
			// должно быть произведено сравнение прежних и новых параметров
			
			//var paramsProxy:ScopeProxy = new ScopeProxy(null, null);
			//LiveControllerCodeStrategy.localScopeCollector.put(methodQName, paramsProxy);
			
			/*var oldParams:Object = methodsParametersHash.get(methodQName);
			   if (!oldParams)
			   {
			   methodsParametersHash.put(methodQName, json.params);
			   }
			   else
			   {
			   //ObjectUtils.compare(oldParams)
			   }
			
			   if (allParams != "" && oldParams != allParams)
			   {
			
			   var string:String = JSON.stringify(json);
			   var ba4:ByteArray = new ByteArray();
			   ba4.writeMultiByte(string, "utf-8");
			   GlobalEventDispatcher.instance.dispatchEvent(new CodeEvent(CodeEvent.CHANGE_METHOD_ARGUMENTS, "", methodQName, ba4));
			   methodsParametersHash.put(methodQName, allParams);
			 }*/
		return true;	
		}
		
		/**
		 * Сравнение методов
		 * @param	newMethod
		 * @param	oldMethod
		 * @return
		 */
		public function compareMethods(methodNode:MethodNode, oldMethod:MethodNode):MethodNodeCompareResult
		{
			var result:MethodNodeCompareResult = new MethodNodeCompareResult();
			
			// compare return types
			result.returnTypesEquals = methodNode.qualifiedReturnType == oldMethod.qualifiedReturnType; // возврвщаемый тим
			// compare static flags
			result.staticEquals = methodNode.isStatic == oldMethod.isStatic; // статический метод
			// compare visibilies
			result.visibilityEquals = methodNode.visibility.toString() == oldMethod.visibility.toString(); // видимость метода
			//result.paramsEquals = compareParams(newMethod.parameters, oldMethod.parameters);
			result.paramsEquals = true; // заглушка на параметры
			// compare statements
			result.statementsEquals = ASTUtilities.initText(methodNode.node) == ASTUtilities.initText(oldMethod.node); // сравнение текста функции
			
			result.statementsEquals = compareStatementContainers(methodNode.statements, oldMethod.statements);
			
			
			var iFunction:IMethod = methodNode as IMethod;
			var iStatementContainer:IStatementContainer = methodNode as IStatementContainer;
			
			return result;
		}
	
				/**
		 * Сравнение методов
		 * @param	newMethod
		 * @param	oldMethod
		 * @return
		 */
		protected function compareMethods(newMethod:MethodNode, oldMethod:MethodNode):Boolean
		{
			//var comparator:ScriptNodeComparator = new ScriptNodeComparator();
			//var compareResult:MethodNodeCompareResult = comparator.compareMethods(newMethod, oldMethod);
			
			/*if (compareResult.result)
			{
				return true;
			}
			else
			{
				if (codeHistoryAPI)
					codeHistoryAPI.registerMethodPoint2(newMethod, oldMethod, compareResult);
					//codeHistoryAPI.registerMethodPoint(newMethod, oldMethod, returnTypesEquals, staticEquals, visibilityEquals, paramsEquals, statementsEquals);
			}
			return false;*/
			
			var allParams:String = "";
			
			var json:Object = new Object();
			json.params = [];
			
			// если длина массивов одинаковая, то перебрать их параллельно
			// если длина разная, то изменения в параметрах метода однозначно есть
			var paramId:uint = 0;
			
			var additionalCode:String = "";
			
			for each (var param:IParameter in newMethod.parameters)
			{
				gtrace("********** PARAMETER ***********");
				//gtrace(ASTUtilities.initText(param.node));
				var stringParam:String = ASTUtilities.initText(param.node);
				allParams += "\n" + stringParam;
				
				var paramObj:Object = new Object();
				paramObj.name = param.name;
				paramObj.type = param.type;
				paramObj.qualifiedType = param.qualifiedType;
				paramObj.defaultValue = param.defaultValue;
				paramObj.hasDefaultValue = param.hasDefaultValue;
				json.params.push(paramObj);
				
				// добавочный код в самом начале функции представлет собой доступ к аргументам, переданным в функцию
				additionalCode += "var " + param.name + ":" + param.type + " = arguments[" + paramId + "]";
				paramId++;
			}
			
			// для каждого параметра должен быть добавлен код в самом начале
			
			var methodQName:String = newMethod.qualifiedName;
			var oldParams:Object = methodsParametersHash.get(methodQName);
			if (!oldParams)
			{
				this.methodsParametersHash.put(methodQName, json.params);
			}
			else
			{
				//ObjectUtils.compare(oldParams)
			}
			
			// если поля идентичны, то ничего предпринимат не нужно
			/*if (constEquals && typesEquals && staticEquals && initializerEquals && visibilityEquals)
			   {
			   gtrace("5:Поля идентичны " + filedName);
			   }
			   else
			   {
			   gtrace("5:Поле изменилось " + filedName);
			   //istory
			
			   // установить новое поле
			   fieldsHash.put(filedQName, fieldNode);
			
			   History.registerFieldPoint(fieldNode, constEquals, typesEquals, staticEquals, visibilityEquals, oldInitializer, initializerEquals);
			   // скомпилировать поле и всё такое
			
			 }*/
			
			//var old
			
			// должно быть произведено сравнение прежних и новых параметров
			
			//var paramsProxy:ScopeProxy = new ScopeProxy(null, null);
			//LiveControllerCodeStrategy.localScopeCollector.put(methodQName, paramsProxy);
			
			/*var oldParams:Object = methodsParametersHash.get(methodQName);
			   if (!oldParams)
			   {
			   methodsParametersHash.put(methodQName, json.params);
			   }
			   else
			   {
			   //ObjectUtils.compare(oldParams)
			   }
			
			   if (allParams != "" && oldParams != allParams)
			   {
			
			   var string:String = JSON.stringify(json);
			   var ba4:ByteArray = new ByteArray();
			   ba4.writeMultiByte(string, "utf-8");
			   GlobalEventDispatcher.instance.dispatchEvent(new CodeEvent(CodeEvent.CHANGE_METHOD_ARGUMENTS, "", methodQName, ba4));
			   methodsParametersHash.put(methodQName, allParams);
			 }*/
			return false;
		}
		
		private function compareParams(newParams:Vector.<IParameter>, oldParams:Vector.<IParameter>):void
		{
			if (newParams.length != oldParams.length)
			{
				// если параметры не равны, то новые параметры должны быть зарегистрированы в LocalScope
				// хотя следует уточнить, какие именно параметры были изменены/добавлены/удалены
				for each (var oldParam:IParameter in oldParams)
				{
					var oldParamName:String = oldParam.name;
					for each (var newParam:IParameter in newParams)
					{
						//MethodInfo
						/*oldParamName != newParam.name
						   oldParamName != newParam.hasType
						   oldParamName != newParam.defaultValue
						 oldParamName != newParam.isRest*/
					}
				}
				
			}
			// если длина одинакова, то сравнение по списку
			else
			{
				
			}
			// мы должны точно знать, какой параметр изменился
		}
	
	/*public function equals(other:Object):Boolean {
	   var otherMethod:MethodInfo = other as MethodInfo;
	   if (otherMethod != null) {
	   if (flags != otherMethod.flags) {
	   return false;
	   }
	   if (methodName != otherMethod.methodName) {
	   return false;
	   }
	   if (!returnType.equals(otherMethod.returnType)) {
	   return false;
	   }
	   if (scopeName != otherMethod.scopeName) {
	   return false;
	   }
	   if (argumentCollection.length != otherMethod.argumentCollection.length) {
	   return false;
	   }
	   var len:int = argumentCollection.length;
	   var i:int;
	   var arg:Argument;
	   var otherArg:Argument;
	   for (i = 0; i < len; ++i) {
	   arg = argumentCollection[i];
	   otherArg = otherMethod.argumentCollection[i];
	   if (!arg.equals(otherArg)) {
	   return false;
	   }
	   }
	   return true;
	   }
	   return false;
	 }*/
		
		
	}

}