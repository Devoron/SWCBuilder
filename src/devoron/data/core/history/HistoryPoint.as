package devoron.data.core.history 
{
	import devoron.data.core.base.DataStructur;
	import devoron.data.core.base.DataStructurObject;
	import flash.display.BitmapData;
	import org.aswing.Icon;
	/**
	 * HistoryPoint
	 * @author Devoron
	 */
	public class HistoryPoint 
	{
		public var snapshot:BitmapData;
		private var ds:DataStructur;
		private var dso:DataStructurObject;
		public var dsIcon:Icon;
		public var dsName:String;
		public var dsoName:String;
		public var dsoIcon:Icon;
		public var valueName:String;
		public var oldValue:*;
		public var newValue:*;
		
		public function HistoryPoint(ds:DataStructur, dso:DataStructurObject) 
		{
			this.dso = dso;
			this.ds = ds;
			//dso.toString
			// нужен полный путь к этой структуре данных
			// в ней нужен путь к dso
			// полученный dso должен быть сериализован
			
		}
		
	}

}