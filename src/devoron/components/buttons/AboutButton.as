package devoron.components.buttons
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import net.kawa.tween.easing.Linear;
	import net.kawa.tween.KTween;
	import org.aswing.ASColor;
	import org.aswing.decorators.ColorDecorator;
	import org.aswing.JToggleButton;
	
	/**
	 * AboutButton
	 * @author Devoron
	 */
	public class AboutButton extends JToggleButton
	{
		//public var defaultTextColor:ASColor = new ASColor(0xFFFFFF, 0.4);
		public var defaultTextColor:ASColor = new ASColor(0x224351, 1);
		//public var selectedTextColor:ASColor = new ASColor(0xFFFFFF, 0.6)
		public var selectedTextColor:ASColor = new ASColor(0x224351, 0.6)
		//public var selectedTextColor:ASColor = new ASColor(0XD50000, 0.6)
		public var defaultBgColor:ASColor = new ASColor(0xFFFFFF, 0.1);
		public var selectedBgColor:ASColor = new ASColor(0xFFFFFF, 0.20)
		public var decorator:ColorDecorator;
		
		public function AboutButton(text:String, listener:Function = null)
		{
			super(text);
			setUI(new AboutButtonUI());
			setForeground(defaultTextColor);
			//decorator = new ColorDecorator(defaultBgColor, new ASColor(0xFFFFFF, 0), 2);
			//setBackgroundDecorator(decorator);
			
				//decorator = new CircleBackgroundDecorator(defaultBgColor, new ASColor(0xFFFFFF, 0.14), 2);
				//setBackgroundDecorator(decorator);
			
			setShiftOffsetSet(false);
			setHeight(16);
			setPreferredHeight(16);
			setShiftOffset(0);
			if (listener!=null)
				addActionListener(listener);
			//addStateListener(onStateChange);
			
			//addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			//addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			alpha = 0.44;
			
			
			
		(getUI() as AboutButtonUI).defaultBgColor = new ASColor(0, 0);
		//(getUI() as AboutButtonUI).selectedBgColor = new ASColor(0xFFFFFF, 0.04);
		(getUI() as AboutButtonUI).selectedBgColor = new ASColor(0xFFFFFF, 0);
		(getUI() as AboutButtonUI).decorator.setBorderColor(new ASColor(0, 0.24));		
		//(getUI() as AboutButtonUI).selectedTextColor = new ASColor(0x5a868f, 0.42);		
		(getUI() as AboutButtonUI).selectedTextColor = new ASColor(0x5a868f, 0.44);		
		
		
		(getUI() as AboutButtonUI).decorator.bottomGap = -1;
		(getUI() as AboutButtonUI).decorator.rightGap = -1;
			
			
		}
		
		override public function setSelected(b:Boolean):void 
		{
			super.setSelected(b);
			
			//if (b)
			//changeState();
			//trace("установка в кнопку " + getToolTipText() + " " + b);
			
			if (decorator) {
				//changeState(b);
			}
			
			//if(decorator){
			//if (b)
			//{
				//setForeground(selectedTextColor);
				//decorator.setColor(selectedBgColor);
				//trace("выбран " + isSelected());
				//KTween.to(this, 0.35, { alpha: 1 }, Linear.easeIn).init();
				////revalidate();
			//}
			//else
			//{
				//setForeground(defaultTextColor);
				//decorator.setColor(defaultBgColor);
				//KTween.to(this, 0.25, {alpha: 0.44}, Linear.easeIn).init();
			//}
			//}
			
		}
		
		private function onStateChange(e:Event):void
		{
			//changeState();
			//trace("change state " + isSelected());
		}
		
		private function changeState(b:Boolean):void 
		{
			if (b)
			{
				setForeground(selectedTextColor);
				//decorator.setColor(selectedBgColor);
				//trace("выбран " + isSelected());
				KTween.to(this, 0.25, {alpha: 1}, Linear.easeIn).init();
			}
			else
			{
				setForeground(defaultTextColor);
				//decorator.setColor(defaultBgColor);
				KTween.to(this, 0.25, {alpha: 0.44}, Linear.easeIn).init();
			}
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
