/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.components.darktable { 

import devoron.components.oneD.OneDValueComponent;
import devoron.components.threeD.ThreeDValueComponent;
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
public class DarkTableThreeDValueCellEditor extends AbstractCellEditor{
	
	protected var tdvc:ThreeDValueComponent;
	
	protected var form:Form;
	
	public function DarkTableThreeDValueCellEditor (){
		super();
		setClickCountToStart(2);
	}
	
	public function getThreeDValueComponent():Form {
		if (tdvc == null) {
			form = new Form();
			//var sp:Sprite = new Sprite();
		/*	sp.graphics.beginFill(0x0E1012);
			sp.graphics.lineStyle(1, 0xFFFFFF, 0.4);
			sp.graphics.drawRoundRect(0, 0, 240, 170, 4, 4);
			sp.graphics.endFill();
			form.addChild(sp);*/
			form.setBackgroundDecorator(new formDec());
			tdvc = new ThreeDValueComponent();
			form.addLeftHoldRow(0, tdvc.threeDValuesCB);
			tdvc.setOwnerForm(form, 10);
			//form.addEventListener(
			//form.setSizeWH(240, 250);
			//form.setBorder(new LineBorder(null, new ASColor(0xFFFFFF, 0.8), 1, 3));
			form.setVisible(true);
		}
		return form;
	}
	
	override public function startCellEditing(owner:Container, value:*, bounds:IntRectangle):void 
		{
			//bounds.y += 1;
			bounds.width = 240;
			bounds.height = 175;
			//bounds.x -= 1.48;
			
			super.startCellEditing(owner, value, bounds);
		}
	
	/**
	 * Subclass override this method to implement specified value transform
	 */
	/*protected function transforValueFromText(text:String):*{
		return text;
	}*/
	
 	override public function getEditorComponent():Component{
 		return getThreeDValueComponent();
 	}
	
	override public function getCellEditorValue():* {		
		return tdvc.getRelatedThreeDValue();
	}
	
   /**
    * Sets the value of this cell. 
    * @param value the new value of this cell
    */
	override protected function setCellEditorValue(value:*):void{
		//getTextField().setText(value+"");
		//getTextField().selectAll();
		//stepper.setValue(Number(value));
		 tdvc.setRelatedThreeDValue(value);
	}
	
	public function toString():String{
		return "DarkTableThreeDValueCellEditor[]";
	}
}
}
import flash.display.DisplayObject;
import flash.display.Sprite;
import org.aswing.ASColor;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.Component;
import org.aswing.graphics.Pen;
import org.aswing.graphics.SolidBrush;
import org.aswing.GroundDecorator;

internal class formDec implements GroundDecorator {
	
	public function formDec() {
		
	}
	
	/* INTERFACE org.aswing.GroundDecorator */
	
	public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void 
	{
		//var pen:
		g.beginFill(new SolidBrush(new ASColor(0x0E1012)));
		g.drawRoundRect(new Pen(new ASColor(0XFFFFFF, 0.4), 1), b.x, b.y, b.width-1, b.height-1, 3);
		g.endDraw();
		g.endFill();
	}
	
	public function getDisplay(c:Component):DisplayObject 
	{
		return new Sprite();
	}
	
}
