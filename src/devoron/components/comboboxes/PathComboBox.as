package devoron.components.comboboxes 
{
	import flash.events.TextEvent;
	import org.aswing.border.SideLineBorder;
	import org.aswing.JTextField;
	/**
	 * ...
	 * @author Devoron
	 */
	public class PathComboBox extends DSComboBox
	{
		private var pathTF:JTextField;
		
		public function PathComboBox() 
		{
			super(["asdasjhdKAJ", "SADHASJHDK", "SAJKDASLJDAJ", "JDKSAJDA"]);
			setBackgroundDecorator(null);
			pathCB.setEditable(true);
			setPreferredWidth(375);
			getPopupList().setBorder(new EmptyBorder(null, new Insets(2, 3, 4, 3)));
			getPopupList().setCellFactory(new GeneralListCellFactory(CellFact, true, true, 20));
			setUI(new TextCBUI());
			//var bc:ColorDecorator = new ColorDecorator(new ASColor(0, 0), new ASColor(0xFFFFFF, 0.04));
			//bc.setGaps(0, 0, -2, 3);
			//pathCB.setBackgroundDecorator(bc);
			setBackgroundDecorator(null);
			
			var acbe:AutocompleteComboBoxEditor = new AutocompleteComboBoxEditor();
			setEditor(acbe);
			
			pathTF = (acbe.getEditorComponent() as JTextField);
			pathTF.addEventListener(TextEvent.LINK, linkEvent);
			pathTF.addActionListener(onPathChange);
			pathTF.setBackgroundDecorator(null);
			pathTF.setBorder(new SideLineBorder(null, SideLineBorder.SOUTH, new ASColor(0xFFFFFF, 0.24), 0.4));
			//pathTF.addEventListener(KeyboardEvent.KEY_UP, pathTFKeyDownHandler);
			autocompleteManager = new AutocompleteManager(pathTF, pathCB);
		}
		
	}

}