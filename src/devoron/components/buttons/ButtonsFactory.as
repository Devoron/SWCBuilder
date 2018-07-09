package devoron.components.buttons 
{
	import org.aswing.AbstractButton;
	/**
	 * ButtonsFactory
	 * @author Devoron
	 */
	public class ButtonsFactory 
	{
		private var buttonCls:Class;
		
		public function ButtonsFactory(buttonCls:Class) 
		{
			this.buttonCls = buttonCls;
			
		}
		
		public function getNewButton():AbstractButton {
			return new buttonCls;
		}
		
	}

}