package devoron.dataui.multicontainers.table
{
	import devoron.data.core.base.IDataContainer;
	import org.aswing.Container;
	import org.aswing.VectorListModel;
	
	/**
	 * IContainersControlPanel
	 * @author Devoron
	 */
	public interface IContainersControlPanel
	{
		function setData(dataArray:Array):void
		function getData():Array;
		function getControlPanel():Container;
		function addIContentViewListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		function setConsoleComands(commands:Array):void;
		function addActionListener(listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		function removeActionListener(listener:Function):void;
		function setContainersModel(model:VectorListModel):void;
		function getSelectedValue():*;
		function setSelectedValueIndex(index:uint):void;
		function clear():void;
		function setCurrentContainer(dc:IDataContainer):void;
		function setCurrentContainerIndex(index:uint):void;
	}

}