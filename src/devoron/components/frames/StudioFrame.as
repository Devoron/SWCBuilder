package devoron.components.frames
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.ui.Keyboard;
	import net.kawa.tween.easing.Linear;
	import net.kawa.tween.KTween;
	import org.aswing.ASColor;
	import org.aswing.AssetIcon;
	import org.aswing.border.EmptyBorder;
	import org.aswing.decorators.ColorDecorator;
	import org.aswing.decorators.GradientBackgroundDecorator;
	import org.aswing.Insets;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.JFrameTitleBar;
	
	/**
	 * StudioFrame
	 * @author Devoron
	 */
	public class StudioFrame extends JFrame
	{
		[Embed(source="../../../../assets/icons/commons/Frame_fullscreenIcon_defaultImage.png")]
		private var FULLSCREEN_ICON:Class;
		
		private var transtions:Array;
		
		public static var decorators:Vector.<ColorDecorator> = new Vector.<ColorDecorator>();
		public static var defaultColor:ASColor = ASColor.getASColor(20, 50, 66, 1);
		
		public function StudioFrame(owner:* = null, title:String = "", modal:Boolean = false, closableOnly:Boolean = true)
		{
			super(owner, title, modal);
			var titleBar:JFrameTitleBar = getTitleBar() as JFrameTitleBar;
			titleBar.setFont(titleBar.getFont().changeName("Arial"));
			titleBar.setForeground(new ASColor(0x224351, 1));
			//titleBar.getLabel().setForeground(new ASColor(0x224351));
			titleBar.setClosableOnly(closableOnly);
			titleBar.addEventListener(MouseEvent.CLICK, onClick);
			
			var colors:Array = [0x000000, 0x000000, 0x000000, 0x000000, 0x000000];
			var alphas:Array = [0.24, 0.14, 0.08, 0.04, 0.01];
			var ratios:Array = [0, 70, 145, 200, 255];
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(270, 22, 0, 0, 0);
			var bgGr:GradientBackgroundDecorator = new GradientBackgroundDecorator(GradientBackgroundDecorator.LINEAR, colors, alphas, ratios, matrix, "pad", "rgb", 0, new ASColor(0xFFFFFF, 0), 4);
			bgGr.setGaps(0, 2, 1);
			titleBar.setBackgroundDecorator(bgGr);
			buttonMode = true;
			titleBar.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
			titleBar.setMaximizeButton(null);
			titleBar.revalidate();
			
			var btn:JButton = new JButton("", new AssetIcon(new FULLSCREEN_ICON));
			btn.setBackgroundDecorator(null);
			
			//setFont(getFont().changeName("Roboto"));
			//titleBar.setFont(titleBar.getFont().changeName("Roboto"));
			//titleBar.setFont(titleBar.getFont().changeBold(false));
			//titleBar.setForeground(new ASColor(0xFFFFFF, 0.65));
			//var buttonPane:JPanel = titleBar.getCloseButton().getParent() as JPanel;
			//buttonPane.insert(2, btn);
			//titleBar.addExtraControl(btn, 2);
			
			//titleBar.getCloseButton().getParent().setBorder(new EmptyBorder(null, new Insets(4, 0))); //make label y offset -3, x offset 7
			titleBar.getCloseButton().getParent().setBorder(new EmptyBorder(null, new Insets(8, 0))); //make label y offset -3, x offset 7
			//titleBar.getCloseButton().getParent().insert(0, btn);
			//titleBar.getLabel().getParent().setBorder(new EmptyBorder(null, new Insets(-2, 7)));
			titleBar.getLabel().getParent().setBorder(new EmptyBorder(null, new Insets(2, 7)));
			filters = [new DropShadowFilter(4, 45, 0x000000, 0.14, 4, 4, 0.5, 2)];
			
			//var cd:ColorDecorator = new ColorDecorator(new ASColor(0x1C221F,1), new ASColor(0XFFFFFF, 0.24), 4);
			//var cd:ColorDecorator = new ColorDecorator(ASColor.getASColor(155, 158, 157, 0.4), new ASColor(0XFFFFFF, 0.24), 4);
			//cd.setGaps(-2, 1, 1, -2);
			//setBackgroundDecorator(cd);
			
			//var id:ImageDecorator = new ImageDecorator((new img as Bitmap).bitmapData, new ASColor(0XFFFFFF, 0.24), 4);
			//id.setOpeningRect(new Rectangle(305, 24, 900 - 305, 425));
			
			//var id:ColorDecorator = new ColorDecorator(new ASColor(0x262F2B, 1), new ASColor(0XFFFFFF, 0.08), 4);
			//var id:ColorDecorator = new ColorDecorator(new ASColor(0x0F1E1C, 1), new ASColor(0XFFFFFF, 0.24), 4);
			//var id:ColorDecorator = new ColorDecorator(new ASColor(0x0F1E1C, 1), new ASColor(0XFFFFFF, 0.08), 4);
			//var id:ColorDecorator = new ColorDecorator(new ASColor(0x161C1F, 1), new ASColor(0XFFFFFF, 0.24), 4);
			//var id:ColorDecorator = new ColorDecorator(new ASColor(0x0F151E, 1), new ASColor(0XFFFFFF, 0.24), 4);
			//var id:ColorDecorator = new ColorDecorator(new ASColor(0X000000, 0.08), new ASColor(0XFFFFFF, 0.24), 4);
			var id:ColorDecorator = new ColorDecorator(defaultColor, new ASColor(0XFFFFFF, 0.08), 4);
			id.setGaps(-2, 1, 1, -2);
			//id.setGaps(-1, 0, 0, 0);
			setBackgroundDecorator(id);
			
			decorators.push(id);
			
			//setOpaque(true);
			setTransitions([]);
			/*if (frame && isTitleEnabled())
			   {
			   frame.closeReleased();
			 }*/
			
			//addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			//addEventListener(FocusEvent.FOCUS_IN, onFocusOut);
			
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		private function onClick(e:MouseEvent):void
		{
			//var titleBar:JFrameTitleBar = getTitleBar() as JFrameTitleBar;
			//titleBar.setForeground(new ASColor(Math.random()*0xFFFFFF, 1));
		}
		
		private function onMouseOut(e:MouseEvent):void
		{
			if (stage)
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onMouseOver(e:MouseEvent):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			//gtrace(e);
			if (e.keyCode == Keyboard.ESCAPE)
			{
				//gtrace("EsC");
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				closeReleased();
			}
		}
		
		override public function closeReleased():void
		{
			//super.closeReleased();
			setVisible(false);
		}
		
		/*override public function hide():void
		   {
		   if (!transtions)
		   {
		   super.hide();
		   }
		   else
		   {
		   //if(v)
		   //KTween.to(this, 0.35, {alpha:1}, Linear.easeIn, onCompile);
		   //else
		   KTween.to(this, 0.35, {alpha: 0}, Linear.easeIn, onCompile);
		   }
		 }*/
		
		public function setTransitions(transitions:Array):void
		{
			this.transtions = transtions;
		}
		
		override public function setVisible(v:Boolean):void
		{
			/*if (!transtions)
			   {
			   super.setVisible(v);
			   }
			   else
			 {*/
			
			if (transtions)
			{
				if (v)
				{
					showFrame();
				}
				else
				{
					//super.setVisible(false);
					hideFrame()
				}
			}
			else
			{
				super.setVisible(v);
			}
		
			//}
		}
		
		protected function showFrame():void
		{
			alpha = 0;
			super.setVisible(true);
			KTween.to(this, 0.15, {alpha: 1}, Linear.easeIn).init();
		}
		
		protected function hideFrame():void
		{
			KTween.to(this, 0.08, {alpha: 0}, Linear.easeIn, onAlphaReduceComplete).init();
		}
		
		private function onAlphaReduceComplete():void
		{
			super.setVisible(false);
		}
	
	}

}