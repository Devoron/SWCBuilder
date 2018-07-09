package devoron.components.buttons
{
	import devoron.dataui.multicontainers.table.DataContainersForm;
	import flash.events.MouseEvent;
	import net.kawa.tween.easing.Linear;
	import net.kawa.tween.KTween;
	import org.aswing.ASColor;
	import org.aswing.Icon;
	import org.aswing.JDropDownButton;
	import org.aswing.JPopup;
	
	/**
	 * DSDropDownButton
	 * @author Devoron
	 */
	public class DSDropDownButton extends JDropDownButton
	{
		
		public function DSDropDownButton(text:String, icon:Icon, isSelected:Boolean, popupOrComponent:* = null)
		{
			super(text, icon, isSelected, popupOrComponent);
			setPopupAlignment(JDropDownButton.BOTTOM);
			setForeground(new ASColor(0xFFFFFF, 1));
			setFont(super.getFont().changeUnderline(true));
			setBackgroundDecorator(null);
			setPreferredWidth(100);
			
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			
			alpha = 0.24;
		
		}
		
		private function onRollOut(e:MouseEvent):void
		{
			KTween.to(this, 0.15, {alpha: 0.24}, Linear.easeIn).init();
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
			KTween.to(this, 0.15, {alpha: 0.5}, Linear.easeIn).init();
		}
	
	}

}