package devoron.file
{
	import devoron.file.FileInfo;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	/**
	 * FileInfo
	 * Flash analog for com.adobe.file.File
	 * @author Devoron
	 */
	public class FileInfo
	{
		public var name:String;
		public var extension:String;
		protected var _icons:Array;
		public var creationDate:Date;
		public var creator:String;
		public var isDirectory:Boolean;
		public var isHidden:Boolean;
		public var modificationDate:Date;
		public var nativePath:String;
		public var type:String;
		public var data:ByteArray;
		public var size:Number;
		public var exists:Boolean;
		public var directoryListing:Array;
		public var parentPath:String;
		
		// эта переменная заполняется при создании FileInfo
		//public static  var applicationDirectory:FileInfo = new FileInfo("C:\\Users\\Devoron\\Documents\\");
		public static  var applicationDirectory:FileInfo = new FileInfo("F:\\Projects\\projects\\flash\\studio\\Studio");
		public static const separator:String = "\\";
		
		public function FileInfo(nativePath:String ="")
		{
			this.nativePath = nativePath;
			modificationDate = new Date();
		}
		
		
		public function resolvePath(path:String=""):String{
			//return "F:\\Projects\\projects\\flash\\studio\\Studio\\bin\\"+path;
			return "F:\\Projects\\projects\\flash\\studio\\Studio\\"+path;
		}
		
		public function set icons(value:Array):void
		{
			_icons = value;
			
			// if icons is array of ByteArray convert each BA to BitmapData
			if (value is Array)
			{
				if (value[0] is ByteArray)
				{
					var item:*;
					var size:uint;
					var bd:BitmapData;
					for (var i:int = 0; i < value.length; i++)
					{
						item = value[i];
						if (item is ByteArray)
						{
							size = Math.sqrt((item as ByteArray).length) / 2;
							bd = new BitmapData(size, size, true);
							bd.setPixels(bd.rect, (item as ByteArray));
							_icons[i] = bd;
						}
						else
						{
							_icons[i] = item;
						}
					}
				}
			}
		}
		
		public function get icons():Array
		{
			return _icons;
		}
	
	}
}