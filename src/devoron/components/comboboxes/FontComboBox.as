package devoron.components.comboboxes
{
	import devoron.components.list.FontListCellEditor;
	import devoron.components.list.FontListCellRenderer;
	import org.aswing.ASColor;
	import org.aswing.GeneralListCellFactory;
	import org.aswing.geom.IntDimension;
	
	/**
	 * FontComboBox
	 * @author Devoron
	 */
	public class FontComboBox extends DSComboBox
	{
		
		public function FontComboBox(listData:* = null)
		{
			super(listData);
			
			//fontsCB.setPreferredWidth(150);
			getPopupList().setSelectionBackground(new ASColor(0xFFFFFF, 0.2));
			getPopupList().setSelectionForeground(new ASColor(0X000000, 0.5));
			
			setMaximumRowCount(10);
			setPopupListWidth(300);
			setEditor(new FontListCellEditor());
			setListCellFactory(new GeneralListCellFactory(FontListCellRenderer, true, true, 24));
			setPreferredSize(new IntDimension(200, 24));
		}
	
	}

}