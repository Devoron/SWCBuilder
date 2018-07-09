package devoron.components.buttons
{
	import flash.filters.BlurFilter;
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.ASFontAdvProperties;
	import org.aswing.Icon;
	import org.aswing.JLabelButton;
	import org.aswing.JToggleButton;
	import org.aswing.plaf.ComponentUI;
	import org.aswing.ToggleButtonModel;
	
	/**
	 * DSStateLabelButton
	 * @author Devoron
	 */
	public class DSStateLabelButton extends JLabelButton
	{
		
		public function DSStateLabelButton(text:String = "", icon:Icon = null, horizontalAlignment:int = 0)
		{
			super(text, icon, horizontalAlignment);
			setModel(new ToggleButtonModel());
			//setPressedColor(new ASColor(0x143242));
			
			/*var advProp:ASFontAdvProperties = new ASFontAdvProperties(true, "advanced", "pixel");
			   //var font2:ASFont = new ASFont("GT Walsheim Pro", 11, true, false, false, advProp);
			   var font2:ASFont = new ASFont("Gilroy Light", 12, true, false, false, advProp);
			   font2 = font2.changeBold(true);
			 setFont(font2);*/
			
			var advProp:ASFontAdvProperties = new ASFontAdvProperties(true, "advanced", "pixel");
			//var font2:ASFont = new ASFont("GT Walsheim Pro", 14, true, false, false, advProp);
			var font2:ASFont = new ASFont("GT Walsheim Pro", 14, true, false, false, advProp);
			//font2 = font2.changeBold(true);
			setFont(font2);
			//fontRenderLB.updateUI();
			setTextFilters([new BlurFilter(1, 1, 3)]);
			
			setPressedColor(new ASColor(0x5a868f, 1));
			setRollOverColor(new ASColor(0x5a868f, 1))
			//setForeground(new ASColor(0x5a868f, 0.4));
			//setForeground(new ASColor(0x5a868f, 0.6));
			//setForeground(new ASColor(0x070E0D, 0.6));
			setForeground(new ASColor(0x5a868f, 0.4));
		
		}
	
		//override public function setUI(newUI:ComponentUI):void 
		//{
	
		//super.setUI(new JLabelButtonUI);
		//}
	
	}

}