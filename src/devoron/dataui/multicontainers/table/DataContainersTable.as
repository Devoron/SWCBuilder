package devoron.dataui.multicontainers.table 
{
	import devoron.studio.plugins.modificators.ktween.GraphCellRenderer;
	import devoron.components.darktable.DarkTableCellEditor;
	import devoron.components.darktable.DarkTableNumberCellEditor;
	import devoron.components.tables.DSTable;
	import devoron.data.core.base.DataStructurObject;
	//import devoron.studio.modificators.ktween.GraphCellRenderer;
	import flash.geom.Matrix;
	import org.aswing.ASColor;
	import org.aswing.decorators.GradientBackgroundDecorator;
	import org.aswing.event.AWEvent;
	import org.aswing.event.SelectionEvent;
	import org.aswing.JTable;
	import org.aswing.table.DefaultTableModel;
	import org.aswing.table.GeneralTableCellFactory;
	import org.aswing.table.GeneralTableCellFactoryUIResource;
	import org.aswing.table.TableModel;
	import org.aswing.TableTextHeaderCell;

	
	/**
	 * Таблица контейнеров данных.
	 * @author Devoron
	 */
	public class DataContainersTable extends DSTable 
	{
		
		public function DataContainersTable (model:TableModel) 
		{
			super(model);
			
		/*	super.setShowHorizontalLines(true);
			super.setGridColor(ASColor.getASColor(255, 255, 255, 0.015));
			super.setForeground(new ASColor(0xE1E2D6, 0.4));
			//super.setSelectionBackground(new ASColor(0XFFFFFF, 0.15));
			super.setSelectionBackground(new ASColor(0XFFFFFF, 0.08));
			super.setSelectionForeground(new ASColor(0xFFFFFF, 0.4));
			super.getTableHeader().setPreferredHeight(17);
			super.getTableHeader().setForeground(new ASColor(0xFFFFFF, 0.5));
			super.getTableHeader().setMideground(new ASColor(0xFFFFFF, 0));
			super.getTableHeader().setBackground(new ASColor(0X000000, 0));*/
			
			
			/*var colors:Array = [0x000000, 0x000000, 0x000000, 0x000000, 0x000000];
			var alphas:Array = [0.24, 0.14, 0.08, 0.04, 0.01];
			var ratios:Array = [0, 70, 145, 200, 255];
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(270, 17, 0, 0, 0);
			//super.getTableHeader().set
			super.getTableHeader().setBackgroundDecorator(new GradientBackgroundDecorator(GradientBackgroundDecorator.LINEAR, colors, alphas, ratios, matrix, "pad", "rgb", 0, new ASColor(0xFFFFFF, 0), 2));*/
			//super.setTableHeader(new TableHeaderCustom(super.getColumnModel()));
			
			
			//super.setBackground(new ASColor(0xFFFFFF, 0.01));
			//super.setBackgroundChild(null);
			super.setDefaultEditor("String", new DarkTableCellEditor());
			//setDefaultCellFactory("Graph", new GeneralTableCellFactory(GraphCellRenderer));
			//super.getSelectionModel().setSelectionMode(JTable.SINGLE_SELECTION);
			super.getSelectionModel().setSelectionMode(JTable.MULTIPLE_SELECTION);
			super.setColumnsResizable(false);
			
			
			
			setDefaultEditor("Number", new DarkTableNumberCellEditor());
			
			getModel().addTableModelListener(new DataContainersTableChangeListener(this));
		}
		
		public override function getData():* {
			//super.dispatchEvent(new Event(Event.CHANGE));
			return (super.getModel() as DefaultTableModel).getData();
		}
		
		public override function setData(data:*):void {
			(super.getModel() as DefaultTableModel).setData(data);
		}
		
		
	}

}

