package devoron.data.core.base 
{
	
	/**
	 * IDataStructurContainer
	 * @author Devoron
	 */
	public interface IDataStructurContainer extends IDataModul
	{
		function setDataStructur(dataStructur:IDataContainersManager):void;
		function getDataStructur():IDataContainersManager;
	}
	
}