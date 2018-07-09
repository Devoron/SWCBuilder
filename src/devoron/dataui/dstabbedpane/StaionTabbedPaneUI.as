package devoron.components.data.dstabbedpane
{
	import flash.geom.Matrix;
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.ASFontAdvProperties;
	import org.aswing.Component;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.GradientBrush;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.Pen;
	import org.aswing.JTabbedPane;
	import org.aswing.plaf.basic.BasicTabbedPaneUI;
	import org.aswing.plaf.basic.tabbedpane.BasicTabbedPaneTab;
	import org.aswing.plaf.basic.tabbedpane.Tab;
	import org.aswing.StyleResult;
	import org.aswing.StyleTune;
	
	/**
	 * StaionTabbedPaneUI
	 */
	public class StaionTabbedPaneUI extends BasicTabbedPaneUI
	{
		
		public function StaionTabbedPaneUI()
		{
		
		}
		
		/**
		 * override this method to draw different tab base line for your LAF
		 */
		protected override function drawBaseLine(tabBarBounds:IntRectangle, g:Graphics2D, fullB:IntRectangle, selTabB:IntRectangle):void
		{
			//tabBarBounds.height *=0.8
			
			//return; //dosn't draw line in this version
			var b:IntRectangle = tabBarBounds.clone();
			var placement:int = tabbedPane.getTabPlacement();
			var pen:Pen;
			var lineT:Number = 2; //contentRoundLineThickness;
			if (selTabB == null)
			{
				selTabB = new IntRectangle(fullB.x + fullB.width / 2, fullB.y + fullB.height / 2, 0, 0);
			}
			selTabB = selTabB.clone();
			var cl:ASColor = tabbedPane.getMideground();
			cl.changeAlpha(.04);
			var adjuster:StyleTune = tabbedPane.getStyleTune();
			var style:StyleResult = new StyleResult(cl, adjuster);
			var matrix:Matrix = new Matrix();
			var dark:ASColor = style.bdark;
			var light:ASColor = style.bdark.offsetHLS(0, 0.15, -0.1);
			var leadingOffset:int = tabbedPane.getLeadingOffset();
			if (isTabHorizontalPlacing())
			{
				var isTop:Boolean = (placement == JTabbedPane.TOP);
				if (isTop)
				{
					b.y = b.y + b.height - contentMargin.top;
				}
				else
				{
					b.y += contentMargin.top - lineT / 2;
				}
				b.width += tabBorderInsets.getMarginWidth();
				b.x -= tabBorderInsets.left;
				
				var selPart:IntRectangle = new IntRectangle(selTabB.x, b.y, selTabB.width, 2);
				//matrix.createGradientBox(tabBorderInsets.left, 1, 0, selPart.x, selPart.y);
				light = new ASColor(0xFFFFFF, 0.2);
				//g.fillRectangle(new GradientBrush(GradientBrush.LINEAR, [light.getRGB(), light.getRGB()], [0, 0.4], [0, 255], matrix), selPart.x, selPart.y, selPart.width, 1);
				
				var colors:Array = [0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF];
				var alphas:Array = [0.01, 0.04, 0.08, 0.14, 0.24, 0.24, 0.14, 0.08, 0.04, 0.01];
				var ratios:Array = [0, 25, 50, 75, 100, 135, 175, 200, 225, 255];
				var matrix:Matrix = new Matrix();
				matrix.createGradientBox(selPart.width, 1, 0, selPart.x, selPart.y);
				
				g.fillRectangle(new GradientBrush(GradientBrush.LINEAR, colors, alphas, ratios, matrix), selPart.x/*- selPart.width*.5*/, selPart.y+3, selPart.width, 1);
				
				/*var leftPart:IntRectangle = new IntRectangle(b.x, b.y, selTabB.x - b.x - 10, 2);
				   var rightPart:IntRectangle = new IntRectangle(selTabB.x + selTabB.width + 10, b.y, b.x + b.width - (selTabB.x + selTabB.width) - 10, 2);
				
				   matrix.createGradientBox(tabBorderInsets.left, 1, 0, leftPart.x, leftPart.y);
				   light  = new ASColor(0xFFFFFF, 0.2);
				   g.fillRectangle(new GradientBrush(GradientBrush.LINEAR, [light.getRGB(), light.getRGB()], [0, 0.4], [0, 255], matrix), leftPart.x, leftPart.y, leftPart.width, 1);
				   matrix.createGradientBox(tabBorderInsets.right, 1, Math.PI, rightPart.x + rightPart.width - tabBorderInsets.right, rightPart.y);
				
				 g.fillRectangle(new GradientBrush(GradientBrush.LINEAR, [light.getRGB(), light.getRGB()], [0, 0.4], [0, 255], matrix), rightPart.x, rightPart.y + 1, rightPart.width, 1);*/
			}
			
			else
			{
				var isLeft:Boolean = (placement == JTabbedPane.LEFT);
				if (isLeft)
				{
					b.x = b.x + b.width - contentMargin.top;
				}
				else
				{
					b.x += contentMargin.top - lineT / 2;
				}
				b.height += tabBorderInsets.getMarginWidth();
				b.y -= tabBorderInsets.left;
				
				var topPart:IntRectangle = new IntRectangle(b.x, b.y, 2, selTabB.y - b.y);
				var botPart:IntRectangle = new IntRectangle(b.x, selTabB.y + selTabB.height, 2, b.y + b.height - (selTabB.y + selTabB.height));
				
				matrix.createGradientBox(1, tabBorderInsets.left, Math.PI / 2, topPart.x, topPart.y);
				g.fillRectangle(new GradientBrush(GradientBrush.LINEAR, [dark.getRGB(), dark.getRGB()], [0, 1], [0, 255], matrix), topPart.x, topPart.y, 1, topPart.height);
				/*g.fillRectangle(new GradientBrush(
				   GradientBrush.LINEAR,
				   [light.getRGB(), light.getRGB()],
				   [0, 1],
				   [0, 255],
				   matrix
				   ),
				   topPart.x+1, topPart.y, 1, topPart.height);
				 */
				matrix.createGradientBox(1, tabBorderInsets.right, -Math.PI / 2, botPart.x, botPart.y + botPart.height - tabBorderInsets.right);
				g.fillRectangle(new GradientBrush(GradientBrush.LINEAR, [dark.getRGB(), dark.getRGB()], [0, 1], [0, 255], matrix), botPart.x, botPart.y, 1, botPart.height);
				/*g.fillRectangle(new GradientBrush(
				   GradientBrush.LINEAR,
				   [light.getRGB(), light.getRGB()],
				   [0, 1],
				   [0, 255],
				   matrix
				   ),
				 botPart.x+1, botPart.y, 1, botPart.height);*/
			}
		}
	
	}

}