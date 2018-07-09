package devoron.components.buttons
{
	import devoron.data.core.base.IDataContainer;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.decorators.ColorDecorator;
	import org.aswing.event.AWEvent;
	import org.aswing.ext.Form;
	import org.aswing.ext.FormRow;
	import org.aswing.JPanel;
	import org.aswing.JSeparator;
	import org.aswing.util.HashMap;
	
	/**
	 * DropDownButtonGroup
	 * @author Devoron
	 */
	public class DropDownButtonGroup extends Form
	{
		private var buttons:HashMap;
		private var stateChangeListener:Function;
		private var closeListener:Function;
		private var defaultVisible:Boolean;
		private var containersData:Array;
		
		public function DropDownButtonGroup(defaultVisible:Boolean = false)
		{
			this.defaultVisible = defaultVisible;
			buttons = new HashMap();
			containersData = [];
		}
		
		public function showContainer(dataName:String):void
		{
			var behaviorDDB:DropDownButton = buttons.get(dataName);
			(behaviorDDB.getParent().getParent()).setVisible(true);
			behaviorDDB.setSelected(false);
			behaviorDDB.hideRelatedFormRow();
			behaviorDDB.setCheckboxSelected(true);
		}
		
		public function hideContainer(dataName:String):void
		{
			var behaviorDDB:DropDownButton = buttons.get(dataName);
			(behaviorDDB.getParent().getParent()).setVisible(false);
			behaviorDDB.setSelected(false);
			behaviorDDB.hideRelatedFormRow();
			behaviorDDB.setCheckboxSelected(true);
		}
		
		public function getData():Array
		{
			return containersData /*(super.getModel() as DefaultTableModel).getData()*/;
		}
		
		public function setData(data:Array):void
		{
			containersData = data;
			//(super.getModel() as DefaultTableModel).setData(data);
		}
		
		public function addActionListener(listener:Function):void
		{
			super.addEventListener(AWEvent.ACT, listener);
		}
		
		public function removeActionListener(listener:Function):void
		{
			super.removeEventListener(AWEvent.ACT, listener);
		}
		
		/**
		 * Добавляет слушатель выбора внутреннего чекбокса для всех кнопок в группе.
		 * @param	listener
		 */
		public function addStateChangeListener(listener:Function):void
		{
			stateChangeListener = listener;
			var buttonNames:Array = buttons.keys();
			for each (var btnName:String in buttonNames)
				buttons.get(btnName).addCheckboxActionListener(listener);
		}
		
		/**
		 * Удаляет слушатель выбора внутреннего чекбокса для всех кнопок в группе.
		 * @param	listener
		 */
		public function removeStateChangeListener(listener:Function):void
		{
			stateChangeListener = null;
			var buttonNames:Array = buttons.keys();
			for each (var btnName:String in buttonNames)
				buttons.get(btnName).removeCheckboxActionListener(listener);
		}
		
		/**
		 * Добавляет слушатель нажатия на внутреннюю кнопку закрытия для всех кнопок в группе.
		 * @param	listener
		 */
		public function addCloseListener(listener:Function):void
		{
			stateChangeListener = listener;
			var buttonNames:Array = buttons.keys();
			for each (var btnName:String in buttonNames)
				buttons.get(btnName).addCloseButtonActionListener(listener);
		}
		
		/**
		 * Удаляет слушатель нажатия на внутреннюю кнопку закрытия для всех кнопок в группе.
		 * @param	listener
		 */
		public function removeCloseListener(listener:Function):void
		{
			stateChangeListener = null;
			var buttonNames:Array = buttons.keys();
			for each (var btnName:String in buttonNames)
				buttons.get(btnName).removeCloseButtonActionListener(listener);
		}
		
		public function appendButton(title:String, comp:Component):void
		{
			
			var containerFR:FormRow = super.addLeftHoldRow(0, comp);
			// создать и добавить разворачивающуюся кнопку до ряда с контейнером данных поведения
			var behaviorDDB:DropDownButton = new DropDownButton(title, containerFR, true, true);
			//var behaviorDDBFR:FormRow = super.addLeftHoldRow(0, [0, 10], behaviorDDB);
			
			/*var p:Form = new Form();
			var spr:JSeparator = new JSeparator(JSeparator.HORIZONTAL);
			spr.setBackground(new ASColor(0xFFFFFF, 0.24));
			spr.setPreferredWidth(200);
			p.addCenterHoldRow(0, spr);
			p.addLeftHoldRow(0, behaviorDDB);
			var spr2:JSeparator = new JSeparator(JSeparator.HORIZONTAL);
			spr2.setBackground(new ASColor(0xFFFFFF, 0.24));
			spr2.setPreferredWidth(200);
			p.addCenterHoldRow(0, spr2);
			p.pack();*/
			
			//var behaviorDDBFR:FormRow = super.addLeftHoldRow(0, /*[0, 10],*/ behaviorDDB);
			var behaviorDDBFR:FormRow = super.addLeftHoldRow(0, /*[0, 10],*/ behaviorDDB);
			//behaviorDDBFR.setBackgroundDecorator(new ColorDecorator(new ASColor(0xFFFFFF, 0.14)));
			buttons.put(title, behaviorDDB);
			super.insert(super.getIndex(containerFR), behaviorDDBFR);
			behaviorDDBFR.setVisible(defaultVisible);
			containerFR.setVisible(defaultVisible);
			//behaviorDDBFR.setVisible(false);
			
			// слушатель на чекбокс - добавить или удалить поведение
			if (stateChangeListener != null)
				behaviorDDB.addCheckboxActionListener(stateChangeListener);
			
			// слушатель на внутреннюю кнопку закрытия - скрыть ряд с кнопкой и форму, восстановить пункт в комбобоксе
			if (closeListener != null)
				behaviorDDB.addCloseButtonActionListener(closeListener);
		}
		
		public function removeButton(title:String):void
		{
		
		}
	
	}

}