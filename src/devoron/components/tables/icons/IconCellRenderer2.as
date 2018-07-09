package devoron.components.tables.icons
{
	import devoron.components.icons.WatchingIcon;
	import devoron.components.labels.DSLabel;
	import flash.events.MouseEvent;
	import flash.text.Font;
	import net.kawa.tween.easing.Linear;
	import net.kawa.tween.KTween;
	import org.aswing.AbstractListCell;
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.ASFontAdvProperties;
	import org.aswing.Component;
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
	public class IconCellRenderer2 /*extends JPanel*/implements TableCell
	{
		private var cellPanel:JPanel;
		private var iconPathLB:JLabel;
		private var iconRenderLB:JLabel;
		private var clb:ColorDecorator;
		private var value:*;
		private var table:JTable;
		private var isSelected:Boolean;
		
		public function IconCellRenderer2()
		{
			super();
		}
		
		public function setTableCellStatus(table:JTable, isSelected:Boolean, row:int, column:int):void
		{
			this.isSelected = isSelected;
			this.table = table;
			//var font:ASFont = getFont();
			//font = font.changeName(table.getFont().getName());
			//font = font.changeSize(table.getFont().getSize());
			//setFont(font);
			
			//var id:ColorDecorator = new ColorDecorator(new ASColor(0x0F1E1C, 1) /*new ASColor(0XFFFFFF, 0.24), */);
				//var id:ColorDecorator = new ColorDecorator(new ASColor(0X000000, 0.08), new ASColor(0XFFFFFF, 0.24), 4);
				//id.setGaps(-2, 1, 1, -2);
				//id.setGaps(-1, 0, 0, -1);
				//popup.setBackgroundDecorator(id);
			
			if (isSelected)
			{
				//id.setColor(table.getSelectionBackground());
				cellPanel.setBackground(table.getSelectionBackground());
				cellPanel.setForeground(table.getSelectionForeground());
			}
			else
			{
				//id.setColor(table.getBackground());
				cellPanel.setBackground(table.getBackground());
				cellPanel.setForeground(table.getForeground());
			}
			//cellPanel.setBackgroundDecorator(id);
			
			//var b:Border = getBorder();
			//gtrace(b);
		
			//var tableFont:ASFont = tableFont.ch
			//var font:ASFont = new ASFont("Tahoma", 12, true, true, true);
		
		}
		
		private function onRollOut(e:MouseEvent):void
		{
			KTween.to(cellPanel, 0.25, {alpha: 0.66}, Linear.easeIn).init();
			
			if(isSelected)
			cellPanel.setBackground(table.getSelectionBackground());
			else
			cellPanel.setBackground(table.getBackground());
			
		/*if (v)
		   {
		   alpha = 0;
		   super.setVisible(true);
		   KTween.to(this, 0.15, {alpha: 1}, Linear.easeIn).init();
		   }
		   else
		   {
		   //super.setVisible(false);
		   KTween.to(this, 0.08, {alpha: 0}, Linear.easeIn, onAlphaReduceComplete).init();
		 }*/
		}
		
		private function onRollOver(e:MouseEvent):void
		{
			cellPanel.setBackground(new ASColor(0x000000, 0.14));
			KTween.to(cellPanel, 0.25, {alpha: 1}, Linear.easeIn).init();
		}
		
		public function setCellValue(value:*):void
		{
			this.value = value;
			//super.setCellValue(value);
			//var font:Font = value as Font;
			//fontNameLB.setText(font.fontName);
			//gtrace(value);
			//iconPathLB.setText(value);
			iconPathLB.setText(value);
			/*var advProp:ASFontAdvProperties = new ASFontAdvProperties(false, "advanced", "pixel");
			   var font2:ASFont = new ASFont(value.getName(), 11, false, false, false, advProp);
			   iconRenderLB.setFont(font2);
			 iconRenderLB.updateUI();*/
			//iconRenderLB.setIcon(new WatchingIcon(value.path, 32, 32, false));
			//iconRenderLB.setIcon(new WatchingIcon(value, 32, 32, false));
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
				//cellPanel.setBackgroundDecorator(clb);
				cellPanel.setOpaque(true);
				iconPathLB = new JLabel();
				iconRenderLB = new JLabel("");
				iconRenderLB.setHorizontalAlignment(JLabel.CENTER);
				iconRenderLB.setVerticalAlignment(JLabel.CENTER);
				iconPathLB.setForeground(new ASColor(0XFFFFFF, 0.4));
				iconRenderLB.setForeground(new ASColor(0XFFFFFF, 0.4));
				//fontNameLB.setOpaque(true);
				iconPathLB.setFocusable(false);
				//fontRenderLB.setOpaque(true);
				iconRenderLB.setFocusable(false);
				iconRenderLB.setPreferredWidth(64);
				iconRenderLB.setPreferredHeight(32);
				cellPanel.append(iconRenderLB, BorderLayout.WEST);
				cellPanel.append(iconPathLB, BorderLayout.CENTER);
				
				cellPanel.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
				cellPanel.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
				cellPanel.alpha = 0.84;
				
			}
			return cellPanel;
		}
	}
}