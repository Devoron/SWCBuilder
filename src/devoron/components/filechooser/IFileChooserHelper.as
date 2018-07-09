package devoron.components.filechooser 
{
	import devoron.file.FileInfo;
	import org.aswing.Icon;
	/**
	 * IFileChooserHelper
	 * @author Devoron
	 */
	public interface IFileChooserHelper 
	{
		function getSupportedExtensions():Array;
		//function getPreviewObject(fi:FileInfo, previewObjectCompleteListener:Function):void;
		function getPreviewObject(fi:FileInfo, previewObjectCompleteListener:Function):void;
		function getType():String;
		function getIcon():Icon;
		function isEnabled():Boolean;
		function setEnabled(b:Boolean):void;
	}

}