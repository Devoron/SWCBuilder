package devoron.data.core.base 
{
	
	/**
	 * IDataProcessesProvider
	 * @author Devoron
	 */
	public interface IDataProcessesProvider 
	{
		function setParentProcessesProvider(pp:IDataProcessesProvider):void;
		function getParentProcessesProvider():IDataProcessesProvider;
	}
	
}