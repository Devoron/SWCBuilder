package devoron.components.filechooser 
{
	import devoron.components.darktable.DarkTableCellEditor;
	import org.aswing.ASColor;
	import org.aswing.event.SelectionEvent;
	import org.aswing.JTable;
	import org.aswing.table.GeneralTableCellFactory;
	import org.aswing.table.GeneralTableCellFactoryUIResource;
	import org.aswing.table.TableModel;
	import org.aswing.TableTextHeaderCell;

	
	/**
	 * Таблица структур данных.
	 * @author Devoron
	 */
	public class FileChooserHelpersTable extends JTable 
	{
		public function FileChooserHelpersTable(model:TableModel) 
		{
			super(model);
			
			setShowHorizontalLines(true);
			setGridColor(ASColor.getASColor(255, 255, 255, 0.015));
			//setGridColor(ASColor.getASColor(255, 255, 255, 0.2));
			setForeground(new ASColor(0xE1E2D6, 0.4));
			//setSelectionBackground(new ASColor(0XFFFFFF, 0.15));
			setSelectionBackground(new ASColor(0XFFFFFF, 0.01));
			//setSelectionForeground(new ASColor(0xFFFFFF, 0.4));
			setSelectionForeground(new ASColor(0xFFFFFF, 0.4));
			setTableHeader(null);
			setRowHeight(22);
			/*getTableHeader().setPreferredHeight(17);
			getTableHeader().setForeground(new ASColor(0xFFFFFF, 0.5));
			getTableHeader().setMideground(new ASColor(0xFFFFFF, 0));
			getTableHeader().setBackground(new ASColor(0X000000, 0));*/
			setBackground(new ASColor(0xFFFFFF, 0.01));
			setBackgroundChild(null);
			setDefaultEditor("String", new DarkTableCellEditor());
			setDefaultCellFactory("IFileChooserHelper",  new GeneralTableCellFactory(FileChooserHelpersTableCellRender));
			getSelectionModel().setSelectionMode(JTable.SINGLE_SELECTION);
			//setColumnsSize(100, 95, 52);
			setColumnsResizable(false);
			setScrollPaneDisabledWhenEditing(true);
		}
		
		
	}

}

