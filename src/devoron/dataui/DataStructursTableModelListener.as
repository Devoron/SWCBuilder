package devoron.dataui
{
	import org.aswing.event.AWEvent;
	import org.aswing.event.TableModelEvent;
	import org.aswing.event.TableModelListener;
	import org.aswing.JTable;
	
	public class DataStructursTableModelListener implements TableModelListener
	{
		private var table:JTable;
		
		public function DataStructursTableModelListener(t:JTable)
		{
			table = t;
		}
		
		/* INTERFACE org.aswing.event.TableModelListener */
		
		public function tableChanged(e:TableModelEvent):void
		{
			//table.dispatchEvent(new AWEvent(AWEvent.ACT));
			table.dispatchEvent(e);
		}
	
	}
}