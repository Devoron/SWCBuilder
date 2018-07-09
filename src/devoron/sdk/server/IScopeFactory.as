package devoron.studio.runtime.server 
{
	import devoron.studio.compiler.RemoteScope;
	import org.as3commons.asblocks.api.IClassType;
	import org.as3commons.asbook.api.IASBookAccess;
	
	/**
	 * ...
	 * @author Devoron
	 */
	public interface IScopeFactory 
	{
		function prepareScope(classType:IClassType, access:IASBookAccess):RemoteScope;
	}
	
}