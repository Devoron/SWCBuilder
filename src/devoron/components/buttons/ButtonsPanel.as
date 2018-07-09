package devoron.components.buttons
{
	import org.aswing.AbstractButton;
	import org.aswing.ButtonGroup;
	import org.aswing.Component;
	import org.aswing.Container;
	import org.aswing.event.AWEvent;
	import org.aswing.Icon;
	import org.aswing.JPanel;
	import org.aswing.layout.FlowLayout;
	import org.aswing.util.HashMap;
	
	/**
	 * ButtonsPanel
	 * @author Devoron
	 */
	public class ButtonsPanel extends JPanel
	{
		private var buttonsGroup:ButtonGroup;
		private var buttonsGroupMode:Boolean;
		private var buttonsFactory:ButtonsFactory;
		protected var keysAndButtons:HashMap;
		protected var buttonsAndKeys:HashMap;
		
		public function ButtonsPanel()
		{
			super(new FlowLayout(FlowLayout.LEFT, 0, 5));
			//setFactory(new ButtonsFactory(DSLabelButton));
			setFactory(new ButtonsFactory(DSStateLabelButton));
			setButtonGroupMode(false);
			keysAndButtons = new HashMap();
			buttonsAndKeys = new HashMap();
		}
		
		public function setButtonGroupMode(b:Boolean):void
		{
			buttonsGroupMode = b;
		}
		
				
		public function addElement(key:String, text:String="", icon:Icon=null, listener:Function = null, mComponent:Component = null, additionalMenu:Container = null):AbstractButton
		{
			//for (var i:int = 0; i < 9; i++)
			//{
			//var btn1:AbstractButton = createButton2();
			var btn1:AbstractButton = buttonsFactory.getNewButton();
			//btn1.setToolTipText(text);
			btn1.setIcon(icon);
			btn1.setText(text);
			btn1.setPreferredWidth(200);
			btn1.setPreferredHeight(20);
			
			keysAndButtons.put(key, btn1);
			buttonsAndKeys.put(btn1, key);
			
			//btn1.addActionListener(onHu9);
			///*buttonsPanel.*/addChild(btn1);
			//btn1.x = 5;
			//btn1.x = 2;
			//btn1.y = 20 + 67 * i + 10 * i;
			//btn1.y = 20 + 67 * (buttonsPanel.numChildren) + 2 * buttonsPanel.numChildren;
			
			super.append(btn1);
			
			if(buttonsGroupMode)
			buttonsGroup.append(btn1);
			
			if (additionalMenu)
			{
				//var hui:JPanel = new JPanel(new BorderLayout());
				
				//hui.setPreferredWidth(200);
				//hui.append(btn1, BorderLayout.WEST);
				//hui.append(additionalMenu, BorderLayout.EAST);
				
				//controlPanel.append(hui);
				
				/*var advProp:ASFontAdvProperties = new ASFontAdvProperties(true, "advanced", "subpixel");
				//var font2:ASFont = new ASFont("GT Walsheim Pro", 11, true, false, false, advProp);
				var font2:ASFont = new ASFont("Gilroy Light", 12, true, false, false, advProp);
				font2 = font2.changeBold(true);
				var lb:JLabel = new JLabel(m.getText(), null, JLabel.LEFT);
				lb.setForeground(new ASColor(0x5a868f, 1));
				lb.setFont(font2);
				lb.setBorder(new EmptyBorder(null, new Insets(10, 2)));
				//setPreferredHeight(18);
				//setMaximumHeight(18);
				
				var pan2:JPanel = new JPanel(new BorderLayout(0, 0));
				pan2.append(lb, BorderLayout.NORTH);
				pan2.append(additionalMenu, BorderLayout.SOUTH);
				
				var hui:Form = new Form();
				hui.addLeftHoldRow(0, btn1, pan2);*/
				
				//(controlPanel as Form).addLeftHoldRow(0, 5, hui);
					//(controlPanel as Form).addLeftHoldRow(0, 5, [0,5]);
			}
			else
			{
				//controlPanel.append(btn1);
				//(controlPanel as Form).addLeftHoldRow(0, 5, btn1);
			}
			return btn1;
		}
		
		public function useButtonGroup(b:Boolean):void {
			buttonsGroupMode = b;
		}
		
		public function addActionListener(listener:Function):void
		{
			if(buttonsGroupMode)
			buttonsGroup.addEventListener(AWEvent.ACT, listener);
			else
			throw new Error("Используйте отдельные слушатели для компонентов ButtonPanel или переведите панель в режим useButtonGroup=true");
		}
		
		public function removeActionListener(listener:Function):void
		{
			buttonsGroup.removeEventListener(AWEvent.ACT, listener);
		}
		
		public function setFactory(buttonsFactory:ButtonsFactory):void
		{
		this.buttonsFactory = buttonsFactory;
		
		}
		
		public function setHGap(value:uint):void
		{
		
		}
		
		public function setVGap(value:uint):void
		{
		
		}
		
		public function setOrientation(type:String):void
		{
		
		}
	
	}

}