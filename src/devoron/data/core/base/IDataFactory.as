package devoron.data.core.base 
{
	
	/**
	 * IDataFactory
	 * @author Devoron
	 */
	public interface IDataFactory 
	{
		function registerDataStructurObject(dataName:String, dso:DataStructurObject):void;
		function unregisterDataStructurObject(dataName:String):void;
		function getData(dataName:String):DataStructurObject;
		function isDataSupported(dataName:String):Boolean;
	}
	
}