/*
   Copyright aswing.org, see the LICENCE.txt.
 */

package org.aswing.plaf.basic
{
	import org.aswing.border.EmptyBorder;
	import org.aswing.decorators.ColorBackgroundDecorator;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import org.aswing.layout.BorderLayout;
	import org.aswing.plaf.basic.icon.ScrollBarArrowIcon;
	import org.aswing.skinbuilder.SkinButtonIcon;
	import org.aswing.util.DepthManager;
	
	import org.aswing.*;
	import org.aswing.event.AWEvent;
	import org.aswing.event.FocusKeyEvent;
	import org.aswing.event.ListItemEvent;
	import org.aswing.geom.*;
	import org.aswing.graphics.*;
	import org.aswing.plaf.*;
	import org.aswing.plaf.basic.icon.ArrowIcon;
	import org.aswing.util.ASTimer;
	
	/**
	 * Basic drop down button ui imp.
	 * @author Devoron
	 * @private
	 */
	public class BasicDropDownButtonUI extends BasicButtonUI implements DropDownButtonUI
	{
		protected var dropDownButton:Component;
		//protected var button:JDropDownButton;
		protected var popup:JPopup;
		
		protected var popupTimer:ASTimer;
		protected var moveDir:Number;
		
		public function BasicDropDownButtonUI()
		{
			super();
		}
		
		override public function installUI(c:Component):void
		{
			button = JDropDownButton(c);
			installDefaults(button);
			installComponents(button);
			installListeners(button);
		}
		
		override public function uninstallUI(c:Component):void
		{
			button = JDropDownButton(c);
			uninstallDefaults(button);
			uninstallComponents(button);
			uninstallListeners(button);
		}
		
		override protected function getPropertyPrefix():String
		   {
		   return "DropDownButton.";
		 }
		
		override protected function paintIcon(b:AbstractButton, g:Graphics2D, iconRect:IntRectangle):void
		{
			var model:ButtonModel = b.getModel();
			var icon:Icon = null;
			
			var icons:Array = getIcons();
			for (var i:int = 0; i < icons.length; i++)
			{
				var ico:Icon = icons[i];
				setIconVisible(ico, false);
			}
			
			if (!model.isEnabled())
			{
				if (model.isSelected())
				{
					icon = b.getDisabledSelectedIcon();
				}
				else
				{
					icon = b.getDisabledIcon();
				}
			}
			else if (model.isPressed() && model.isArmed())
			{
				icon = b.getPressedIcon();
				if (icon == null)
				{
					// Use selected icon
					icon = b.getSelectedIcon();
				}
			}
			else if (model.isSelected())
			{
				if (b.isRollOverEnabled() && model.isRollOver())
				{
					icon = b.getRollOverSelectedIcon();
					if (icon == null)
					{
						icon = b.getSelectedIcon();
					}
				}
				else
				{
					icon = b.getSelectedIcon();
				}
			}
			else if (b.isRollOverEnabled() && model.isRollOver())
			{
				icon = b.getRollOverIcon();
			}
			
			if (icon == null)
			{
				icon = b.getIcon();
			}
			if (icon == null)
			{
				icon = getIconToLayout();
			}
			if (icon != null)
			{
				setIconVisible(icon, true);
				/**
				 * ТЕСТОВОЕ
				 * +4 нужно оформить как icon gap, чтобы сделать отступ
				 */
				icon.updateIcon(b, g, iconRect.x + 4, iconRect.y);
			}
		}
		
		override protected function setIconVisible(icon:Icon, visible:Boolean):void
		{
			super.setIconVisible(icon, visible);
		}
		
		override protected function installDefaults(b:AbstractButton):void
		{
			var pp:String = getPropertyPrefix();
			LookAndFeel.installBorderAndBFDecorators(button, pp);
			LookAndFeel.installColorsAndFont(button, pp);
			LookAndFeel.installBasicProperties(button, pp);
			//button.setBorder(new EmptyBorder(null, new Insets(0, 2, 0, 0)));
		}
		
		override protected function uninstallDefaults(b:AbstractButton):void
		{
			LookAndFeel.uninstallBorderAndBFDecorators(button);
		}
		
		override protected function installComponents(b:AbstractButton):void
		{
			dropDownButton = createDropDownButton();
			dropDownButton.setUIElement(true);
			textField = AsWingUtils.createLabel(b, "label");
			b.setFontValidated(false);
			b.addChild(dropDownButton);
		}
		
		override protected function uninstallComponents(b:AbstractButton):void
		{
			b.removeChild(textField);
		/*	btn.removeChild(dropDownButton);
		   if (isPopupVisible(btn))
		   {
		   setPopupVisible(btn, false);
		 }*/
		}
		
		override protected function installListeners(b:AbstractButton):void
		{
			super.installListeners(b);
			
			//getPopupList().setFocusable(false);
			b.addEventListener(MouseEvent.MOUSE_DOWN, __onBtnPressed);
			b.addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onFocusKeyDown);
			b.addEventListener(Event.REMOVED_FROM_STAGE, __onBtnRemovedFromStage);
			popupTimer = new ASTimer(18);
			//popupTimer = new ASTimer(40);
			popupTimer.addActionListener(__movePopup);
		}
		
		private function __onFocusKeyDown(e:FocusKeyEvent):void
		{
			if (e.keyCode == Keyboard.ESCAPE)
			{
				popup.hide();
				button.setSelected(false);
			}
		}
		
		override protected function uninstallListeners(b:AbstractButton):void
		{
			super.uninstallListeners(b);
			
			popupTimer.stop();
			popupTimer = null;
			b.removeEventListener(MouseEvent.MOUSE_DOWN, __onBtnPressed);
			b.removeEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onFocusKeyDown);
			b.removeEventListener(Event.REMOVED_FROM_STAGE, __onBtnRemovedFromStage);
		}
		
		override public function paint(c:Component, g:Graphics2D, b:IntRectangle):void
		{
			super.paint(c, g, b);
			layoutCombobox();
			dropDownButton.setEnabled(button.isEnabled());
		}
		
		override protected function paintBackGround(c:Component, g:Graphics2D, b:IntRectangle):void
		{
			//do nothing, background decorator will paint it
		}
		
		/**
		 * Just override this method if you want other LAF drop down buttons.
		 */
		protected function createDropDownButton():Component
		{
			//var btn:JButton = new JButton("", new ArrowIcon(Math.PI / 2, 16));
			var btn:JButton = new JButton("", new SkinButtonIcon(-1, -1, "ScrollBar.arrowDown.", button));
			//btn.setIcon(null);
			btn.setFocusable(false);
			//btn.setPreferredSize(new IntDimension(16, 16));
			btn.setBackgroundDecorator(null);
			btn.setMargin(new Insets());
			btn.setBorder(null);
			//make it proxy to the combobox
			btn.setMideground(null);
			btn.setStyleTune(null);
			return btn;
		}
		
		/*protected function getScollPane():JScrollPane
		   {
		   if (scollPane == null)
		   {
		   scollPane = new JScrollPane(getPopupList());
		   //scollPane.setBorder(getBorder(getPropertyPrefix()+"popupBorder"));
		   scollPane.setOpaque(false);
		   scollPane.setStyleProxy(btn);
		   scollPane.setBackground(null);
		   scollPane.setStyleTune(null);
		   scollPane.setBackgroundDecorator(new ColorBackgroundDecorator(new ASColor(0x000000, 0)));
		   }
		   return scollPane;
		 }*/
		
		protected function getPopup():JPopup
		{
			if (popup == null)
			{
				/*popup = new JPopup(btn.root, false);
				   popup.setLayout(new BorderLayout());
				   popup.append(getScollPane(), BorderLayout.CENTER);
				   popup.buttonMode = true;
				   //popup.setAlpha(0.5);
				   //popup.setClipMasked(false);
				 popup.setBackgroundDecorator(new ColorBackgroundDecorator(new ASColor(0x000000, 0.14), new ASColor(0XFFFFFF, 0), 4));*/
				popup = (button as JDropDownButton).getPopup();
			}
			return popup;
		}
		
		protected function viewPopup():void
		{
			if (!button.isOnStage())
			{
				return;
			}
			
			getPopup().changeOwner(AsWingUtils.getOwnerAncestor(button));
			getPopup().show();
			
			//gtrace("getPopup() " + getPopup().getSize() + " " + getPopup().isOnStage());
			
			startMoveToView();
			AsWingManager.callLater(__addMouseDownListenerToStage);
		}
		
		private function __addMouseDownListenerToStage():void
		{
			if (getPopup().isVisible() && button.stage)
			{
				button.stage.addEventListener(MouseEvent.MOUSE_DOWN, __onMouseDownWhenPopuped, false, 0, true);
			}
		}
		
		private function hidePopup():void
		{
			if (button.stage)
			{
				button.stage.removeEventListener(MouseEvent.MOUSE_DOWN, __onMouseDownWhenPopuped);
			}
			popupTimer.stop();
			if (getPopup().isVisible())
			{
				getPopup().setVisible(false);
					//getPopup().dispose();
			}
		}
		
		private var scrollRect:Rectangle;
		
		//return the destination pos
		private function startMoveToView():void
		{
			var popupPane:JPopup = getPopup();
			var height:int = popupPane.getHeight();
			var popupPaneHeight:int = height;
			var downDest:IntPoint = button.componentToGlobal(new IntPoint(0, button.getHeight()));
			var upDest:IntPoint = new IntPoint(downDest.x, downDest.y - button.getHeight() - popupPaneHeight);
			var visibleBounds:IntRectangle = AsWingUtils.getVisibleMaximizedBounds(popupPane.parent);
			var distToBottom:int = visibleBounds.y + visibleBounds.height - downDest.y - popupPaneHeight;
			var distToTop:int = upDest.y - visibleBounds.y;
			
			var gp:IntPoint = button.getGlobalLocation();
			var popupGap:int = (button as JDropDownButton).getPopupGap();
			var popupOffset:int = (button as JDropDownButton).getPopupOffset();
			
			scrollRect = new Rectangle( /*0, height, popupPane.getWidth(), 0*/);
			
			
			if (distToBottom > 0 || (distToBottom < 0 && distToTop < 0 && distToBottom > distToTop))
			{
				moveDir = 1;
				//if((button as JDropDownButton).getPopupAlignment()
				scrollRect = new Rectangle( /*0, height, popupPane.getWidth(), 0*/);
				
				switch ((button as JDropDownButton).getPopupAlignment())
				{
					case AsWingConstants.RIGHT: 
						//gp.x = gp.x ;
						gp.x += popupOffset;
						break;
					case AsWingConstants.CENTER: 
						scrollRect = new Rectangle(0, 0, popupPane.getWidth(), 0);
						gp.y += popupGap + button.getHeight();
						gp.x += popupOffset;
						//gp.x = gp.x - popupPane.getWidth() * .5 + button.getWidth() * .5;
						//gp.y -= popupPane.getHeight();
						break;
					case AsWingConstants.LEFT: 
						gp.x = gp.x - popupPane.getWidth() + button.getWidth() + popupOffset;
						break;
					case AsWingConstants.BOTTOM: 
						scrollRect = new Rectangle(0, 0, popupPane.getWidth()*2, 0);
						gp.x -= popupPane.getWidth()*.5-button.getWidth()*.5 + popupOffset; // выравниване по левому краю
						gp.y += popupGap + button.getHeight();
						
						
						
						
						//gp.y += gp.y - popupPane.getHeight() /*+ 20*/;
						break;
				}
				
				//gp.y += /*button.getHeight() - 10 */- popupPane.getHeight()-popupGap/*-button.getHeight() *.5*/;
				//gp.x += popupGap;
					//scrollRect = new Rectangle(0, height, 0, 0);
					//scrollRect = new Rectangle(0, height, popupPane.getWidth(), 0);
			}
			else
			{
				moveDir = -1;
					//scrollRect = new Rectangle(0, 0, popupPane.getWidth(), 0);
			}
			
			/*scrollRect.y += popupGap;
			gp.y += popupGap;*/
			//gp.y +=popupGap+button.getHeight();
			gp.y +=popupGap+button.getHeight()-98;
			gp.x -= 100;
			
			popupPane.setGlobalLocation(gp);
			
			
			
			popupPane.scrollRect = scrollRect;
			
			
			//popupPane.setLocation(new IntPoint(100, 200));
			//scrollRect.width = 0;
			
			//popupTimer.restart();
			popupTimer.start();
		}
		
		//-----------------------------
		
		protected function __movePopup(e:Event):void
		{
			var popupPane:JPopup = getPopup();
			
			/*switch ((button as JDropDownButton).getPopupAlignment())
			{
				case AsWingConstants.RIGHT: 
					scrollRect.width += speed;
					break;
				case AsWingConstants.CENTER: 
					//popupPane.x = speed*2;
					popupPane.y += speed;
					scrollRect.height += speed;
					//scrollRect.width += speed*2;
					break;
				case AsWingConstants.LEFT: 
					scrollRect.width += speed;
					break;
				case AsWingConstants.BOTTOM: 
					popupPane.x -= speed * 2;
					popupPane.y += speed * .01;
					scrollRect.height += speed;
					scrollRect.width += speed * 2;
					break;
			}*/
			
			//scrollRect.width = popupPane.getWidth();
			var popupPaneWidth:int = popupPane.getWidth();
			var popupPaneHeight:int = popupPane.getHeight();
			var maxTime:int = 10;
			var minTime:int = 3;
			var speed:int = 50;
			
			scrollRect.width = popupPaneWidth;
			
			switch ((button as JDropDownButton).getPopupAlignment())
			{
				case AsWingConstants.RIGHT: 
				case AsWingConstants.LEFT: 
					if (popupPaneWidth < speed * minTime)
					{
						speed = Math.ceil(popupPaneWidth / minTime);
					}
					else if (popupPaneWidth > speed * maxTime)
					{
						speed = Math.ceil(popupPaneWidth / maxTime);
					}
					
					if (popupPane.width - scrollRect.width <= speed)
					{
						//motion ending
						speed = popupPane.width - scrollRect.width;
						popupTimer.stop();
					}
					
					break;
				case AsWingConstants.CENTER: 
					if (popupPaneHeight < speed * minTime)
					{
						speed = Math.ceil(popupPaneHeight / minTime);
					}
					else if (popupPaneHeight > speed * maxTime)
					{
						speed = Math.ceil(popupPaneHeight / maxTime);
					}
					
					if (popupPaneHeight - scrollRect.height <= speed)
					{
						//motion ending
						speed = popupPaneHeight - scrollRect.height;
						popupTimer.stop();
					}
					//case AsWingConstants.LEFT: 
					break;
			}
			
			/*if (popupPaneWidth < speed * minTime)
			   {
			   speed = Math.ceil(popupPaneWidth / minTime);
			   }
			   else if (popupPaneWidth > speed * maxTime)
			   {
			   speed = Math.ceil(popupPaneWidth / maxTime);
			   }
			
			   if (popupPane.width - scrollRect.width<= speed)
			   {
			   //motion ending
			   speed = popupPane.width - scrollRect.width;
			   popupTimer.stop();
			   }
			 */ /*if (moveDir > 0)
			   {
			   scrollRect.x -= speed;
			   scrollRect.width += speed;
			   }
			   else
			 {*/
			//popupPane.x -= speed;
			
			switch ((button as JDropDownButton).getPopupAlignment())
			{
				case AsWingConstants.RIGHT: 
					scrollRect.width += speed;
					break;
				case AsWingConstants.CENTER: 
					//popupPane.x = speed*2;
					popupPane.y += speed*2;
					scrollRect.height += speed;
					//scrollRect.width += speed*2;
					break;
				case AsWingConstants.LEFT: 
					scrollRect.width += speed;
					break;
				case AsWingConstants.BOTTOM: 
					//popupPane.x -= speed * 2;
					popupPane.y += speed * .01;
					scrollRect.height += speed;
					scrollRect.width += speed * 2;
					break;
			}
			
			//scrollRect.height += speed;
			//}
			popupPane.scrollRect = scrollRect;
		}
		
		protected function __movePopup2(e:Event):void
		{
			var popupPane:JPopup = getPopup();
			var popupPaneHeight:int = popupPane.getHeight();
			var maxTime:int = 10;
			var minTime:int = 3;
			var speed:int = 50;
			if (popupPaneHeight < speed * minTime)
			{
				speed = Math.ceil(popupPaneHeight / minTime);
			}
			else if (popupPaneHeight > speed * maxTime)
			{
				speed = Math.ceil(popupPaneHeight / maxTime);
			}
			if (popupPane.height - scrollRect.height <= speed)
			{
				//motion ending
				speed = popupPane.height - scrollRect.height;
				popupTimer.stop();
			}
			if (moveDir > 0)
			{
				scrollRect.y -= speed;
				scrollRect.height += speed;
			}
			else
			{
				popupPane.y -= speed;
				scrollRect.height += speed;
			}
			popupPane.scrollRect = scrollRect;
		}
		
		protected function __onBtnRemovedFromStage(e:Event):void
		{
			hidePopup();
		}
		
		protected function __onBtnPressed(e:Event):void
		{
			if (!isPopupVisible(button as JDropDownButton))
			{
				setPopupVisible(button as JDropDownButton, true);
			}
			else
			{
				hidePopup();
			}
		}
		
		protected function __onMouseDownWhenPopuped(e:Event):void
		{
			if (!getPopup().hitTestMouse() && !button.hitTestMouse())
			{
				hidePopup();
			}
		}
		
		/**
		 * Set the visiblity of the popup
		 */
		public function setPopupVisible(c:JDropDownButton, v:Boolean):void
		{
			if (v)
			{
				viewPopup();
			}
			else
			{
				hidePopup();
			}
		}
		
		/**
		 * Determine the visibility of the popup
		 */
		public function isPopupVisible(c:JDropDownButton):Boolean
		{
			return getPopup().isVisible();
		}
		
		//---------------------Layout Implementation---------------------------
		protected function layoutCombobox():void
		{
			var td:IntDimension = button.getSize();
			var insets:Insets = button.getInsets();
			var top:int = insets.top;
			var left:int = insets.left;
			var right:int = td.width - insets.right;
			
			var height:int = td.height - insets.top - insets.bottom;
			//button.setLocationXY(0, 0);
			
			//var buttonSize:IntDimension = dropDownButton.getPreferredSize();
			var buttonSize:IntDimension = dropDownButton.getPreferredSize();
			dropDownButton.setSizeWH(8/*buttonSize.width*/, height);
			//dropDownButton.setLocationXY(left - buttonSize.width, top);
		
			//dropDownButton.setLocationXY(td.width * .5 + 8/* + buttonSize.width*/, top);
			dropDownButton.setLocationXY(0/* + buttonSize.width*/, top);
		}
		
		override public function getPreferredSize(c:Component):IntDimension
		{
			/*var insets:Insets = c.getInsets();
			   //var popupPreferSize:IntDimension = getPopup().getPreferredSize();
			   //var ew:int = popupPreferSize.width;
			   //var wh:int = btn.getEditor().getEditorComponent().getPreferredSize().height;
			   var buttonSize:IntDimension = getPopup().getPreferredSize();
			 buttonSize.width +=dropDownButton.getPreferredWidth();*/
			//buttonSize.width += ew;
			
			//buttonSize.width += c.getPreferredWidth();
			/*if (wh > buttonSize.height)
			 *
			 *
			   {
			   buttonSize.height = wh;
			 }*/
			
			var insets:Insets = button.getInsets();
			var buttonSize:IntDimension = dropDownButton.getPreferredSize();
			//buttonSize.width = 8;
			//buttonSize.x = 
			//var wh:int = box.getEditor().getEditorComponent().getPreferredSize().height;
			var wh:int = 22;
			
			if (wh > buttonSize.height)
			{
				buttonSize.height = wh;
			}
			return insets.getOutsideSize(buttonSize);
		
			//return insets.getOutsideSize(buttonSize);
		}
		
		override public function getMinimumSize(c:Component):IntDimension
		{
			return button.getInsets().getOutsideSize(dropDownButton.getPreferredSize());
		}
		
		override public function getMaximumSize(c:Component):IntDimension
		{
			return IntDimension.createBigDimension();
		}
		
		public function getDropDownButton():Component
		{
			return dropDownButton;
		}
		
		public function getArrowIconVisible():Boolean 
		{
			return (getDropDownButton() as JButton).getIcon()==null;
		}
		
		public function setArrowIconVisible(v:Boolean):void 
		{
			if(v)
			(getDropDownButton() as JButton).setIcon(new SkinButtonIcon( -1, -1, "ScrollBar.arrowDown.", button));
			else{
			(getDropDownButton() as JButton).setIcon(null);
			//(getDropDownButton() as JButton).setVisible(false);
			//(getDropDownButton() as JButton).getParent().revalidate();
			}
		}
	}
}