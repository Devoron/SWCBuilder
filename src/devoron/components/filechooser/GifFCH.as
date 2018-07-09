package devoron.components.filechooser
{
	import utils.ImageUtil;
	import utils.ImageDecoder;
	import devoron.file.FileInfo;
	import devoron.airmediator.AirMediator;
	import devoron.file.LOC;
	import devoron.file.NATIVE;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import org.aswing.AssetIcon;
	import org.aswing.Icon;
	import org.aswing.util.Stack;
	
	/**
	 * GifFCH
	 * @author Devoron
	 */
	public class GifFCH implements IFileChooserHelper
	{
		[Embed(source = "../../../../assets/icons/font_icon16.png")]
		private var IMAGE_ICON16:Class;
		
		private var previewObjectCompleteListener:Function;
		private var path:String;
		public var currentMode:Namespace;
		
		public var objectsStack:Stack;	
		private var enabled:Boolean = true;
		
		public function GifFCH()
		{
			//if (CONFIG::air)
			//{
				currentMode = NATIVE;
			//}
			//else {
				//currentMode = LOC;
			//}
			
			objectsStack = new Stack();
		}
		
		/* INTERFACE devoron.components.filechooser.FileChooserHelper */
		
		public function getSupportedExtensions():Array
		{
			return ["gif"];
		}
		
		public function getType():String 
		{
			return "image";
		}
		
		public function getIcon():Icon 
		{
			return new AssetIcon(new IMAGE_ICON16, 16, 16);
		}
		
		public function isEnabled():Boolean 
		{
			return enabled;
		}
		
		public function setEnabled(b:Boolean):void 
		{
			enabled = b;
		}
		
		
		public function getPreviewObject(fi:FileInfo, previewObjectCompleteListener:Function):void
		{
			this.previewObjectCompleteListener = previewObjectCompleteListener;
			if (!fi.isDirectory && !running) {
				running = true;	
				AirMediator.getFile(fi.nativePath, onLoad, true);
				
				path = fi.nativePath;
				
			}
			if (!fi.isDirectory && running) {
				objectsStack.push( { fi:fi, listener:previewObjectCompleteListener } );
				//gtrace("загрузить " + 
			}
		}
		
		
		private function onLoad(fi:FileInfo):void
		{
			//gtrace(fi);
			var id:ImageDecoder = new ImageDecoder(fi.data, onDecode);
		}
		
		private var running:Boolean = false;
		
		private function onDecode(bd:BitmapData):void
		{
			//var bitmap:Bitmap = new Bitmap(bd, "auto", true);
			var max:Number = Math.max (bd.width, bd.height);
			var bitmap:Bitmap = new Bitmap(ImageUtil.scaleBitmapData(bd, 100 / max, true), "auto", true);
			var assetIcon:AssetIcon = new AssetIcon(bitmap, 197, 100, true);
			previewObjectCompleteListener.call(null, { path:path, icon: assetIcon } );
			
			
			if (objectsStack.isEmpty()) {
				running = false;
			}
			else {
				var obj:Object = objectsStack.pop();
				var fi:FileInfo = obj.fi;
				var listener:Function = obj.listener;
				previewObjectCompleteListener = listener;
				path = fi.nativePath;
				AirMediator.getFile(fi.nativePath, onLoad, true);
			}
		}
	
	}

}