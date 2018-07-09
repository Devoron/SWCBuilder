package devoron.data.core.base 
{
	import flash.utils.flash_proxy;
	/**
	 * IdDataStructurObject
	 * @author Devoron
	 */
	use namespace flash_proxy;
	 
	dynamic public class IdDataStructurObject extends DataStructurObject
	{
		public var id:uint;
		
		public function IdDataStructurObject() 
		{
			id = uint(Math.random() * 10000000000);
		}
		
		override public function clone():DataStructurObject 
		{
			var newDSO:IdDataStructurObject = super.clone() as IdDataStructurObject; 
			newDSO.id = uint(Math.random() * 10000000000);
			return newDSO;
		}
		
	}

}