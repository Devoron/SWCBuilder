/*
   Copyright aswing.org, see the LICENCE.txt.
 */

package devoron.components.tables.icons
{
	
	import org.aswing.border.EmptyBorder;
	import org.aswing.Component;
	import org.aswing.geom.*;
	import org.aswing.Icon;
	import org.aswing.Insets;
	import org.aswing.JLabel;
	import org.aswing.JTable;
	import org.aswing.table.TableCell;
	
	/**
	 * Default table cell to render text
	 * @author iiley
	 */
	public class IconTextCellRenderer extends JLabel implements TableCell
	{
		
		protected var value:*;
		
		public function IconTextCellRenderer()
		{
			super();
			setHorizontalAlignment(LEFT);
			setVerticalAlignment(CENTER);
			setIconTextGap(2);
			
			//setBorder(new EmptyBorder(null, new Insets(0, 2)));
			//setBorder(new EmptyBorder(null, new Insets(-5,0)));
			setOpaque(true);
		}
		
		/**
		 * Simpler this method to speed up performance
		 */
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
		
		//**********************************************************
		//				  Implementing TableCell
		//**********************************************************
		public function setCellValue(value:*):void
		{
			this.value = value;
			/*if (value is Icon)
			{
				setIcon(value);
			}
			else if (value is Object)
			{*/
				setText(value.name + "");
				/*if (value is Object){
					setIcon(value.icon.icon);
				}
				else*/
				setIcon(value.icon);
			//}
		
		}
		
		public function getCellValue():*
		{
			return value;
		}
		
		public function setTableCellStatus(table:JTable, isSelected:Boolean, row:int, column:int):void
		{
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
		
		public function getCellComponent():Component
		{
			return this;
		}
		
		override public function toString():String
		{
			return "IconCell[label:" + super.toString() + "]\n";
		}
	}
}