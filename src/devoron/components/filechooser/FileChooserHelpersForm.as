package devoron.components.filechooser
{
	import devoron.components.checkboxes.DSCheckBox;
	import org.aswing.ASColor;
	import org.aswing.border.EmptyBorder;
	import org.aswing.border.LineBorder;
	import org.aswing.decorators.ColorDecorator;
	import org.aswing.event.AWEvent;
	import org.aswing.ext.Form;
	import org.aswing.geom.IntDimension;
	import org.aswing.Insets;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.JPopup;
	import org.aswing.JScrollPane;
	
	/**
	 * FileChooserHelpersForm
	 * @author Devoron
	 */
	public class FileChooserHelpersForm extends JPopup
	{
		private var fchsTableModel:FileChooserHelpersTableModel;
		private var fchsTable:FileChooserHelpersTable;
		private var fchsTableSP:JScrollPane;
		private var selectAllChB:DSCheckBox;
		private var helpers:Array;
		
		public function FileChooserHelpersForm()
		{
			//setTitleBar(null);
			//setResizable(false);
			//setBorder(new LineBorder(null, new ASColor(0xFFFFFF, 0.4)));
			//setBackgroundDecorator(new ColorDecorator(new ASColor(0x262F2B, 1)));
			
			//setBackgroundDecorator(new ColorDecorator(new ASColor(0x000000, 0.14), new ASColor(0XFFFFFF, 0), 4));
			/*
			var cd:ColorDecorator = new ColorDecorator(new ASColor(0x262F2B, 1), new ASColor(0XFFFFFF, 0.24), 4);
			cd.setGaps(-2, 1, 1, -2);
			setBackgroundDecorator(cd);*/
			
			var id:ColorDecorator = new ColorDecorator(new ASColor(0x1C221F, 1), new ASColor(0XFFFFFF, 0.24), 4);
			//id.setGaps(-2, 1, 1, -2);
			id.setGaps(-1, 0, 0, -1);
			setBackgroundDecorator(id);
			
			/*setSize(new IntDimension(250, 200));
			   setPreferredSize(new IntDimension(250, 200));
			   setMaximumSize(new IntDimension(250, 200));
			 setMinimumSize(new IntDimension(250, 200));*/
			
			var modulForm:Form = new Form();
			modulForm.setBorder(new EmptyBorder(null, new Insets(2, 5, 2, 5)));
			//setContentPane(modulForm);
			append(modulForm);
			
			createFileChooserHelpersTable();
			var enabledAllChB:DSCheckBox = new DSCheckBox("use preview for selected types");
			//modulForm.addLeftHoldRow(0, enabledAllChB);
			//modulForm.addRightHoldRow(0, enabledAllChB, 18);
			
			selectAllChB = new DSCheckBox("select all");
			selectAllChB.addActionListener(selectAllChBHandler);
			modulForm.addLeftHoldRow(0, 4, enabledAllChB);
			modulForm.addLeftHoldRow(0, 4, selectAllChB);
			modulForm.addLeftHoldRow(0, fchsTableSP);
			pack();
		}
		
		private function selectAllChBHandler(e:AWEvent):void
		{
			var state:Boolean = selectAllChB.isSelected();
			for each (var helper:IFileChooserHelper in helpers)
				helper.setEnabled(state);
			fchsTableModel.setData(helpers);
		}
		
		public function registerHelpers(helpers:Array):void
		{
			this.helpers = helpers;
			fchsTableModel.setData(helpers);
		}
		
		public function registerHelper(helper:IFileChooserHelper):void
		{
			//var helpers:Array = fchsTableModel.getData();
			helpers.push(helper);
			fchsTableModel.setData(helpers);
		}
		
		private function createFileChooserHelpersTable():void
		{
			fchsTableModel = new FileChooserHelpersTableModel(null);
			fchsTable = new FileChooserHelpersTable(fchsTableModel);
			
			fchsTableSP = new JScrollPane(fchsTable);
			//fchsTableSP.setPreferredHeight(100);
			//fchsTableSP.setSize(new IntDimension(200, 100));
			//fchsTableSP.setMinimumSize(new IntDimension(200, 100));
			fchsTableSP.setPreferredSize(new IntDimension(240, 150));
			fchsTableSP.setVerticalScrollBarPolicy(JScrollPane.SCROLLBAR_ALWAYS);
			fchsTableSP.setHorizontalScrollBarPolicy(JScrollPane.SCROLLBAR_NEVER);
			fchsTableSP.buttonMode = true;
			//super.addLeftHoldRow(0, mobsListPane);	
		}
	
	}

}