package devoron.dataui.bindings
{
	import org.aswing.util.HashMap;
	import flash.events.Event;
	
	/**
	 * ListenersController
	 * @author Devoron
	 */
	public class ListenersController
	{
		private var listenersHash:HashMap = new HashMap;
		private var _active:Boolean;
		private var model:DataUIModel;
		
		public function ListenersController(model:DataUIModel)
		{
			this.model = model;
		
		}
		
		public function addDataChangeListener(listener:Function, params:Object, comps:Array /*... comps*/):void
		{
			//if (dataChangeComponents == null)
				//dataChangeComponents = [];
			/*dataChangeListener = listener;
			 dataChangeParams = params;*/
			
			var dataChangeHandleVO:Object;
			
			for each (var comp:*in comps)
			{
				
				dataChangeHandleVO = listenersHash.get(comp);
				if (dataChangeHandleVO)
				{
					// удалить прежний слушатель, если подключается новый?
					if (dataChangeHandleVO.listener != listener)
					{
						removeChangeListener(dataChangeHandleVO.listener, comp);
						comp.removeActionListener(dataChangeHandler);
					}
					
					// создать новый dataChangeHandleVO и записать в хэш
					dataChangeHandleVO = {listener: listener, params: params};
					listenersHash.put(comp, dataChangeHandleVO);
					comp.addActionListener(dataChangeHandler);
				}
				
					//dataChangeComponents.push(comp);
					//model.addDataComponent(comp);
			}
		}
		
		public function removeChangeListener(listener:Function, /*params:Object, */ comps:Array /*... comps*/):void
		{
			//if (dataChangeComponents == null)
			//dataChangeComponents = [];
			//dataChangeListener = listener;
			//dataChangeParams = params;
			
			var dataChangeHandleVO:Object;
			
			for each (var comp:*in comps)
			{
				
				dataChangeHandleVO = listenersHash.get(comp);
				if (dataChangeHandleVO)
				{
					// удалить прежний слушатель, если подключается новый?
					if (dataChangeHandleVO.listener != listener)
					{
						//removeChangeListener(dataChangeHandleVO.listener, comp);
						comp.removeActionListener(dataChangeHandler);
					}
					
				}
				
					//dataChangeComponents.push(comp);
					//model.addDataComponent(comp);
			}
		}
		
		/**
		 * Удалить все слушатели.
		 */
		public function removeAllDataChangeListeners():void
		{
			var dataChangeHandleVO:Object;
			var comps:Array = listenersHash.keys();
			for each (var comp:*in comps)
			{
				dataChangeHandleVO = listenersHash.get(comp);
				if (dataChangeHandleVO)
				{
					comp.removeActionListener(dataChangeHandleVO.listener);
				}
				
			}
			
			listenersHash.clear();
		}
		
		/**
		 * Обработчик изменения данных
		 * @param	e
		 */
		public function dataChangeHandler(e:Event):void
		{
			if (active)
			{
				//model.
				model.lastActiveComp = e.currentTarget;
				
				var dataChangeHandleVO:Object = listenersHash.get(e.currentTarget);
				if (dataChangeHandleVO)
				{
					dataChangeHandleVO.listener.call(null, dataChangeHandleVO.params);
				}
				
			}
		}
		
		public function get active():Boolean
		{
			return _active;
		}
		
		public function set active(value:Boolean):void
		{
			_active = value;
		}
	
	}

}