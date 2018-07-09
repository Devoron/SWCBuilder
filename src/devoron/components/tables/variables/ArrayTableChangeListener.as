package devoron.components.tables.variables
{
import org.aswing.event.AWEvent;
import org.aswing.event.TableModelEvent;
import org.aswing.event.TableModelListener;
import org.aswing.JTable;

public class ArrayTableChangeListener implements TableModelListener
{
	private var table:JTable;
	public function ArrayTableChangeListener(t:JTable)
	{
		table = t;
	}
	
	/* INTERFACE org.aswing.event.TableModelListener */
	
	public function tableChanged(e:TableModelEvent):void 
	{
		table.dispatchEvent(new AWEvent(AWEvent.ACT));
	}

}
}