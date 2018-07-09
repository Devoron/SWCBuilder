package devoron.components.comboboxes 
{
	import org.aswing.AbstractButton;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.JComboBox;
	
	/**
	 * Стилизованный комбобокс.
	 * @author Devoron
	 */
	public class GrayCBDown extends JComboBox 
	{
		
		/**
		 * Конструктор класса.
		 * @param	listData
		 */
		public function GrayCBDown(listData:*=null) 
		{
			super(listData);
			super.setUI(new GrayCBUI());
			//super.setMideground(new ASColor(0xFFFFFF, 0.5));
			//super.setForeground(new ASColor(0xFFFFFF, 0.5));
			super.setBackgroundDecorator(new GrayCBBackgroundDecorator());
			
			super.buttonMode = true;
			super.setForeground(new ASColor(0xFFFFFF, 0.5));
		}
		
	}

}
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.Sprite;
import flash.geom.Point;
import flash.net.URLRequest;
import flash.system.LoaderContext;
import org.aswing.ASColor;
import org.aswing.AssetIcon;
import org.aswing.Component;
import org.aswing.geom.IntDimension;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.Pen;
import org.aswing.graphics.SolidBrush;
import org.aswing.GroundDecorator;
import org.aswing.Icon;
import org.aswing.Insets;
import org.aswing.JButton;
import org.aswing.JComboBox;
import org.aswing.plaf.basic.BasicComboBoxUI;
import org.aswing.plaf.basic.icon.ArrowIcon;
import org.aswing.plaf.DefaultsDecoratorBase;
import org.aswing.plaf.UIResource;
import org.aswing.skinbuilder.SkinComboBoxUI;


class GrayCBBackgroundDecorator extends DefaultsDecoratorBase implements GroundDecorator, UIResource {
		
		
		public function GrayCBBackgroundDecorator() {
			super();
		}

		
		/* INTERFACE org.aswing.GroundDecorator */
		
		public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void 
		{
			g.clear();
			g.beginFill(new SolidBrush(ASColor.getASColor(0, 0, 0, 0.4)));
			g.drawPolygon(new Pen(ASColor.getASColor(255, 255, 255, 0.5), 0.1), new Array(new Point(b.width, 1), new Point(b.width-6, 1), new Point(b.width-3, 5)));
			g.endFill();
		}
		
		public function getDisplay(c:Component):DisplayObject 
		{
			return new Sprite();
		}
		
		
	}
	
	/**
	 * UI комбобокса.
	 */
	class GrayCBUI extends SkinComboBoxUI {
		
		public function GrayCBUI() {
			super();
		}
		
		override public function paint(c:Component, g:Graphics2D, b:IntRectangle):void {
			layoutCombobox();
			dropDownButton.setEnabled(true);
		}
		
		override protected function createDropDownButton():Component {
			return new Component();
		}
		
		
		
	}
	
	/**
	 * Иконка стрелки.
	 */
	class GrayArrowIcon implements Icon{
	
	public function GrayArrowIcon(){
	}
	
	/* INTERFACE org.aswing.Icon */
	
	public function getIconWidth(c:Component):int 
	{
		return 5;
	}
	
	public function getIconHeight(c:Component):int 
	{
		return 5;
	}
	
	public function updateIcon(c:Component, g:Graphics2D, x:int, y:int):void 
	{
		g.beginFill(new SolidBrush(ASColor.getASColor(0, 0, 0, 0.4)));
		g.drawPolygon(new Pen(ASColor.getASColor(255, 255, 255, 0.5)), new Array(new Point(0, 6), new Point(10, 6), new Point(5, 12)));
		g.endFill();
	}
	
	public function getDisplay(c:Component):DisplayObject 
	{
		return new Sprite();
	}
}
	
