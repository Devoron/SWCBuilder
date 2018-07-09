package devoron.components.darktable
{
	import org.aswing.ASColor;
	import org.aswing.Container;
	import org.aswing.decorators.ColorDecorator;
	import org.aswing.DefaultTextFieldCellEditor;
	import org.aswing.geom.IntRectangle;
	import org.aswing.JTextField;
	
	
	/**
	 * ...
	 * @author ...
	 */
	public class DarkTableCellEditor extends DefaultTextFieldCellEditor
	{
		public function DarkTableCellEditor()
		{
		}
		
		override public function startCellEditing(owner:Container, value:*, bounds:IntRectangle):void
		{
			//bounds.y -= 1;
			bounds.y -= 2;
			//bounds.height += 2;
			bounds.height += 5;
			bounds.x -= 1.48;
			bounds.width += 5;
			super.startCellEditing(owner, value, bounds);
		}
		
		override public function getTextField():JTextField
		{
			if (textField == null)
			{
				textField = new JTextField();
				//textField.setBackground(new ASColor(0x040404, 0.8));
				
				//var cbd:ColorDecorator = new ColorDecorator(new ASColor(0x262F2B, 1), new ASColor(0, 0.2), 0);
				var cbd:ColorDecorator = new ColorDecorator(new ASColor(0x000000, 0.08));
				textField.setBackgroundDecorator(cbd);
				//textField.setBackground(new ASColor(0x262F2B, 1));
				textField.setForeground(new ASColor(0XFFFFFF, 0.8));
				textField.setRestrict(getRestrict());
			}
			return textField;
		}
	
	}

}