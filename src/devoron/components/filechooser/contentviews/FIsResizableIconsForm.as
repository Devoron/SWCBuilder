package devoron.components.filechooser.contentviews
{
	import devoron.components.SliderForm;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import org.aswing.AssetIcon;
	import org.aswing.Icon;
	import org.aswing.JButton;
	import org.aswing.JPanel;
	import org.aswing.JSlider;
	import org.aswing.JToggleButton;
	
	/**
	 * ...
	 * @author Devoron
	 */
	public class FIsResizableIconsForm extends BaseFIsContentViewForm
	{
		[Embed(source="../../../../../assets/icons/FileChooser/small_icons_icon16.png")]
		private var SMALL_ICONS_ICON16:Class;
		
		
		[Embed(source="../../../../../assets/icons/FileChooser/great_icons_icon16.png")]
		private var GREAT_ICONS_ICON16:Class;
		
		public function FIsResizableIconsForm()
		{
			setName("Resizable icons");
			var btnSmallIcon:JToggleButton = createIconButton(null/*new AssetIcon(new SMALL_ICONS_ICON16)*/, "16x16");
			append(btnSmallIcon);
			btnSmallIcon.mouseEnabled = false;
			
			var sl:JSlider = new JSlider();
			sl.setPreferredWidth(64);
			append(sl);
			
			var btnGreatIcon:JToggleButton = createIconButton(null/*new AssetIcon(new GREAT_ICONS_ICON16)*/, "512x512");
			append(btnGreatIcon);
			btnGreatIcon.mouseEnabled = false;
			
			sl.addEventListener(MouseEvent.CLICK, contentViewBtnHandler);
		}
	
	}

}