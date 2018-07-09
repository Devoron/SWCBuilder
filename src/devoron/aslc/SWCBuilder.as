package devoron.aslc
{
	import devoron.aslc.events.SWCBuilderEvent;
	import devoron.aslc.events.SWCBuilderEventDispatcher;
	import devoron.components.decorators.ButtonGroupDecorator;
	import devoron.components.frames.StudioFrame;
	import devoron.dataui.DataContainerForm;
	import flash.filters.BlurFilter;
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.ASFontAdvProperties;
	import org.aswing.AssetIcon;
	import org.aswing.border.EmptyBorder;
	import org.aswing.ButtonGroup;
	import org.aswing.event.AWEvent;
	import org.aswing.ext.Form;
	import org.aswing.geom.IntDimension;
	import org.aswing.Insets;
	import org.aswing.JFrameTitleBar;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.JToggleButton;
	import org.aswing.layout.BorderLayout;
	import org.aswing.layout.FlowLayout;
	//import devoron.components.tabbedpane.DSTabbedPane;
	//import devoron.dataui.DataContainerTitleBar;
	//import devoron.DSTabbedPaneUI4;
	//import devoron.sdk.runtime.StudioRuntime;
	//import devoron.studio.moduls.gui.themebuilder.DSTabbedPaneUI2;
	
	/**
	 * AS3LivecodeTool
	 * @author Devoron
	 */
	public class SWCBuilder extends StudioFrame
	{
		//[Embed(source="../../../assets/icons/moduls/CodeEditor/as3livecode_icon16.png")]
		[Embed(source="../../../assets/icons/commons/livecode_icon18.png")]
		private const LIVE_ICON18:Class;
		
		//private var pagesTP:DSTabbedPane;
		//private var studioRuntime:StudioRuntime;
		private var modulComponents:Vector.<DataContainerForm>;
		private var buttonGroup:ButtonGroup;
		private var dec:ButtonGroupDecorator;
		private var contentContainer:JPanel;
		
		/**
		 * Constructor.
		 * @param studioRuntime ссылка на рантайм-медиатор
		 * @param modulComponents модули, которые входят в состав AS3LivecodeTool
		 */
		public function SWCBuilder(/*studioRuntime:StudioRuntime*/ modulComponents:Vector.<DataContainerForm>)
		{
			super(null, "SWCBuilder", false, false);
			this.modulComponents = modulComponents;
			//this.studioRuntime = studioRuntime;
			setIcon(new AssetIcon(new LIVE_ICON18));
			var titleLB:JLabel = super.getTitleBar().getLabel();
			titleLB.setTextFilters([new BlurFilter(1, 1, 3)]);
			//super.setForeground(new ASColor(0x4a626e, 1));
			
			(titleBar as JFrameTitleBar).setPreferredHeight(28);
			(titleBar as JFrameTitleBar).setBackgroundDecorator(null);
			var advProp:ASFontAdvProperties = new ASFontAdvProperties(true, "advanced", "pixel");
			var font2:ASFont = new ASFont("Attractive Regular", 17, false, false, false, advProp);
			titleLB.setFont(font2);
			titleLB.setFont(titleLB.getFont().changeSize(18));
			titleLB.setForeground(new ASColor(0XFFFFFF, 1));
			super.setResizable(true);
			
			super.setSize(new IntDimension(1050, 660));
			super.setPreferredSize(new IntDimension(1050,660));
			super.getTitleBar().setRestoreButton(null);
			
			installComponents();
		}
		
		
		/**
		 * Установка формы вкладок, в каждую вкладку которой помещается
		 * форма содержающая DataContainerForm.
		 */
		private function installComponents():void
		{
			var modulForm:Form = new Form();
			
			var pan:JPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 0));
			//pan.setBackgroundDecorator(new ButtonGroupDecorator(new ASColor(0xFFFFFF, 0.44)));
			dec = new ButtonGroupDecorator(new ASColor(0xFFFFFF, 0));
			pan.setBackgroundDecorator(dec);
			buttonGroup = new ButtonGroup();
		/*	
			pagesTP = new DSTabbedPane;
			//pagesTP.setBackgrounDecorator(new ColorDecorator(new ASColor(0x00FF00)));
			pagesTP.setLeadingOffset(0);
			pagesTP.setUI(new DSTabbedPaneUI4);
			pagesTP.setPreferredSize(new IntDimension(1050, 660));
			pagesTP.setSize(new IntDimension(1050, 660));
			pagesTP.setBorder(new EmptyBorder(null, new Insets(5, 5, 5, 5)));*/
			
			//var titleLabel:DataContainerTitleBar;
			var dataContainer:DataContainerForm;
			for each (dataContainer in modulComponents)
			{
				/*if (dataContainer is DataContainerForm)
				{
					titleLabel = new DataContainerTitleBar(dataContainer.dataContainerName.toUpperCase(), null, JLabel.CENTER, null, false);
					titleLabel.setRelatedDataContainer(dataContainer);
				}
				
				var form:Form = new Form();
				form.addLeftHoldRow(0, titleLabel);
				
				titleLabel.metaData = form;*/
				
				var btn:JToggleButton = new JToggleButton("");
				btn.name = dataContainer.dataContainerName;
				btn.addActionListener(onBtnAct);
				btn.setIconTextGap(0);
				//btn.defaultBgColor = new ASColor(0xFFFFFF, 0);
				//btn.selectedBgColor = new ASColor(0xFFFFFF, 0)
				btn.setBackgroundDecorator(null);
				btn.setBorder(null);
				btn.setPreferredSize(new IntDimension(54, 30));
				btn.setIcon(dataContainer.dataContainerIcon);
				pan.append(btn);
				buttonGroup.append(btn);
				
				//pagesTP.appendTab(dataContainer, dataContainer.dataContainerName, dataContainer.dataContainerIcon/*.toUpperCase()*/);
				dataContainer.setBorder(new EmptyBorder(null, new Insets(5, 5, 5, 5)));
				
				
				
			}
			
			//modulForm.addLeftHoldRow(0, pagesTP);
			//pan.setBorder(new EmptyBorder(null, new Insets(5,)));
			modulForm.addLeftHoldRow(0, 8, [0,5]);
			modulForm.addLeftHoldRow(0, 8, pan);
			
			
				contentContainer = new JPanel(new BorderLayout());
				//pagesTP.setPreferredSize(new IntDimension(1050, 660));
				contentContainer.setPreferredSize(new IntDimension(1050, 660));
			modulForm.addLeftHoldRow(0, 8, contentContainer);
			
			//modulForm.setBackgroundDecorator(new ColorDecorator(new ASColor(0, 0.2)));
			
			setContentPane(modulForm);
		}
		
		private function onBtnAct(e:AWEvent):void 
		{
			dec.setSelin(buttonGroup.getSelectedIndex());
			
			var dataContainer:DataContainerForm;
			for each (dataContainer in modulComponents) {
				if ((e.currentTarget as JToggleButton).name == dataContainer.dataContainerName) {
				//trace(e);	
				contentContainer.removeAll();
				contentContainer.append(dataContainer, BorderLayout.CENTER);
				dataContainer.setPreferredSize(new IntDimension(1050, 660));
				contentContainer.pack();
				contentContainer.revalidate();
				}
			}
			
			
		
		/*	var form:DataContainerForm = hash.get(bg.getSelectedButtonText()) as DataContainerForm;
			if (form) {
				contentContainer.removeAll();
				contentContainer.append(form, BorderLayout.CENTER);
				contentContainer.pack();
				
			}*/
		}
		
		public function noga(any:*):void
		{
			trace("Делает что угодно, потому что может быть лив? " + any);
		}
	
	}

}