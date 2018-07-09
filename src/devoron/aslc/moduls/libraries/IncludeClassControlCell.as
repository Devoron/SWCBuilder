
package devoron.aslc.moduls.libraries
{
	import devoron.components.labels.DSLabel;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.ASFontAdvProperties;
	import org.aswing.AssetIcon;
	import org.aswing.Component;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.JTable;
	import org.aswing.layout.FlowLayout;
	import org.aswing.table.DefaultTableModel;
	import org.aswing.table.TableCell;
	
	public class IncludeClassControlCell extends JPanel implements TableCell
	{
		[Embed(source="../../../../../assets/icons/commons/ellipse2.png")]
		private var INC_BTN:Class;
		
		private var lb:JLabel;
		private var lb2:JLabel;
		private var table:JTable;
		private var row:int;
		private var column:int;
		protected var value:*;
		
		public function IncludeClassControlCell()
		{
			super(new FlowLayout(FlowLayout.LEFT, 5));
			
			lb = new DSLabel("SWCBuilder");
			var advProp2:ASFontAdvProperties = new ASFontAdvProperties(true, "advanced", "subpixel");
			var font2:ASFont = new ASFont("Roboto Light", 9, true, false, false, advProp2);
			//lb.setTextFilters([new BlurFilter(1, 1, 3)]);
			lb.setForeground(new ASColor(0x7596a5));
			lb.setVerticalTextPosition(JLabel.BOTTOM);
			lb.setFont(font2);
			
			lb.setFont(lb.getFont().changeSize(11));
			lb.setPreferredWidth(30);
			
			append(lb);
			
			lb2 = new JLabel();
			lb2.setPreferredSize(new IntDimension(12, 12));
			lb2.addEventListener(MouseEvent.CLICK, onMClick);
			append(lb2);
			
			
		}
		
		private function onMClick(e:MouseEvent):void
		{
			if (lb2.getIcon() == null)
			{
				lb2.setIcon(new AssetIcon(new INC_BTN));
				value = true;
				(table.getModel() as DefaultTableModel).setValueAt(true, row, column);
			}
			else
			{
				lb2.setIcon(null);
				value = false;
				(table.getModel() as DefaultTableModel).setValueAt(false, row, column);
			}
			
			lb2.revalidate();
		}
		
		public function getCellComponent():Component
		{
			
			return this;
		}
		
		public function getCellValue():*
		{
			return value;
		}
		
		public function setCellValue(value:*):void
		{
			this.value = value;
			
			if (value)
			{
				var bi:Bitmap = new INC_BTN;
				bi.alpha = 0.5;
				lb2.setIcon(new AssetIcon(bi));
			}
			else
			{
				lb2.setIcon(null);
			}
		}
		
		override public function setComBounds(b:IntRectangle):void
		{
			readyToPaint = true;
			if (!b.equals(bounds))
			{
				if (b.width != bounds.width || b.height != bounds.height)
				{
					repaint();
				}
				bounds.setRect(b);
				locate();
				valid = false;
			}
		}
		
		/**
		 * Simpler this method to speed up performance
		 */
		override public function invalidate():void
		{
			valid = false;
		}
		
		/**
		 * Simpler this method to speed up performance
		 */
		override public function revalidate():void
		{
			valid = false;
		}
		
		public function setTableCellStatus(table:JTable, isSelected:Boolean, row:int, column:int):void
		{
			this.column = column;
			this.row = row;
			this.table = table;
			lb.setText(String(row));
			
			if (isSelected)
			{
				setBackground(table.getSelectionBackground());
				setForeground(table.getSelectionForeground());
			}
			else
			{
				setBackground(table.getBackground());
				setForeground(table.getForeground());
			}
			setFont(table.getFont());
		}
		
		override public function toString():String
		{
			return "FiltersCell[label:" + super.toString() + "]\n";
		}
	}
}
