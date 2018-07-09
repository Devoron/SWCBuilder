package devoron.components.comboboxes
{
	import devoron.components.buttons.DSTextField;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import org.aswing.border.EmptyBorder;
	import org.aswing.DefaultComboBoxEditor;
	import org.aswing.Insets;
	import org.aswing.JPathTextField;
	import org.aswing.JTextField;
	
	/**
	 * AutocompleteComboBoxEditor
	 * @author Devoron
	 */
	public class AutocompleteComboBoxEditor extends DefaultComboBoxEditor
	{
		
		public function AutocompleteComboBoxEditor()
		{
		}
		
		override protected function createTextField():JTextField
		{
			var tf:DSTextField = new DSTextField("");
			//var tf:JTextField = new JTextField("", 1);
			//tf.addEventListener(KeyboardEvent.KEY_DOWN, keyDownListener);
			//tf.setBorder(new EmptyBorder(null, new Insets(0, 3, 0, 0)));
			tf.setOpaque(false);
			tf.setFocusable(false);
			tf.setBackgroundDecorator(null);
			return tf;
		}
		
		private function keyDownListener(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.BACKSPACE || e.keyCode == Keyboard.DELETE)
			{
				//paused = true;
			}
			else
			{
				//paused = false;
			}
			if (e.keyCode == Keyboard.ENTER)
			{
				//pathCB
				
					//gtrace("enter");
					//complete();
					//suggestionActive = true;
					//var originalCaretIndex:int = _targetTextField.caretIndex;
				
					//_targetTextField.getTextField().caretIndex = 12;//_targetTextField.getSelectionEndIndex();
				/*var selId:int = _targetTextField.getSelectionEndIndex();
				 _targetTextField.setSelection(selId, selId);*/
			}
		}
	
	}

}