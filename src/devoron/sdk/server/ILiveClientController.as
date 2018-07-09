package devoron.sdk.server 
{
	import devoron.sdk.compiler.RemoteScope;
	import org.as3commons.asblocks.api.IClassType;
	import org.as3commons.asbook.api.IASBookAccess;
	
	/**
	 * Контроллер клиента представляет из себя того, кто должен заполнить
	 * Scope-объект записями о всех требуемых переменных, методах, библиотеках для каждого компилируемого класса
	 * 
	 * @author Devoron
	 */
	public interface ILiveClientController 
	{
		function prepareScope(classType:IClassType, access:IASBookAccess):RemoteScope
	}
	
}