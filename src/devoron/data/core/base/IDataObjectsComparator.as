package devoron.data.core.base 
{
	/**
	 * ...
	 * @author Devoron
	 */
	public interface IDataObjectsComparator 
	{
		
			function compare(DataObjectA:DataObject, DataObjectB:DataObject, mode:String):Boolean;
		
	}

}