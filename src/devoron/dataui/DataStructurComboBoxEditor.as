package devoron.dataui
{
	
	import org.aswing.DefaultComboBoxEditor;
	import org.aswing.DefaultListCell;
	
	public class DataStructurComboBoxEditor extends DefaultComboBoxEditor
	{
		
		public function DataStructurComboBoxEditor()
		{
			super();
		}
		
		override public function setValue(value:*):void
		{
			this.value = value;
			if (value == null)
			{
				getTextField().setText("");
			}
			else if (value is String)
			{
				getTextField().setText(value);
			}
			else
			{
				getTextField().setText(value.dataName);
			}
			valueText = getTextField().getText();
		}
	
	}
}