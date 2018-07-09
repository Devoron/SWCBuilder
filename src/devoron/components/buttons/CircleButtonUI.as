/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.components.buttons{
	
import org.aswing.*;
import org.aswing.graphics.Graphics2D;
import org.aswing.geom.IntRectangle;
import org.aswing.geom.IntDimension;
import org.aswing.plaf.*;	
import org.aswing.plaf.basic.BasicButtonUI;
	
/**
 * Basic ToggleButton implementation.
 * @author iiley
 * @private
 */	
public class CircleButtonUI extends BasicButtonUI{
	
	public function CircleButtonUI (){
		super();
	}
	
    override protected function getPropertyPrefix():String {
        return "ToggleButton.";
    }
        
    override protected function paintIcon(b:AbstractButton, g:Graphics2D, iconRect:IntRectangle):void {
		super.paintIcon(b, g, iconRect);
		
		
		var icon:Icon = b.getIcon();
		 if(icon != null){
			//setIconVisible(icon, true);
			//icon.updateIcon(b, g, iconRect.width*.25, iconRect.height*.25);
        }
		
		var sIcon:Icon = b.getSelectedIcon();
		 if(sIcon != null){
			//setIconVisible(icon, true);
			//sIcon.updateIcon(b, g, iconRect.width*.25, iconRect.height*.25);
        }
		
		var rOI:Icon = b.getRollOverIcon();
		 if(rOI != null){
			//setIconVisible(icon, true);
			//rOI.updateIcon(b, g, iconRect.width*.25, iconRect.height*.25);
        }
		
    }
	
	
}

}