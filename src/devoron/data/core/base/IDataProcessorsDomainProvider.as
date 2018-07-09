package devoron.data.core.base 
{
	
	/**
	 * IDataProcessorsDomainProvider
	 * @author Devoron
	 */
	public interface IDataProcessorsDomainProvider 
	{
		function setParentProcessorsDomainProvider(pp:IDataProcessorsDomainProvider):void;
		function getParentProcessorsDomainProvider():IDataProcessorsDomainProvider;
		function getProcessorDomain():IDataProcessorDomain;
	}
	
}