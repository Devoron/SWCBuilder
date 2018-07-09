package devoron.data.core.base
{
	import devoron.components.tables.INewValueGenerator;
	
	/**
	 * DefaultDataStructurGenerator
	 * @author Devoron
	 */
	public class DefaultDataStructurGenerator implements INewValueGenerator
	{
		private var dataStructurClass:Class;
		
		public function DefaultDataStructurGenerator(dataStructurClass:Class)
		{
		this.dataStructurClass = dataStructurClass;
		
		}
		
		/* INTERFACE devoron.components.tables.INewValueGenerator */
		
		public function generateNewValue():*
		{
			return new dataStructurClass();
		}
	
	}

}