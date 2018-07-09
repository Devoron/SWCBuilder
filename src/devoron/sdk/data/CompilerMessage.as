package devoron.sdk.data
{
	/**
	 * Сообщение от компилятора.
	 */
	public class CompilerMessage
	{
		static public var pathPrefix:String = '';
		
		public var code:int;
		public var line:int;
		public var col:int;
		public var level:String;
		public var path:String;
		public var message:String;
		
		public function toString():String
		{
			path = path.replace(/\\/g, '/');
			var p:String = path.indexOf(pathPrefix) == 0 ? path.substr(pathPrefix.length) : path;
			
			
			return '[' + level + ']' + code + ': ' + message + ' (' + p + ':' + line + ')';
		}
	}
}