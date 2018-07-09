package devoron.dataui.multicontainers.table
{
	import devoron.components.buttons.DSTextField;
	import devoron.components.frames.StudioFrame;
	import devoron.dataui.multicontainers.gridlist.ContainerGridListCell;
	import org.aswing.ASColor;
	import org.aswing.AssetIcon;
	import org.aswing.border.EmptyBorder;
	import org.aswing.event.AWEvent;
	import org.aswing.ext.Form;
	import org.aswing.ext.GeneralGridListCellFactory;
	import org.aswing.ext.GridList;
	import org.aswing.ext.GridListItemEvent;
	import org.aswing.geom.IntDimension;
	import org.aswing.Icon;
	import org.aswing.Insets;
	import org.aswing.JButton;
	import org.aswing.JList;
	import org.aswing.JScrollPane;
	import org.aswing.JTextField;
	import org.aswing.VectorListModel;
	
	/**
	 * DataContainersForm
	 * @author Devoron
	 */
	public class DataContainersForm extends StudioFrame
	{
		
		[Embed(source="../../../../../assets/icons/commons/search_icon16.png")]
		private const SEARCH_ICON:Class;
		
		private var modulForm:Form;
		public var model:VectorListModel;
		public var containersGridList:GridList;
		private var containersGridListSP:JScrollPane;
		private var jls:JScrollPane;
		private var searchField:JTextField;
		
		public function DataContainersForm()
		{
			/*setMinimumSize(new IntDimension(400, 200));
			   setSize(new IntDimension(400, 200));
			 setPreferredSize(new IntDimension(400, 200));*/
			
			modulForm = new Form();
			setContentPane(modulForm);
			setDragEnabled(false);
			setResizable(false);
			setTitleBar(null);
			modulForm.setBorder(new EmptyBorder(null, new Insets(10, 10, 10, 10)));
			//modulForm.setBorder(new EmptyBorder(null, new Insets(5, 5, 10, 5)));
			pack();
			
			searchField = new DSTextField();
			
			searchField.setPreferredWidth(405);
			//searchField.addActionListener(searchBtnHandler);
			//searchField.setForeground(new ASColor(0xFFFFFF, 0.6));
			
			//var jp:JPanel = new JPanel(new BorderLayout());
			//jp.append(searchField, BorderLayout.EAST);
			
			var searchBtn:JButton = createButton("", new AssetIcon(new SEARCH_ICON), searchBtnHandler, "search");
			
			modulForm.addRightHoldRow(0, searchField, 2, searchBtn);
			
			var arr:Array = ["Base", "Photochromics", "Mechanochromics", "Chemochromics", "Electrochromics", "Liquid crystals", "Suspended particle", "Electrorheological", "Magnetorheological"];
			var arr2:Array = ["ColorMaterial", "TextureMaterial", "ShaderMaterial"];
			
			var jl:JList = new JList(arr);
			jl.setSelectionBackground(new ASColor(0x000000, 0.14));
			jl.setSelectionForeground(new ASColor(0XFFFFFF, 0.8));
			jl.setForeground(new ASColor(0XFFFFFF, 0.4));
			jls = new JScrollPane(jl, JScrollPane.SCROLLBAR_ALWAYS, JScrollPane.SCROLLBAR_NEVER);
			jls.setPreferredHeight(200);
			jls.setPreferredWidth(150);
			jls.setWidth(150);
			
			/*var jl2:JList = new JList(arr2);
			   var jls2:JScrollPane = new JScrollPane(jl2, JScrollPane.SCROLLBAR_ALWAYS, JScrollPane.SCROLLBAR_NEVER);
			   jls2.setPreferredHeight(200);
			   jls2.setPreferredWidth(280);
			 jls2.setWidth(280);*/
			
			model = new VectorListModel();
			containersGridList = new GridList(model, new GeneralGridListCellFactory(ContainerGridListCell), 4, 0);
			containersGridList.addEventListener(GridListItemEvent.ITEM_DOUBLE_CLICK, onItemDoubleClick);
			containersGridList.setTileWidth(64);
			containersGridList.setTileHeight(64);
			containersGridListSP = new JScrollPane(containersGridList, JScrollPane.SCROLLBAR_ALWAYS, JScrollPane.SCROLLBAR_NEVER);
			containersGridListSP.setPreferredSize(new IntDimension(280, 200));
			
			modulForm.addLeftHoldRow(0, jls, containersGridListSP);
			pack();
		}
		
		override public function setPreferredHeight(preferredHeight:int):void 
		{
			containersGridListSP.setPreferredHeight(preferredHeight);
			jls.setPreferredHeight(preferredHeight);
			//super.setPreferredWidth(preferredHeight);
		}
		
		override public function setPreferredWidth(preferredWidth:int):void 
		{
			searchField.setPreferredWidth(preferredWidth-20);
			containersGridListSP.setPreferredWidth(preferredWidth);
			//super.setPreferredWidth(preferredWidth);
		}
		
		private function onItemDoubleClick(e:GridListItemEvent):void
		{
			//gtrace("dsjfkdsjkfjsdkfjsdfjaldskjfdsklajfsd");
			setVisible(false);
		}
		
		private function searchBtnHandler(e:AWEvent):void
		{
		
		}
		
		protected function createButton(text:String, icon:Icon, listener:Function, tooltipText:String = ""):JButton
		{
			var btn:JButton = new JButton(text, icon);
			btn.setForeground(new ASColor(0xFFFFFF, 0.5));
			btn.setBackgroundDecorator(null);
			btn.addActionListener(listener);
			if (tooltipText != "")
				btn.setToolTipText(tooltipText);
			return btn;
		}
	
	}

}