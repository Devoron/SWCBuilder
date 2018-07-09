package devoron.components.hidebuttons
{
	import org.aswing.AssetIcon;
	import org.aswing.Component;
	import org.aswing.event.AWEvent;
	import org.aswing.geom.IntDimension;
	import org.aswing.JToggleButton;
	
	/**
	 * BottomHideButton
	 * @author Devoron
	 */
	public class BottomHideButton extends HideButton
	{
		[Embed(source="../../../../assets/icons/commons/Hide_arrowTop_defaultImage.png")]
		private var hideIcon:Class;
		
		[Embed(source="../../../../assets/icons/commons/Hide_arrowTop_pressedImage.png")]
		private var pressedIcon:Class;
		
		[Embed(source="../../../../assets/icons/commons/Hide_arrowTop_rolloverImage.png")]
		private var rolloverIcon:Class;
		
		[Embed(source="../../../../assets/icons/commons/Hide_arrowBottom_defaultImage.png")]
		private var selectedIcon:Class;
		
		[Embed(source="../../../../assets/icons/commons/Hide_arrowBottom_pressedImage.png")]
		private var selectedPressedIcon:Class;
		
		[Embed(source="../../../../assets/icons/commons/Hide_arrowBottom_rolloverImage.png")]
		private var selectedRolloverIcon:Class;
		
		public function BottomHideButton(hideTarget:Component = null, hideTargetContainer:Component = null)
		{
			super(hideTarget, hideTargetContainer);
			setIcon(new AssetIcon(new hideIcon, 32, 6));
			setPressedIcon(new AssetIcon(new pressedIcon, 32, 6));
			setBackgroundDecorator(null);
			setRollOverIcon(new AssetIcon(new rolloverIcon, 32, 6));
			setSelectedIcon(new AssetIcon(new selectedIcon, 32, 6));
			setRollOverSelectedIcon(new AssetIcon(new selectedRolloverIcon, 32, 6));
			setSize(new IntDimension(32, 6));
			
			addActionListener(onStateChange);
		}
		
		private function onStateChange(e:AWEvent):void
		{
			if (isSelected())
				setPressedIcon(new AssetIcon(new selectedPressedIcon, 32, 6));
			else
				setPressedIcon(new AssetIcon(new pressedIcon, 32, 6));
		}
	
	}

}