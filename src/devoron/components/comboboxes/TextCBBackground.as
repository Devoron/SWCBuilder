package devoron.components.comboboxes
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import org.aswing.ASColor;
	import org.aswing.AssetIcon;
	import org.aswing.Component;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.GradientBrush;
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
	
	public class TextCBBackground extends DefaultsDecoratorBase implements GroundDecorator, UIResource
	{
		
		public function TextCBBackground()
		{
			super();
		
		}
		
		/* INTERFACE org.aswing.GroundDecorator */
		
		public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void
		{
			//g.clear();
			g.beginFill(new SolidBrush(new ASColor(0X463F39, 0)));
			g.drawRoundRect(new Pen(ASColor.getASColor(0, 0, 0, 0.2)), b.x - 2.5, b.y - 2, b.width, b.height + 1, 1);
			g.endFill();
			
			//g.beginFill(new SolidBrush(new ASColor(0XFFFFFF, 0.03)));
			g.beginFill(new SolidBrush(new ASColor(0XFFFFFF, 0.02)));
			g.drawRoundRect(new Pen(ASColor.getASColor(0, 0, 0, 0)), b.x - 2.5, b.y - 1.5, b.width, b.height * .5, 1);
			g.endFill();
		
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
}