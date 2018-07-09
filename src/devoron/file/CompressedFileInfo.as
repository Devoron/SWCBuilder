package devoron.file 
{
	import devoron.file.FileInfo;
	import flash.utils.ByteArray;
	/**
	 * CompressedFileInfo
	 * @author Devoron
	 */
	public class CompressedFileInfo extends FileInfo 
	{
		
		public var algoritm:String;
		public var compressedData:ByteArray;
		public var compressedSize:uint;
		
		public function CompressedFileInfo() 
		{
			super();
			
		}
		
	}

}