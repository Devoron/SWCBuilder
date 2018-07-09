package devoron.data.core.base
{
	import flash.utils.ByteArray;
	import org.aswing.Component;
	
	public interface IDataProcessor
	{
		//function getData():*;
		//function setData(data:*);
		//function getDataClass():Class; // для TextEditor'ов, ImageEditor'a - ByteArray, для DirectoryEditor'a - FileInfo
		
		//function getSupportedProcessorEvents():Vector.<String>;
		function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeekReference:Boolean = false):void;
		function getView():Component;
		function setView(view:Component, options:Object):void;
		
		function set filePath(path:String):void;
		function get filePath():String;
		//function setModel():void;
		//function getModel():void;
		
		function get status():String;
		function get percentReady():Number;
		function get changed():Boolean;
	}
}