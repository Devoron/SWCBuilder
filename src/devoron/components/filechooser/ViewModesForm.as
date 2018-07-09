package devoron.components.filechooser
{
	import devoron.components.comboboxes.DSComboBox;
	import devoron.components.filechooser.contentviews.BaseFIsContentViewForm;
	import devoron.components.filechooser.contentviews.FIsTableForm;
	import devoron.components.filechooser.contentviews.IContentView;
	import devoron.components.frames.StudioFrame;
	import flash.events.Event;
	import org.aswing.ASColor;
	import org.aswing.border.EmptyBorder;
	import org.aswing.Component;
	import org.aswing.decorators.ColorDecorator;
	import org.aswing.event.AWEvent;
	import org.aswing.ext.Form;
	import org.aswing.Insets;
	import org.aswing.JPanel;
	import org.aswing.JPopup;
	import org.aswing.JScrollPane;
	import org.aswing.JSeparator;
	import org.aswing.JSp;
	import org.aswing.layout.FlowLayout;
	import org.aswing.util.HashMap;
	
	/**
	 * FileChooserHelpersForm
	 * @author Devoron
	 */
	public class ViewModesForm extends JPopup
	{
		private var fchsTableSP:JScrollPane;
		private var modesCB:DSComboBox;
		private var contentViewIconsPanel:JPanel;
		private var viewsHashMap:HashMap;
		private var viewComp:Component;
		private var contentViews:HashMap;
		private var contentView:IContentView;
		public var modulForm:Form;
		//private var selectionMode:
		
		public function ViewModesForm()
		{
			//setTitleBar(null);
			//setResizable(false);
			//setBorder(new LineBorder(null, new ASColor(0xFFFFFF, 0.4)));
			//setBackgroundDecorator(new ColorDecorator(new ASColor(0x262F2B, 1)));
			
			//setBackgroundDecorator(new ColorDecorator(new ASColor(0x000000, 0.14), new ASColor(0XFFFFFF, 0), 4));
		/*	var cd:ColorDecorator = new ColorDecorator(new ASColor(0x262F2B, 1), new ASColor(0XFFFFFF, 0.24), 4);
			cd.setGaps(-2, 1, 0, -1);
			setBackgroundDecorator(cd);*/
			//var id:ColorDecorator = new ColorDecorator(new ASColor(0x1C221F, 1), new ASColor(0XFFFFFF, 0.24), 4);
			//id.setGaps(-2, 1, 1, -2);
			//setBackgroundDecorator(id);
			
			var id:ColorDecorator = new ColorDecorator(StudioFrame.defaultColor, new ASColor(0XFFFFFF, 0.08), 4);
			//id.setGaps(-2, 1, 1, -2);
			id.setGaps(-1, 0, 0, -1);
			//id.setGaps(-1, 0, 0, 0);
			setBackgroundDecorator(id);
			StudioFrame.decorators.push(id);
			
			
			viewsHashMap = new HashMap();
			contentViews = new HashMap();
			
			/*setSize(new IntDimension(250, 200));
			   setPreferredSize(new IntDimension(250, 200));
			   setMaximumSize(new IntDimension(250, 200));
			 setMinimumSize(new IntDimension(250, 200));*/
			
			//var modulForm:Form = new Form(new VerticalCenterLayout());
			modulForm = new Form();
			modulForm.setBorder(new EmptyBorder(null, new Insets(0, 5, 0, 5)));
			//setContentPane(modulForm);
			append(modulForm);
			
			contentViewIconsPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 2, 0));
			//contentViewIconsPanel = new JPanel(new VerticalCenterLayout());
			//contentViewIconsPanel.setPreferredHeight(21);
			//modulForm.append(contentViewIconsPanel);
			
			
			modulForm.addRightHoldRow(0, contentViewIconsPanel);
			
			addContentViews([new FIsTableForm(),/* new FIsListForm(),*/ /*new FIsContentForm(), */ /*new FIsGridForm(),*/ /*,new FIsResizableIconsForm()*/]);
			pack();
		}
		
		public function clear():void {
			contentView.clear();
		}
		
		public function setSelectionMode(sm:int):void {
			
		}
		
		
		public function addContentView(cw:IContentView):void
		{
			/*var lb:JLabel = new JLabel("", cw.getIcon());
			lb.setToolTipText(cw.getName());
			contentViewIconsPanel.append(lb);
			contentViewIconsPanel.repaint();*/
		}
		
		/**
		 *
		 * @param	cws Array of IContentView.
		 */
		public function addContentViews(cws:Array):void
		{
			for (var i:int = 0; i < cws.length; i++)
			{
				// добавить вид в список типа, "List": FIsListForm.getViewFIComponent()
				viewsHashMap.put((cws[i] as IContentView).getName(), (cws[i]as IContentView).getViewFIComponent());
				
				contentViews.put((cws[i] as IContentView).getName(), cws[i]);
				
				//gtrace("(cws[i] as IContentView).getName() " + (cws[i] as IContentView).getName());
				(cws[i] as IContentView).addActionListener(selectContentViewListener);
				
				// если есть компоненты для отрисовки на панели кнопок, то добавить их
				if(contentViewIconsPanel.getComponentCount()>0){
					var spr:JSeparator = new JSeparator(JSeparator.VERTICAL);
					spr.setBackground(new ASColor(0XFFFFFF, 0.45));
					spr.setPreferredHeight(16);
					contentViewIconsPanel.append(new JSp(1));
					contentViewIconsPanel.append(spr);
					contentViewIconsPanel.append(new JSp(1));
				}
				
				contentViewIconsPanel.append(cws[i]);
			}
			contentViewIconsPanel.repaint();
			
			// диспетчеризовать событие
			//(cws[0] as JPanel).dispatchEvent(new AWEvent(AWEvent.ACT));
			
			contentView = cws[0];
			viewComp = contentView.getViewFIComponent();
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		private function selectContentViewListener(e:AWEvent):void 
		{
			(contentView as BaseFIsContentViewForm).setSelected(false);
			contentView = e.currentTarget as IContentView;
			viewComp = contentView.getViewFIComponent();
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		private function onAct(e:AWEvent):void
		{
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function getContentView():IContentView {
			return contentView;
		}
		
		public function getViewFIComponent():Component {
			//return viewComp;
			//var comp:Component = (viewsHashMap.get("List") as IContentView).getViewFIComponent();
			//gtrace(comp);
			
			return viewComp;
		}
		
		/*public function getViewMode():String
		{
			return String(modesCB.getSelectedItem());
		}*/
	
	}

}