package devoron.sdk.runtime.errors 
{
	/**
	 * ErrorValue
	 * @author Devoron
	 */
	public class ErrorValue 
	{
		public var path:String;
		public var line:String;
		public var position:String;
		public var description:String;
		public var citat:String;
		
		public function ErrorValue() 
		{
			
		}
		
		public function toString():String {
			return path + "(" + line+")" + ":Column: " + position + " Error: " + citat;
		}
		
	}

}