package devoron.components.buttons 
{
	import org.aswing.AbstractButton;
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.ASFontAdvProperties;
	import org.aswing.border.EmptyBorder;
	import org.aswing.Component;
	import org.aswing.Container;
	import org.aswing.event.AWEvent;
	import org.aswing.ext.Form;
	import org.aswing.Icon;
	import org.aswing.Insets;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.layout.BorderLayout;
	import org.aswing.util.HashMap;
	/**
	 * ButtonsPanelExt
	 * @author Devoron
	 */
	public class ButtonsPanelExt extends ButtonsPanel
	{
		private var controlPanel:Container;
		private var keysAndTargets:HashMap;
		private var viewportContainer:Container;
		private var currentTarget:Component;
		
		public function ButtonsPanelExt() 
		{
			keysAndTargets = new HashMap();
			
			// дальше нужен обработчик нажатия
			// который вытащит связанный компонет по ключу кнопки
		}
		
		public function setVieportContainer(viewportContainer:Container):void {
			this.viewportContainer = viewportContainer;
		}
		
		public function bindView(key:String, target:Component):void {
			keysAndTargets.put(key, target);
		}
		
		public override function addElement(key:String, text:String="", icon:Icon=null, listener:Function = null, mComponent:Component = null, additionalMenu:Container = null):AbstractButton
		{
			var btn1:AbstractButton = super.addElement(key, text, icon, listener, mComponent, additionalMenu);
			bindView(key, mComponent);
			//super.addElement(text
			//for (var i:int = 0; i < 9; i++)
			//{
			/*var btn1:AbstractButton = createButton2();
			btn1.setToolTipText(m.getText());
			btn1.setIcon(m.getIcon());*/
			
			
			btn1.addActionListener(onHu9);
			///*buttonsPanel.*/addChild(btn1);
			//btn1.x = 5;
			//btn1.x = 2;
			//btn1.y = 20 + 67 * i + 10 * i;
			//btn1.y = 20 + 67 * (buttonsPanel.numChildren) + 2 * buttonsPanel.numChildren;
			//btnGR.append(btn1);
			return btn1;
			if (additionalMenu)
			{
				//var hui:JPanel = new JPanel(new BorderLayout());
				
				//hui.setPreferredWidth(200);
				//hui.append(btn1, BorderLayout.WEST);
				//hui.append(additionalMenu, BorderLayout.EAST);
				
				//controlPanel.append(hui);
				
				var advProp:ASFontAdvProperties = new ASFontAdvProperties(true, "advanced", "subpixel");
				//var font2:ASFont = new ASFont("GT Walsheim Pro", 11, true, false, false, advProp);
				var font2:ASFont = new ASFont("Gilroy Light", 12, true, false, false, advProp);
				font2 = font2.changeBold(true);
				//var lb:JLabel = new JLabel(m.getText(), null, JLabel.LEFT);
				var lb:JLabel = new JLabel(text, null, JLabel.LEFT);
				lb.setForeground(new ASColor(0x5a868f, 1));
				lb.setFont(font2);
				lb.setBorder(new EmptyBorder(null, new Insets(10, 2)));
				//setPreferredHeight(18);
				//setMaximumHeight(18);
				
				
				
				
				
				
				var pan2:JPanel = new JPanel(new BorderLayout(0, 0));
				pan2.append(lb, BorderLayout.NORTH);
				pan2.append(additionalMenu, BorderLayout.SOUTH);
				
				var hui:Form = new Form();
				hui.addLeftHoldRow(0, btn1, pan2);
				
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
		
		private function onHu9(e:AWEvent):void 
		{
			if (currentTarget) {
				viewportContainer.remove(currentTarget);
			}
			
			var key:String = buttonsAndKeys.get(e.currentTarget);
			//if(keysAndTargets.
			var target:Component = keysAndTargets.get(key);
			if (target) {
				viewportContainer.append(target);
				currentTarget = target;
			}
			viewportContainer.pack();
		}
		
	}

}