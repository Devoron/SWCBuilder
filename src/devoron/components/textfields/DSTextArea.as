package devoron.components.textfields 
{
	import flash.events.FocusEvent;
	import net.kawa.tween.easing.Linear;
	import net.kawa.tween.KTween;
	import org.aswing.ASColor;
	import org.aswing.border.SideLineBorder;
	import org.aswing.JTextArea;
	import org.aswing.JTextField;
	/**
	 * DSTextArea
	 * @author Devoron
	 */
	public class DSTextArea extends JTextArea
	{
		
		public function DSTextArea(text:String = "") 
		{
			super(text);
			setBackground(new ASColor(0,0));
			//setBackgroundDecorator(null);
			//setBorder(new SideLineBorder(null, SideLineBorder.SOUTH, new ASColor(0xFFFFFF, 0.24), 0.4));
			//setBorder(new SideLineBorder(null, SideLineBorder.SOUTH, new ASColor(0xFFFFFF, 1), 0.4));
			setForeground(new ASColor(0xFFFFFF, 1));
			
			addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			alpha = 0.5;
		}
		
		private function onFocusOut(e:FocusEvent):void 
		{
			KTween.to(this, 0.25, {alpha: 0.24}, Linear.easeIn).init();
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
		
		private function onFocusIn(e:FocusEvent):void 
		{
			KTween.to(this, 0.25, {alpha: 0.5}, Linear.easeIn).init();
		}
		
	}

}