package devoron.file
{
	import devoron.data.flashcompresser.FlashCompresser;
	import devoron.data.flashcompresser.FlashCompresserEvent;
	import devoron.utils.searchandreplace.workers.SearchAndReplaceWorker.src.devoron.file.FileInfo;
	import devoron.utils.searchandreplace.workers.SearchAndReplaceWorker.src.devoron.file.FileInfoUtils;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author ...
	 */
	public class FileInfoUtils
	{
		private static var fc:FlashCompresser = new FlashCompresser(true);
		
		public static function convertToCompressedFileInfo2(directory:FileInfo):void
		{
			var datas:Array = FileInfoUtils.getDirectoryListingByteArrays2(directory);
			if (datas.length == 0)
				return;
			
			if (!fc.hasEventListener(FlashCompresserEvent.COMPRESS_COMPLETE))
				fc.addEventListener(FlashCompresserEvent.COMPRESS_COMPLETE, compressHandler);
			//var fc:FlashCompresser = new FlashCompresser(true);
			fc.userData = {pointer: 0, directory: directory};
			
			//gtrace("изначальный размер0 " + datas[0].length);
			fc.compressByteArrays.apply(null, datas);
		}
		
		private static function compressHandler(e:FlashCompresserEvent):void
		{
			//var tf:TextField = new TextField();
			//World.stage.addChild(tf);
			//tf.y = Math.random() * 300;
			//tf.text = "ПОтрачено";
			gtrace("ПОТРАЧЕНО!");
		/*var directory:FileInfo = (e.currentTarget as FlashCompresser).userData.directory;
		   var pointer:uint = (e.currentTarget as FlashCompresser).userData.pointer;
		   gtrace(directory.directoryListing[pointer].nativePath + " " + directory.directoryListing[pointer].size + " " + e.algoritm + " " + e.data.length);
		 (e.currentTarget as FlashCompresser).userData.pointer++;*/
		
			//for each (var file:FileInfo in directory.directoryListing) 
			//{
			//
			//}
		
			//gtrace("Имя компрессора " + (e.currentTarget as FlashCompresser).name);
			//gtrace("Имя файла " + e.filename);
		
			//(e.currentTarget as FlashCompresser).addEventListener(FlashCompresserEvent.COMPRESS_COMPLETE, compressCompleteHandler, false, 0, true);
		}
		
		[Inline]
		
		public static function getDirectoryListingPaths(directory:FileInfo):Vector.<String>
		{
			if (!directory.isDirectory)
				return null;
			var files:Array = directory.directoryListing;
			var paths:Vector.<String> = new Vector.<String>();
			for each (var fi:FileInfo in files)
				paths.push(fi.nativePath);
			return paths;
		}
		
		[Inline]
		
		public static function getDirectoryListingByteArrays(directory:FileInfo):Vector.<ByteArray>
		{
			if (!directory.isDirectory)
				return null;
			var files:Array = directory.directoryListing;
			var byteArrays:Vector.<ByteArray> = new Vector.<ByteArray>();
			for each (var fi:FileInfo in files)
				byteArrays.push(fi.data);
			return byteArrays;
		}
		
		[Inline]
		
		public static function getDirectoryListingByteArrays2(directory:FileInfo):Array
		{
			if (!directory.isDirectory)
				return null;
			var files:Array = directory.directoryListing;
			var byteArrays:Array = [];
			
			//gtrace("данные " +  directory.directoryListing[0].data.length);
			
			for each (var fi:FileInfo in files)
			{
				if (!fi.data)
					throw new Error("File " + fi.nativePath + " has no data");
				
				byteArrays.push(fi.data);
			}
			return byteArrays;
		}
	
	}

}