package devoron.components.buttons
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.BitmapBrush;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.Pen;
	import org.aswing.graphics.SolidBrush;
	import org.aswing.GroundDecorator;
	
	/**
	 * ColorDecorator
	 * @author Devoron
	 */
	public class CircleBackgroundDecorator implements GroundDecorator
	{
		public var radius:Number;
		private var topRightRadius:Number = -1;
		private var bottomLeftRadius:Number = -1;
		private var bottomRightRadius:Number = -1;
		public var color:ASColor;
		public var borderColor:ASColor;
		public var backgroundSprite:Sprite;
		public var comp:Component;
		public var graphics:Graphics2D;
		public var bounds:IntRectangle;
		public var rightGap:int;
		public var leftGap:int;
		public var topGap:int;
		public var bottomGap:int;
		public var image:BitmapData;
		private var openingRect:Rectangle;
		private var internalBorderColor:ASColor;
		
		public function CircleBackgroundDecorator(color:ASColor, borderColor:ASColor = null, radius:Number = 0)
		{
			this.radius = radius;
			this.borderColor = borderColor ? borderColor : new ASColor(0, 0);
			this.color = color;
			backgroundSprite = new Sprite();
		}
		
		public function setOpeningRect(rectangle:Rectangle, internalBorderColor:ASColor = null):void
		{
			this.internalBorderColor = internalBorderColor;
			openingRect = rectangle;
			if (comp)
			{
				updateDecorator(comp, graphics, bounds);
					//c.updateUI();
			}
		}
		
		public function clone():CircleBackgroundDecorator
		{
			var decorator:CircleBackgroundDecorator = new CircleBackgroundDecorator(color, borderColor, radius);
			if (image)
				decorator.setImage(image.clone());
			return decorator;
		}
		
		public function setImage(bd:BitmapData):void
		{
			image = bd;
			if (comp)
			{
				updateDecorator(comp, graphics, bounds);
					//c.updateUI();
			}
		}
		
		public function getImage():BitmapData
		{
			return image;
		}
		
		public function getColor():ASColor
		{
			return color;
		}
		
		public function setColor(value:ASColor):void
		{
			color = value;
			if (comp)
			{
				updateDecorator(comp, graphics, bounds);
					//c.updateUI();
			}
		}
		
		public function setRadius(radius:Number):void
		{
			this.radius = radius;
			if (comp)
			{
				updateDecorator(comp, graphics, bounds);
					//comp.updateUI();
			}
		}
		
		/* INTERFACE org.aswing.GroundDecorator */
		
		public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void
		{
			comp = c;
			graphics = g;
			bounds = b;
			backgroundSprite.graphics.clear();
			backgroundSprite.mouseChildren = true;
			backgroundSprite.mouseEnabled = false;
			var g2d:Graphics2D = new Graphics2D(backgroundSprite.graphics);
			
			if (image)
				g2d.beginFill(new BitmapBrush(image));
			else
				g2d.beginFill(new SolidBrush(color));
			
			g2d.drawCircle(new Pen(borderColor, 0), b.width * .5 /*- 1*/, b.height * .5 /*- 1*/, b.width * 0.5-1);
			//if (openingRect)
			//g2d.drawRectangle(new Pen((internalBorderColor || new ASColor(0, 0)), 0), openingRect.x, openingRect.y, openingRect.width, openingRect.height);
			
			g2d.endDraw();
			g2d.endFill();
		}
		
		public function getDisplay(c:Component):DisplayObject
		{
			return backgroundSprite;
		}
	
	}

}