package devoron.components.checkboxes
{
	import org.aswing.ASColor;
	import org.aswing.event.AWEvent;
	import org.aswing.Icon;
	import org.aswing.JCheckBox;
	
	/**
	 * Стилизованный чекбокс.
	 * @author Devoron
	 */
	public class DSCheckBox extends JCheckBox
	{
		/**
		 * Конструктор класса.
		 * @param	text
		 * @param	icon
		 */
		public function DSCheckBox(text:String = "", icon:Icon = null)
		{
			super(text, icon);
			setForeground(new ASColor(0xFFFFFF, 0.4));
			buttonMode = true;
			setBackground(new ASColor(0xFFFFFF, 0.8));
			setIconTextGap(8);
			setAlpha(0.8);
			addActionListener(omg);
		}
		
		private function omg(e:AWEvent):void
		{
			if (isSelected())
				setForeground(new ASColor(0xFFFFFF, 0.6));
			else
				setForeground(new ASColor(0xFFFFFF, 0.4));
		}
	
	/*override public function setSelected(b:Boolean):void
	   {
	   super.setSelected(b);
	   if (b)
	   {
	   setForeground(new ASColor(0xFFFFFF, 0.6));
	   }
	   else
	   {
	   setForeground(new ASColor(0xFFFFFF, 0.4));
	   }
	   updateUI();
	
	 }*/
	
	}

}