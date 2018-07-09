package devoron.components.filechooser 
{
	import devoron.file.FileInfo;
	/**
	 * FileChooserHelper
	 * @author Devoron
	 */
	public interface FileChooserHelper 
	{
		function getSupportedExtensions():Array;
		function getPreviewObject(fi:FileInfo, previewObjectCompleteListener:Function):void;
		
	}

}