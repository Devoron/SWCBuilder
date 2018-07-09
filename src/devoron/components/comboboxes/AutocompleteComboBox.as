package devoron.components.comboboxes
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import org.aswing.ASColor;
	import org.aswing.decorators.SideLineDecorator;
	import org.aswing.geom.IntDimension;
	import org.aswing.JComboBox;
	import org.aswing.JTextField;
	import org.aswing.plaf.basic.BasicComboBoxUI;
	import org.aswing.util.autocomplete.AutocompleteDictionary;
	import org.aswing.util.autocomplete.AutocompleteManager;
	import org.aswing.VectorListModel;
	
	/**
	 * AutocompleteComboBox
	 * @author Devoron
	 */
	public class AutocompleteComboBox extends DSComboBox
	{
		private var pathTF:JTextField;
		private var acbe:AutocompleteComboBoxEditor;
		
		public function AutocompleteComboBox(listData:* = null)
		{
			/*acb = new GrayCB(listData);
			   acb.setEditable(true);
			   acb.setPreferredSize(new IntDimension(140, 22));
			   acb.setSize(new IntDimension(140, 22));
			 acb.setMaximumRowCount(7);*/
			//setPreferredHeight(24);
			setPreferredSize(new IntDimension(300, 26));
			
			acbe = new AutocompleteComboBoxEditor();
			setEditor(acbe);
			setEditable(true);
			
			pathTF = (acbe.getEditorComponent() as JTextField);
			pathTF.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			var sld:SideLineDecorator = new SideLineDecorator(new ASColor(0, 0), new ASColor(0xFFFFFF, 0.4), new ASColor(0xFFFFFF, 0), 0, SideLineDecorator.SOUTH);
			sld.setGaps(0, 0, 0, -1);
			pathTF.setBackgroundDecorator(sld);
			//acb.setBorder(new SideLineBorder(null, SideLineBorder.SOUTH, new ASColor(0xFFFFFF, 0.24), 0.4));
			pathTF.setBorder(null);
			
			setBackgroundDecorator(null);
			var dict:AutocompleteDictionary = new AutocompleteDictionary();
			var arr:Array = listData;
			if (arr)
			{
				for (var i:int = 0; i < arr.length; i++)
				{
					dict.addToDictionary(arr[i]);
				}
			}
			setListData(arr);
			
			/*dict.addToDictionary("нога");
			   dict.addToDictionary("ножницы");
			   dict.addToDictionary("рука");
			 dict.addToDictionary("ручник");*/
			
			var autocompleteManager:AutocompleteManager = new AutocompleteManager(pathTF);
			autocompleteManager.setDictionary(dict);
		
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			var acb:JComboBox = this;
			if (e.keyCode == Keyboard.DOWN || e.keyCode == Keyboard.UP || e.keyCode == Keyboard.ENTER)
			{
				if (e.keyCode == Keyboard.ENTER)
				{
					pathTF.setSelection(0, 0);
				}
				
				return;
			}
			
			var text:String = pathTF.getText();
			var bcbUI:BasicComboBoxUI = (acb.getUI() as BasicComboBoxUI);
			var arr:Array = (acb.getModel() as VectorListModel).toArray();
			//acb.setListData(arr);
			
			if (text.length == 0)
			{
				if (bcbUI.isPopupVisible(acb))
					bcbUI.setPopupVisible(acb, false);
				return;
			}
			
			if (text !== "")
			{
				var filteredArr:Array = [];
				
				for (var i:int = 0; i < arr.length; i++)
				{
					if ((arr[i] as String).indexOf(text) != -1)
					{
						filteredArr.push(arr[i]);
					}
				}
				acb.setListData(filteredArr);
			}
			
			acb.revalidate();
			
			//acb.updateUI();
			
			if (!bcbUI.isPopupVisible(acb))
				bcbUI.setPopupVisible(acb, true);
			//acb.getPopupList().repaint();
		}
	
	}

}