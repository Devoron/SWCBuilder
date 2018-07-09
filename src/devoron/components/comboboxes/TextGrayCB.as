package devoron.components.comboboxes 
{
	import flash.events.MouseEvent;
	import org.aswing.AbstractButton;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.JComboBox;
	
	/**
	 * Стилизованный комбобокс.
	 * @author Devoron
	 */
	public class TextGrayCB extends JComboBox 
	{
		
		/**
		 * Конструктор класса.
		 * @param	listData
		 */
		public function TextGrayCB(listData:*=null) 
		{
			super(listData);
			super.setUI(new TextGrayCBUI());
			//super.setMideground(new ASColor(0xFFFFFF, 0.5));
			//super.setForeground(new ASColor(0xFFFFFF, 0.5));
			super.setBackgroundDecorator(new GrayCBBackgroundDecorator());
			
			super.buttonMode = true;
			
			//gtrace("size "  + super.getFont().getSize());
			//super.setFont(super.getFont().changeSize(8));
			super.setFont(super.getFont().changeSize(9));
			
			super.setForeground(new ASColor(0xFFFFFF, 0.5));
			
			super.addEventListener(MouseEvent.MOUSE_OVER, onMouseRollOver);
			super.addEventListener(MouseEvent.MOUSE_OUT, onMouseRollOut);
			
			super.popupList.setFont(super.getFont().changeSize(11));
		}
		
		override public function setEnabled(b:Boolean):void 
		{
			super.setEnabled(b);
			if (!b)
			super.setForeground(new ASColor(0x000000, 0.24));
			else 
			super.setForeground(new ASColor(0xFFFFFF, 0.5));
		}
		
		private function onMouseRollOut(e:MouseEvent):void 
		{
			super.setForeground(new ASColor(0xFFFFFF, 0.5));
		}
		
		private function onMouseRollOver(e:MouseEvent):void 
		{
			super.setForeground(new ASColor(0xFFFFFF, 0.8));
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
			g.beginFill(new SolidBrush(new ASColor(0X463F39, 0)));
			g.drawRoundRect(new Pen(ASColor.getASColor(0, 0, 0, 0.2)), b.x-2, b.y-2, b.width, b.height+1, 2);
			g.endFill();
			
			g.beginFill(new SolidBrush(new ASColor(0XFFFFFF, 0.03)));
			g.drawRoundRect(new Pen(ASColor.getASColor(0, 0, 0, 0)), b.x-2, b.y-2, b.width, b.height*.5, 2);
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
	class TextGrayCBUI extends SkinComboBoxUI {
		
		public function TextGrayCBUI() {
			super();
		}
		
		override protected function installComponents():void 
		{
			//super.installComponents();
			/*dropDownButton = createDropDownButton();
			dropDownButton.setUIElement(true);
			box.addChild(dropDownButton);*/
		}
		override protected function uninstallComponents():void 
		{
			//super.uninstallComponents();
		}
		
		override public function paint(c:Component, g:Graphics2D, b:IntRectangle):void {
			layoutCombobox();
			//dropDownButton.setEnabled(true);
		}
	
		override protected function createDropDownButton():Component {
		
			var btn:JButton = new JButton("", new GrayArrowIcon());
			btn.setFocusable(false);
			btn.setPreferredSize(new IntDimension(16, 16));
			btn.setBackgroundDecorator(null);
			btn.setMargin(new Insets());
			btn.setBorder(null);
			//make it proxy to the combobox
			btn.setMideground(null);
			btn.setStyleTune(null);
			return null;
		}
		
		override public function getPreferredSize(c:Component):IntDimension
		{
			var insets:Insets = box.getInsets();
			var listPreferSize:IntDimension = getPopupList().getPreferredSize();
			var ew:int = listPreferSize.width;
			var wh:int = box.getEditor().getEditorComponent().getPreferredSize().height;
			//var wh:int = box.getEditor().getEditorComponent().getPreferredSize().width;
			//var size:
			
			return new IntDimension(ew, 20);
			/*var buttonSize:IntDimension = dropDownButton.getPreferredSize();
			buttonSize.width += ew;
			if (wh > buttonSize.height)
			{
				buttonSize.height = wh;*/
			//}
			//return insets.getOutsideSize(buttonSize);
		}
		
		override public function getMinimumSize(c:Component):IntDimension
		{
			//return box.getInsets().getOutsideSize(dropDownButton.getPreferredSize());
			return new IntDimension();
		}
		
		override protected function layoutCombobox():void 
		{
			var td:IntDimension = box.getSize();
			var insets:Insets = box.getInsets();
			var top:int = insets.top;
			var left:int = insets.left;
			var right:int = td.width - insets.right;
			
			var height:int = td.height - insets.top - insets.bottom;
			//var buttonSize:IntDimension = dropDownButton.getPreferredSize();
			//dropDownButton.setSizeWH(buttonSize.width, height);
			//dropDownButton.setLocationXY(right - buttonSize.width, top);
			box.getEditor().getEditorComponent().setLocationXY(left, top-4);
			box.getEditor().getEditorComponent().setSizeWH(td.width - insets.left - insets.right /*-buttonSize.width*/, height);
			box.getEditor().getEditorComponent().revalidate();
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
	
