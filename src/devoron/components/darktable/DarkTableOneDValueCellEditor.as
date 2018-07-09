/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.components.darktable { 

import devoron.gameeditor.particleeditor.nodeforms.components.oneD.OneDValueComponent;
import flash.display.Sprite;
import org.aswing.AbstractCellEditor;
import org.aswing.ASColor;
import org.aswing.border.LineBorder;
import org.aswing.Component;
import org.aswing.Container;
import org.aswing.ext.Form;
import org.aswing.geom.IntRectangle;
import org.aswing.JNumberStepper;
import org.aswing.JTextField;

/**
 * The default editor for table and tree cells, use a textfield.
 * <p>
 * @author iiley
 */
public class DarkTableOneDValueCellEditor extends AbstractCellEditor{
	
	protected var odvc:OneDValueComponent;
	
	protected var form:Form;
	
	public function DarkTableOneDValueCellEditor (){
		super();
		setClickCountToStart(2);
	}
	
	public function getOneDValueComponent():Form {
		if (odvc == null) {
			form = new Form();
			var sp:Sprite = new Sprite();
			
			sp.graphics.beginFill(0x0E1012);
			sp.graphics.drawRoundRect(0, 0, 300, 20, 2, 2);
			sp.graphics.endFill();
			sp.graphics.lineStyle(1, 0xFFFFFF, 0.8);
			sp.graphics.drawRect(2, 2, 10, 10);
			form.addChild(sp);
			odvc = new OneDValueComponent();
			form.addLeftHoldRow(0, odvc.oneDValuesCB);
			odvc.setOwnerForm(form);
			form.setBorder(new LineBorder(null, new ASColor(0xFFFFFF, 0.8), 1, 3));
			form.setVisible(true);
		}
		return form;
	}
	
	override public function startCellEditing(owner:Container, value:*, bounds:IntRectangle):void 
		{
			//bounds.y += 1;
			bounds.height = 200;
			//bounds.x -= 1.48;
			bounds.width = 300;
			
			super.startCellEditing(owner, value, bounds);
		}
	
	/**
	 * Subclass override this method to implement specified value transform
	 */
	/*protected function transforValueFromText(text:String):*{
		return text;
	}*/
	
 	override public function getEditorComponent():Component{
 		return getOneDValueComponent();
 	}
	
	override public function getCellEditorValue():* {		
		return odvc.getRelatedOneDValue();
	}
	
   /**
    * Sets the value of this cell. 
    * @param value the new value of this cell
    */
	override protected function setCellEditorValue(value:*):void{
		//getTextField().setText(value+"");
		//getTextField().selectAll();
		//stepper.setValue(Number(value));
		odvc.setRelatedOneDValue(value);
	}
	
	public function toString():String{
		return "DarkTableOneDValueCellEditor[]";
	}
}
}