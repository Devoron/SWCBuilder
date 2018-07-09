package devoron.components.buttons
{
	import flash.events.MouseEvent;
	import net.kawa.tween.easing.Linear;
	import net.kawa.tween.KTween;
	import org.aswing.ASColor;
	import org.aswing.decorators.ColorDecorator;
	import org.aswing.Icon;
	import org.aswing.JButton;
	
	/**
	 * DSButton
	 * @author Devoron
	 */
	public class DSButton extends JButton
	{
		
		public function DSButton(text:String = "", icon:Icon = null, listener:Function = null, width:uint = 16, height:uint = 16)
		{
			super(text, icon);
			setBackgroundDecorator(new ColorDecorator(new ASColor(0x000000, 0.14), new ASColor(0x000000, 0), 2));
			setPreferredWidth(width);
			setForeground(new ASColor(0xFFFFFF, 0.5));
			setMaximumHeight(height);
			if (listener != null)
				addActionListener(listener);
			
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			alpha = 0.44;
		}
		
		private function onRollOut(e:MouseEvent):void
		{
			KTween.to(this, 0.15, {alpha: 0.44}, Linear.easeIn).init();
			//setForeground(new ASColor(0xFFFFFF, 0.4));
		}
		
		private function onRollOver(e:MouseEvent):void
		{
			KTween.to(this, 0.15, {alpha: 1}, Linear.easeIn).init();
			//setForeground(new ASColor(0xFFFFFF, 0.6));
		}
	
	}

}