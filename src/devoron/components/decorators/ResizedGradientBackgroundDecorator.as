package devoron.components.decorators 
{
	import flash.geom.Matrix;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.decorators.GradientBackgroundDecorator;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.GradientBrush;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.Pen;
	/**
	 * ResizedGradientBackgroundDecorator
	 * @author Devoron
	 */
	public class ResizedGradientBackgroundDecorator extends GradientBackgroundDecorator
	{
		
		public function ResizedGradientBackgroundDecorator(fillType:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0, borderColor:ASColor = null, radius:Number = 0) 
		{
			super(fillType, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio, borderColor, radius);
		}
		

		override public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void
		{
			
			comp = c;
			graphics = g;
			bounds = b;
			backgroundSprite.graphics.clear();
			backgroundSprite.mouseChildren = true;
			backgroundSprite.mouseEnabled = false;
			var g2d:Graphics2D = new Graphics2D(backgroundSprite.graphics);
			
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(b.width, b.height, 0, 0, 0);
			

			
				if (b.width < 150)
			{
				matrix.createGradientBox(b.width * 1.5, b.height, 0, 0, 0);
			}
			else
			{
				matrix.createGradientBox(b.width, b.height, 0, 0, 0);
			}
			
			
			
			g2d.beginFill(new GradientBrush(fillType, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio));
			
			if (radius != 0)
			{
				var trR:Number = topRightRadius == -1 ? radius : topRightRadius;
				var blR:Number = bottomLeftRadius == -1 ? radius : bottomLeftRadius;
				var brR:Number = bottomRightRadius == -1 ? radius : bottomRightRadius;
				g2d.drawRoundRect(new Pen(borderColor, 1), b.x + leftGap, b.y + topGap, b.width + rightGap, b.height + bottomGap, radius, trR, blR, brR);
			}
			else
			{
				g2d.drawRectangle(new Pen(borderColor, 0), b.x + leftGap, b.y + topGap, b.width + rightGap, b.height + bottomGap);
			}
			
			g2d.endDraw();
			g2d.endFill();
		}
		
	}

}