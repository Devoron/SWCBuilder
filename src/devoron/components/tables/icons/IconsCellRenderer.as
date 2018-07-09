package devoron.components.tables.icons 
{
	import org.aswing.table.PoorTextCell;
	/**
	 * ...
	 * @author Devoron
	 */
	public class IconsCellRenderer extends PoorTextCell
	{
		
		public function IconsCellRenderer() 
		{
		}
		
		override public function setText(text:String):void 
		{
			super.setText(text+"x"+text);
		}
		
	}

}