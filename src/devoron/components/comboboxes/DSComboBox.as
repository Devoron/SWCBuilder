package devoron.components.comboboxes 
{
	import devoron.components.frames.StudioFrame;
	import org.aswing.ASColor;
	import org.aswing.border.EmptyBorder;
	import org.aswing.decorators.ColorDecorator;
	import org.aswing.GeneralListCellFactory;
	import org.aswing.Insets;
	import org.aswing.JComboBox;
	import org.aswing.JTextField;
	
	/**
	 * Стилизованный комбобокс.
	 * @author Devoron
	 */
	public class DSComboBox extends JComboBox 
	{
		private var pathTF:JTextField;
		
		/**
		 * Конструктор класса.
		 * @param	listData
		 */
		public function DSComboBox(listData:*=null) 
		{
			super(listData);
			
			//setUI(new TextCBUI());
			setBackgroundDecorator(null);
			//setBackgroundDecorator(new TextCBBackground);
			//typeCB.setEditable(true);
			//typeCB.setPreferredWidth(140);
			getPopupList().setBorder(new EmptyBorder(null, new Insets(2, 3, 4, 3)));
			getPopupList().setForeground(new ASColor(0xFFFFFF, 0.4));
			getPopupList().setSelectionForeground(new ASColor(0xFFFFFF, 0.8));
			getPopupList().setCellFactory(new GeneralListCellFactory(CellFact, true, true, 20));
			setForeground(new ASColor(0xFFFFFF, 0.45));
			
			//setBackgroundDecorator(new GrayCBBackgroundDecorator);
			
			//g.drawRoundRect(new Pen(new ASColor(0xFFFFFF, 0.04)), b.x-2, b.y-2, b.width, b.height+1, 2);
			var dec:ColorDecorator = new ColorDecorator(StudioFrame.defaultColor, new ASColor(0xFFFFFF, 0.04), 2);
			dec.setGaps(0, -2);
			//dec.setGaps(-2, 1, 1, -2);
			StudioFrame.decorators.push(dec);
			/*getPopupList().*/setBackgroundDecorator(dec);
			
			//acb.setBorder(new SideLineBorder(null, SideLineBorder.SOUTH, new ASColor(0xFFFFFF, 0.24), 0.4));
			//pathTF.setBorder(null);
			
		/*	var sld:SideLineDecorator = new SideLineDecorator(new ASColor(0, 0), new ASColor(0xFFFFFF, 0.4), 0, SideLineDecorator.SOUTH);
			sld.setGaps(0, 0, 0, -1);
			setBackgroundDecorator(sld);*/
			//setBorder(new LineBorder(null, new ASColor(0X000000, 0.2), 1, 1));
			//if(isSelected){
			//com.setBackground(list.getSelectionBackground());
			//com.setForeground(list.getSelectionForeground());
			
			//super.setMideground(new ASColor(0xFFFFFF, 0.5));
			//super.setForeground(new ASColor(0xFFFFFF, 0.5));
			//super.setBackgroundDecorator(new GrayCBBackgroundDecorator());
		/*	var colors:Array = [0XFFFFFF, 0XFFFFFF, 0x000000, 0x000000, 0x000000];
			var alphas:Array = [0.24, 0.14, 0.08, 0.04, 0.01];
			var ratios:Array = [0, 70, 145, 200, 255];
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(270, 24, 0, 0, 0);
			matrix.rotate(Math.PI * 0.5);
			var bc:GradientBackgroundDecorator =  new GradientBackgroundDecorator(GradientBackgroundDecorator.LINEAR, colors, alphas, ratios, matrix, "pad", "rgb", 0, new ASColor(0xFFFFFF, 0.04), 2);
			bc.setGaps(0, 0, -2, 2);*/
			//super.setBackgroundDecorator(bc);
			
			
			super.buttonMode = true;
			//super.setForeground(new ASColor(0xFFFFFF, 0.5));
		}
		
	}

}
import devoron.components.frames.StudioFrame;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Point;
import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.decorators.ColorDecorator;
import org.aswing.geom.IntDimension;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.Pen;
import org.aswing.graphics.SolidBrush;
import org.aswing.GroundDecorator;
import org.aswing.Icon;
import org.aswing.Insets;
import org.aswing.JButton;
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
			//g.beginFill(new SolidBrush(new ASColor(0X463F39, 0)));
			//g.beginFill(new SolidBrush(StudioFrame.defaultColor));
			g.beginFill(new SolidBrush(StudioFrame.defaultColor));
			g.drawRoundRect(new Pen(new ASColor(0xFFFFFF, 0.04)), b.x-2, b.y-2, b.width, b.height+1, 2);
			g.endFill();
			
			//g.beginFill(new SolidBrush(new ASColor(0XFFFFFF, 0.03)));
			/*g.beginFill(new SolidBrush(new ASColor(0XFFFFFF, 0.02)));
			g.drawRoundRect(new Pen(ASColor.getASColor(0, 0, 0, 0)), b.x-2, b.y-1.5, b.width, b.height*.5, 1);
			g.endFill();*/
			
			
			//var g:Graphics2D = new Graphics2D(backgroundSprite.graphics);
			
		/*	var matrix:Matrix = new Matrix();
			matrix.createGradientBox(b.width, b.height, 0, 0, 0);
			
			g.beginFill(new GradientBrush(fillType, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio));
			
			if (radius != 0)
			{
				var trR:Number = topRightRadius == -1 ? radius : topRightRadius;
				var blR:Number = bottomLeftRadius == -1 ? radius : bottomLeftRadius;
				var brR:Number = bottomRightRadius == -1 ? radius : bottomRightRadius;
				g.drawRoundRect(new Pen(borderColor, 0), b.x + leftGap, b.y + topGap, b.width + rightGap, b.height + bottomGap, radius, trR, blR, brR);
			}
			else
			{
				g.drawRectangle(new Pen(borderColor, 0), b.x + leftGap, b.y + topGap, b.width + rightGap, b.height + bottomGap);
			}
			
			g.endDraw();
			g.endFill();*/
			
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
		
			var btn:JButton = new JButton("", new GrayArrowIcon());
			btn.setFocusable(false);
			btn.setPreferredSize(new IntDimension(16, 16));
			var cdc:ColorDecorator = new ColorDecorator(StudioFrame.defaultColor);
			btn.setBackgroundDecorator(cdc);
			StudioFrame.decorators.push(cdc);
			btn.setMargin(new Insets());
			btn.setBorder(null);
			//make it proxy to the combobox
			btn.setMideground(null);
			btn.setStyleTune(null);
			return btn;
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
		g.beginFill(new SolidBrush(new ASColor(0x000000, 0.24)));
		g.drawPolygon(new Pen(new ASColor(0x000000, 0)), new Array(new Point(0, 5.3), new Point(10, 5.3), new Point(5, 10)));
		//g.drawPolygon(new Pen(new ASColor(0x000000, 0)), new Array(new Point(0, 6.3), new Point(10, 6.3), new Point(5, 11)));
		g.endFill();
	}
	
	public function getDisplay(c:Component):DisplayObject 
	{
		return new Sprite();
	}
}
	
