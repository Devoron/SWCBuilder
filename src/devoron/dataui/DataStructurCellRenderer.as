package devoron.dataui{

import org.aswing.DefaultComboBoxEditor;
import org.aswing.DefaultListCell;

public class DataStructurCellRenderer extends DefaultListCell
{
	
	public function DataStructurCellRenderer()
	{
		super();
	}
	
	override protected function getStringValue(value:*):String
	{
		if (value is String)
			return value;
		return value.dataName;
	}

}

}