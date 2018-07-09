package devoron.dataui.propertiescontainer 
{
	
	/**
	 * ...
	 * @author Devoron
	 */
	public interface IPropertiesComponentsProvider 
	{
		function getBooleanFieldComponent(boolCls:String, key:String, defaultValue:*=null):IFieldComponent;
		function getImageFieldComponent(imgCls:String, key:String, defaultValue:*=null):void;
		function getSoundFieldComponent(imgCls:String, key:String, defaultValue:*=null):void;
		function getTextFieldComponent(renderer:String, key:String, defaultValue:*=null):void;
		function getImageFieldComponent(imgCls:String, key:String, defaultValue:*=null):void;
		
	}
	
}