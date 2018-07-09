package devoron.data.core.base 
{
	
	/**
	 * IDataContainersManager
	 * Служит интерфейсом для DataStructur.
	 * Способен добавлять в себя контейнеры данных.
	 * @author Devoron
	 */
	public interface IDataContainersManager 
	{
		function addDataContainer(dataContainer:IDataContainer):void;
		function removeDataContainer(dataContainer:IDataContainer):void;
		function removeDataByContainerName(dataContainerName:String):void 
		function getDataContainersNames():Array;
		function getDataByContainerName(dataContainerName:String):Object;
		function getDataContainer(dataContainerName:String):IDataContainer;
		function setDataByName(data:Object, dataName:String):void
		function clone():IDataContainersManager;
	}
	
}