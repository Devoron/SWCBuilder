package devoron.data.core.history 
{
	/**
	 * ...
	 * @author Devoron
	 */
	public class History
	{
		private var points:Vector.<HistoryPoint>;
		
		public function History() 
		{
			points = new Vector.<HistoryPoint>();
		}
		
		/* INTERFACE devoron.data.core.IHistory */
		
		public function undo():void 
		{
			// движение по истории назад
		}
		
		public function redo():void 
		{
			
		}
		
		public function registerPoint(p:HistoryPoint):void 
		{
			// создание новой точки должно быть сохранено в хранилище истории
		}
		
		public function getPoints():Array 
		{
			return [];
		}
		
	}

}