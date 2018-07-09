package devoron.components.multicontainers.timeline.components
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import org.aswing.ASColor;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.BitmapBrush;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.Component;
	import org.aswing.graphics.Pen;
	import org.aswing.graphics.SolidBrush;
	import org.aswing.GroundDecorator;
	
	/**
	 * ...
	 * @author Devoron
	 */
	public class TimelinePanelBackgroundDecorator implements GroundDecorator
	{
		
		//[Embed(source="D:/a.png")]
		//private var BMClass:Class;
        
		public function TimelinePanelBackgroundDecorator()
		{
		
		}
		
		/* INTERFACE org.aswing.GroundDecorator */
		
		public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void
		{
			g.beginFill(new SolidBrush(new ASColor(0xFFFFFF, 0.01)));
			g.drawRectangle(new Pen(new ASColor(0xFFFFFF, 0.01), 0),b.x, b.y, b.width -20, b.height); 
			g.endDraw();
			g.endFill();
		}
		
		public function getDisplay(c:Component):DisplayObject
		{
			return new Sprite();
		}
	
	}

}