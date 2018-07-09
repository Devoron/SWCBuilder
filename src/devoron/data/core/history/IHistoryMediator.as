package devoron.data.core.history 
{
	
	/**
	 * IHistoryMediator
	 * @author Devoron
	 */
	public interface IHistoryMediator 
	{
		function setHistory(history:IHistory):void;
		function getHistory(target:*):IHistory;
	}
	
}