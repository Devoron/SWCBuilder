package devoron.data.core.base
{
	
	/**
	 * IDataProcessorsProvider
	 * @author Devoron
	 */
	public interface IDataProcessorsProvider
	{
		function getDataProcessor(title:String, editorCls:Class, fullpath:String, isDir:Boolean, useControlPanel:Boolean = false):IDataProcessor;
	}

}