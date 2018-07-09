
package org.aswing.plaf
{
	import org.aswing.plaf.ComponentUI;
	import org.aswing.JDropDownButton;

	public interface DropDownButtonUI extends ComponentUI
	{
		function isPopupVisible (c:JDropDownButton) : Boolean;

		function setPopupVisible (c:JDropDownButton, v:Boolean) : void;
	}
}
