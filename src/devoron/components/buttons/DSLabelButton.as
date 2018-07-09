package devoron.components.buttons 
{
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.ASFontAdvProperties;
	import org.aswing.Icon;
	import org.aswing.JLabel;
	import org.aswing.JLabelButton;
	
	import devoron.studio.tools.RegistrationFonts;
	
	/**
	 * DSLabel
	 * @author Devoron
	 */
	public class DSLabelButton extends JLabelButton
	{
		
		public function DSLabelButton(text:String="", icon:Icon=null, horizontalAlignment:int=JLabel.LEFT) 
		{
			super(text, icon, horizontalAlignment);
			//super.setForeground(new ASColor(0xFFFFFF, 0.8));
			//super.setForeground(new ASColor(0xFFFFFF, 0.5));
			super.setForeground(new ASColor(0xFFFFFF, 0.45));
		}
		
	}

}