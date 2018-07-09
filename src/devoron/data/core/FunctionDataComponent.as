package devoron.data.core
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import org.aswing.event.AWEvent;
	
	[Event(name="act",type="org.aswing.event.AWEvent")]
	
	/**
	 * Компонент, который содержит только данные
	 * без представления.
	 * @author Devoron
	 */
	public class FunctionDataComponent extends EventDispatcher
	{
		protected var data:*;
		
		public function FunctionDataComponent(initialData:*)
		{
			data = initialData;
		}
		
		public function setData(value:*, dispatchAWEvent:Boolean = true):void
		{
			if (data == value)
				return;
			data = value;
			if (dispatchAWEvent)
				super.dispatchEvent(new AWEvent(AWEvent.ACT));
		}
		
		public function getData():*
		{
			return data;
		}
		
		public function changeData(value:*):void
		{
			//super.dispatchEvent(new AWEvent(AWEvent.ACT));
		}
		
		public function addActionListener(listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			super.addEventListener(AWEvent.ACT, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeActionListener(listener:Function):void
		{
			super.removeEventListener(AWEvent.ACT, listener);
		}
	
	}

}