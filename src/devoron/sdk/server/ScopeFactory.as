package devoron.studio.runtime.server 
{
	import devoron.studio.compiler.RemoteScope;
	import devoron.utils.gtrace;
	import org.as3commons.asblocks.api.IClassType;
	import org.as3commons.asblocks.api.IField;
	import org.as3commons.asblocks.api.IMethod;
	import org.as3commons.asblocks.api.Visibility;
	import org.as3commons.asbook.api.IASBookAccess;
	/**
	 * ...
	 * @author Devoron
	 */
	public class ScopeFactory implements IScopeFactory
	{
		
		public function ScopeFactory() 
		{
			
		}
		
		/**
		 * Подготовить scope-объект, содержащий в себе все пары
		 * scope[имя_поля=ссылка на _this]
		 * scope[имя_поля=ссылка на _this]
		 * @param	classType
		 * @param	access
		 */
		public function prepareScope(classType:IClassType, access:IASBookAccess):RemoteScope
		{
			// ЗАПИСЬ ПОЛЕЙ(FIELD) В SCOPE, ЧТОБЫ ИХ МОЖНО БЫЛО ИСПОЛЬЗОВАТЬ
			//var remoteProxy:RemoteScope = new RemoteScope(_this, _this);
			var remoteProxy:RemoteScope = new RemoteScope(null, null);
			//gtrace(cc.bo.classes.length);
			//var protectedFields:Vector.<IField> = access.getFields(classType, Visibility.PROTECTED, false);
			var field:IField;
			
			//gtrace(/*"QN " + field.qualifiedName + */" public field " + field.name + ":" + field.type + " = " + field.initializer);
			var field:IField;
			var method:IMethod;
			
			//scopeProxy[field.name] = "__this(field.name)";
			
			// ВМЕСТО THIS ДОЛЖНА БЫТЬ ФУНКЦИЯ-ТРОЯН ПРЕДОСТАВЛЯЮЩАЯ ДОСТУП К ПОЛЯМ И МЕТОДАМ ЭТОГО КЛАССА И РОДИТЕЛЯ(В ТОМ ЧИСЛЕ PRIVATE И PROTECTED)
			// конвертация полей в команду или объект
			var allFields:Vector.<Vector.<IField>> = new Vector.<Vector.<IField>>();
			
			// области видимости, которые должны быть исследованы
			var visibilities:Vector.<Visibility> = new Vector.<Visibility>();
			visibilities.push(Visibility.PUBLIC);
			visibilities.push(Visibility.PRIVATE);
			visibilities.push(Visibility.PRIVATE);
			
			//allFields.push();
			allFields.push(access.getFields(classType, Visibility.PRIVATE, false));
			allFields.push(access.getFields(classType, Visibility.PROTECTED, false));
			
			// пройти циклом по всем массивам
			/*		for each (var item:Vector.<Visibility> in allFields)
			   {
			   access.getFields(classType, Visibility.PUBLIC, false)
			   }*/
			
			// 1. поля класса public, private, (protected, internal) var/const
			var publicFields:Vector.<IField> = access.getFields(classType, Visibility.PUBLIC, false);
			for each (field in publicFields)
				remoteProxy[field.name] = "__this(field.name)";
			
			var privateFields:Vector.<IField> = access.getFields(classType, Visibility.PRIVATE, false);
			for each (field in privateFields)
				remoteProxy[field.name] = "__this(field.name)";
			//gtrace("scopeProxy " + field.name);
			
			var protectedFields:Vector.<IField> = access.getFields(classType, Visibility.PROTECTED, false);
			for each (field in protectedFields)
				remoteProxy[field.name] = "__this(field.name)";
			
			// 1. методы класса public, private, protected, internal var/const
			var publicMethods:Vector.<IMethod> = access.getMethods(classType, Visibility.PUBLIC, false);
			for each (method in publicMethods)
				remoteProxy[method.name] = "__this(method.name)";
			
			var privateMethods:Vector.<IMethod> = access.getMethods(classType, Visibility.PRIVATE, false);
			for each (method in privateMethods)
				remoteProxy[method.name] = "__this(method.name)";
			
			var protectedMethods:Vector.<IMethod> = access.getMethods(classType, Visibility.PROTECTED, false);
			for each (method in protectedMethods)
				remoteProxy[method.name] = "__this(method.name)";
			
			//gtrace( /*"QN " + field.qualifiedName + */" public field " + field.name + ":" + field.type + " = " + field.initializer);
			var value:*;
			for (var prop:String in remoteProxy)
			{
				gtrace("scopeProxy " + prop);
					//value = source[prop];
			}
			return remoteProxy;
		}
		
	}

}