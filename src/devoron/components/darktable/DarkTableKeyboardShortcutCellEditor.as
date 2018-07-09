package devoron.components.darktable
{
	import flash.events.KeyboardEvent;
	import flash.utils.describeType;
	import org.aswing.ASColor;
	import org.aswing.DefaultTextFieldCellEditor;
	import org.aswing.event.CellEditorListener;
	import org.aswing.geom.IntPoint;
	import org.aswing.geom.IntRectangle;
	import org.aswing.Container;
	import org.aswing.JTextField;
	import org.aswing.KeySequence;
	import org.aswing.KeyStroke;
	import org.aswing.KeyType;
	import org.aswing.table.TableCellEditor;
	
	/**
	 * DarkTableKeyboardShortcutCellEditor
	 * @author Devoron
	 */
	public class DarkTableKeyboardShortcutCellEditor extends DefaultTextFieldCellEditor
	{
		private var keySequence:KeySequence;
		
		public function DarkTableKeyboardShortcutCellEditor()
		{
			//super.setBackground(new ASColo
			//super.setText("Ояебу");
		}
		
		override public function startCellEditing(owner:Container, value:*, bounds:IntRectangle):void
		{
			bounds.y -= 1;
			bounds.height += 2;
			super.startCellEditing(owner, value, bounds);
		}
		
		override public function getCellEditorValue():*
		{
			//return super.getCellEditorValue();
			return keySequence;
		}
		
		override public function stopCellEditing():Boolean
		{
			return super.stopCellEditing();
		}
		
		/**
		 * Sets the value of this cell.
		 * @param value the new value of this cell
		 */
		override protected function setCellEditorValue(value:*):void
		{
			getTextField().setText((value as KeyType).getDescription() + "");
			getTextField().selectAll();
		}
		
		override public function getTextField():JTextField
		{
			if (textField == null)
			{
				textField = new JTextField();
				
				textField.setEditable(false);
				textField.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 32, false);
				//textField.setBackground(new ASColor(0x040404, 0.8));
				textField.setBackground(new ASColor(0x000000, 0.08));
				textField.setRestrict(getRestrict());
			}
			return textField;
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			textField.setText("");
			
			var keystrokes:Array = new Array();
			
			if (keySequence)
			{
				var codes:Array = keySequence.getCodeSequence();
				for each (var code:uint in codes)
				{
					keystrokes.push(KeyStroke.getKeyStrokeByKeyCode(code));
				}
			}
			
			var currentKeyStroke:KeyStroke = KeyStroke.getKeyStrokeByKeyCode(e.keyCode);
			var unical:Boolean = true;
			
			gtrace(currentKeyStroke);
			// проверить на повторения
			if (currentKeyStroke == null) {
			throw new Error("Ояебу");	
			}
			for each (var keyStroke:KeyStroke in keystrokes)
			{
				if (keyStroke.getCode() == currentKeyStroke.getCode())
				{
					unical = false;
					break;
				}
			}
			
			if(unical) keystrokes.push(currentKeyStroke);
			
			keySequence = new KeySequence(keystrokes);
			
			textField.setText(keySequence.getDescription());
		}
	
	}

}