package devoron.components.tables.fonts
{
	
	import devoron.components.labels.DSLabel;
	import flash.events.MouseEvent;
	import flash.text.Font;
	import org.aswing.AbstractListCell;
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.ASFontAdvProperties;
	import org.aswing.Component;
	import org.aswing.Container;
	import org.aswing.decorators.ColorDecorator;
	import org.aswing.event.*;
	import org.aswing.geom.IntPoint;
	import org.aswing.JLabel;
	import org.aswing.JList;
	import org.aswing.JPanel;
	import org.aswing.JTable;
	import org.aswing.JTextField;
	import org.aswing.layout.BorderLayout;
	import org.aswing.layout.FlowLayout;
	import org.aswing.table.TableCell;
	
	/**
	 * Default list cell, render item value.toString() text.
	 * @author iiley
	 */
	public class FontsTableCellRenderer2 /*extends JPanel*/ implements TableCell
	{
		private var cellPanel:JPanel;
		private var fontNameLB:JLabel;
		private var fontRenderLB:JLabel;
		private var clb:ColorDecorator;
		private var value:*;
		private var table:JTable;
		private var row:int;
		
		private static var selRow:int;
		private var isSelected:Boolean;
		
		public function FontsTableCellRenderer2()
		{
			super();
		}
		
		public function setTableCellStatus(table:JTable, isSelected:Boolean, row:int, column:int):void
		{
			//table.getSelectedRow();
			this.isSelected = isSelected;
			this.row = row;
			this.table = table;
			//var font:ASFont = getFont();
			//font = font.changeName(table.getFont().getName());
			//font = font.changeSize(table.getFont().getSize());
			//setFont(font);
			
			if (isSelected)
			{
				selRow = row;
				cellPanel.setBackground(table.getSelectionBackground());
				cellPanel.setForeground(table.getSelectionForeground());
			}
			else
			{
				if(row !=selRow){
					cellPanel.setBackground(table.getBackground());
					cellPanel.setForeground(table.getForeground());
				}
				else {
					cellPanel.setBackground(table.getSelectionBackground());
					cellPanel.setForeground(table.getSelectionForeground());	
					}
			}
			
			
			var pane:Container =  table.getCellPane();
			for (var i:int = 0; i < pane.getComponentCount(); i++) 
			{
				trace("компонентик " + pane.getComponent(i));
			}
			
			
		
			//var b:Border = getBorder();
			//gtrace(b);
			
			//var tableFont:ASFont = tableFont.ch
			//var font:ASFont = new ASFont("Tahoma", 12, true, true, true);
			
		}
		
		
		protected var oldColor:ASColor;
		
		private function onMOver(e:MouseEvent):void
		{
			//KTween.to(clb, 0.15, {alpha: 1}, Linear.easeIn).init();
			fontNameLB.setForeground(new ASColor(0XFFFFFF, 0.8));
			fontRenderLB.setForeground(new ASColor(0XFFFFFF, 0.8));
			
			oldColor = clb.getColor().clone();
			clb.setColor(new ASColor(0x000000, 0.14));
			
		}
		
		private function onMOut(e:MouseEvent):void
		{
			if (isSelected)
			{
				clb.setColor(new ASColor(0xFFFFFF, 0.08));
			}
			else
			{
				clb.setColor(new ASColor(0x000000, 0));
			}
			
			
			//clb.setColor(new ASColor(0xFFFFFF, 0.04));
			//clb.setColor(oldColor);
			//oldColor = clb.getColor();
			fontNameLB.setForeground(new ASColor(0XFFFFFF, 0.4));
			fontRenderLB.setForeground(new ASColor(0XFFFFFF, 0.4));
		}
		
		public function setCellValue(value:*):void
		{
			this.value = value;
			//super.setCellValue(value);
			//var font:Font = value as Font;
			//fontNameLB.setText(font.fontName);
			//gtrace(value);
			fontNameLB.setText(value.getName());
			var advProp:ASFontAdvProperties = new ASFontAdvProperties(false, "advanced", "pixel");
			var font2:ASFont = new ASFont(value.getName(), 11, false, false, false, advProp);
			fontRenderLB.setFont(font2);
			fontRenderLB.updateUI();
		}
		
		/**
		 * Override this if you need other value->string translator
		 */
		protected function getStringValue(value:*):String
		{
			return value + "";
		}
		
		public function getCellComponent():Component
		{
			return getCellPanel();
		}
		
		/* INTERFACE org.aswing.table.TableCell */
		
		public function getCellValue():* 
		{
			return value;
		}
		
		protected function getCellPanel():JPanel
		{
			if (cellPanel == null)
			{
				cellPanel = new JPanel(new BorderLayout());
				clb = new ColorDecorator(new ASColor(0x000000, 0), null, 2);
				cellPanel.setBackgroundDecorator(clb);
				fontNameLB = new JLabel();
				fontRenderLB = new JLabel("Sample");
				fontNameLB.setForeground(new ASColor(0XFFFFFF, 0.4));
				fontRenderLB.setForeground(new ASColor(0XFFFFFF, 0.4));
				//fontNameLB.setOpaque(true);
				fontNameLB.setFocusable(false);
				//fontRenderLB.setOpaque(true);
				fontRenderLB.setFocusable(false);
				fontRenderLB.setPreferredWidth(80);
				cellPanel.append(fontNameLB, BorderLayout.WEST);
				cellPanel.append(fontRenderLB, BorderLayout.EAST);
				cellPanel.addEventListener(MouseEvent.MOUSE_OUT, onMOut);
				cellPanel.addEventListener(MouseEvent.MOUSE_OVER, onMOver);
				
			}
			return cellPanel;
		}
	}
}