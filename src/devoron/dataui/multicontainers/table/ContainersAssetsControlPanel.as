package devoron.dataui.multicontainers.table
{
	import devoron.components.buttons.DSDropDownButton;
	import devoron.components.labels.DSLabel;
	import devoron.data.core.base.IDataContainer;
	import devoron.dataui.multicontainers.table.DataContainersForm;
	import flash.events.MouseEvent;
	import org.aswing.ASColor;
	import org.aswing.AssetIcon;
	import org.aswing.Container;
	import org.aswing.event.AWEvent;
	import org.aswing.event.SelectionEvent;
	import org.aswing.geom.IntDimension;
	import org.aswing.JDropDownButton;
	import org.aswing.JPanel;
	import org.aswing.JToggleButton;
	import org.aswing.layout.BorderLayout;
	import org.aswing.layout.FlowLayout;
	import org.aswing.layout.VerticalCenterLayout;
	import org.aswing.VectorListModel;
	
	/**
	 * ContainersAssetsControlPanel
	 * @author Devoron
	 */
	public class ContainersAssetsControlPanel extends JPanel implements IContainersControlPanel
	{
		[Embed(source="../../../../../assets/icons/commons/preferences_icon20.png")]
		private var preferencesIcon:Class;
		
		public var dcf:DataContainersForm;
		private var showContainersTableBtn:JToggleButton;
		private var countTF:DSLabel;
		private var dataArray:Array;
		private var index:uint;
		public var selectedLB:JToggleButton;
		
		public function ContainersAssetsControlPanel(dataContainerType:String = "type")
		{
			super(new BorderLayout());
			//dataModel.addTableModelListener(new DataContainersTableChangeListener(
			
			setPreferredWidth(270);
			setWidth(270);
			//jp.setPreferredHeight(
			setMinimumWidth(270);
			
			var jp3:JPanel = new JPanel(new VerticalCenterLayout());
			dcf = new DataContainersForm();
			dcf.containersGridList.addSelectionListener(selectContentViewListener);
			
			var bb:JDropDownButton = new DSDropDownButton(dataContainerType, null, false, dcf);
			//bb.setPopupAlignment(JDropDownButton.RIGHT);
			/*bb.setPopupAlignment(JDropDownButton.BOTTOM);
			   //bb.setPopupAlignment(JDropDownButton.CENTER);
			   bb.setForeground(new ASColor(0xFFFFFF, 0.8));
			   //bb.useHandCursor = true;
			   //bb.setFont(bb.getFont().changeBold(true));
			   bb.setFont(bb.getFont().changeUnderline(true));
			   bb.setBackgroundDecorator(null);
			 bb.setPreferredWidth(100);*/
			//jp3.appendAll(new DSLabel(dataContainerType), showFullFormBtn);
			jp3.appendAll(bb);
			
			var jp4:JPanel = new JPanel(new VerticalCenterLayout());
			var jp5:JPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
			//showContainersTableBtn = new JToggleButton("", new AssetIcon(new preferencesIcon), showTable);
			/*
			 *
			 * обратить внимание на флаг showTable
			 */
			showContainersTableBtn = new JToggleButton("", new AssetIcon(new preferencesIcon), false);
			//showContainersTableBtn.addActionListener(showContainersTableBtnHandler);
			
			jp5.appendAll( /*addItemBtn,*/ /*showContainersGridListBtn, */showContainersTableBtn);
			jp4.append(jp5);
			
			//selectedLB = new DSLabel("");
			//selectedLB = new JToggleButton("", null, showTable);
			selectedLB = new JToggleButton("", null, false);
			selectedLB.setForeground(new ASColor(0xFFFFFF, 0.6));
			selectedLB.setBackgroundDecorator(null);
			selectedLB.addEventListener(MouseEvent.MOUSE_OVER, onMOver);
			selectedLB.addEventListener(MouseEvent.MOUSE_OUT, onMOut);
			//selectedLB.addActionListener(showContainersTableBtnHandler);
			
			countTF = new DSLabel();
			countTF.setSize(new IntDimension(28, 20));
			countTF.setPreferredSize(new IntDimension(28, 20));
			countTF.setText("5/16");
			countTF.setFont(countTF.getFont().changeSize(7));
			countTF.setForeground(new ASColor(0xFFFFFF, 0.4));
			//countTF.x = 80;
			//countTF.y = -3;
			selectedLB.addChild(countTF);
			countTF.setVisible(true);
			
			var jp2:JPanel = new JPanel(new VerticalCenterLayout());
			jp2.append(selectedLB);
			
			append(jp3, BorderLayout.WEST);
			//append(jp2, BorderLayout.CENTER);
			//jp.append(jp4, BorderLayout.EAST);
		
		/*var jp6:JPanel = new JPanel(new VerticalCenterLayout());
		   jp6.append(addItemBtn);
		
		   var jp2:JPanel = new JPanel(new HorizontalCenterLayout());
		 jp2.append(jp6);*/
			 //var jp2:JPanel = new JPanel(new CenterLayout());
			 //jp2.append(addItemBtn);
		
			//jp.append(jp2, BorderLayout.CENTER);
			//super.addLeftHoldRow(0, showFullFormBtn, showContainersTableBtn);
		
		}
		
		private function onMOut(e:MouseEvent):void
		{
			selectedLB.setForeground(new ASColor(0xFFFFFF, 0.6));
		}
		
		private function onMOver(e:MouseEvent):void
		{
			selectedLB.setForeground(new ASColor(0xFFFFFF, 0.8));
		}
		
		/* INTERFACE devoron.components.multicontainers.table.IContainersControlPanel */
		
		public function setData(dataArray:Array):void
		{
			this.dataArray = dataArray;
			//countTF.setText(String((index+1)+ "/" + dataArray.length));
			//countTF.x = selectedLB.getWidth()-countTF.getWidth();
		}
		
		public function getData():Array
		{
			return null;
		}
		
		public function setCurrentContainerIndex(index:uint):void
		{
			this.index = index;
			
			if (dataArray)
			{
				countTF.setText(String((index + 1) + "/" + dataArray.length));
				countTF.x = selectedLB.getWidth() - countTF.getWidth();
			}
		}
		
		public function getControlPanel():Container
		{
			return this;
		}
		
		public function addIContentViewListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			//grid
		}
		
		public function setConsoleComands(commands:Array):void
		{
		
		}
		
		public function addActionListener(listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			super.addEventListener(AWEvent.ACT, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeActionListener(listener:Function):void
		{
			super.removeEventListener(AWEvent.ACT, listener);
		}
		
		public function setContainersModel(model:VectorListModel):void
		{
			dcf.containersGridList.setModel(model);
			dcf.containersGridList.setSelectedIndex(0);
			dcf.containersGridList.repaintAndRevalidate();
		}
		
		public function getSelectedValue():*
		{
			return dcf.containersGridList.getSelectedValue();
		}
		
		public function setSelectedValueIndex(index:uint):void
		{
			dcf.containersGridList.setSelectedIndex(index);
			dcf.containersGridList.repaintAndRevalidate();
		}
		
		public function clear():void
		{
		
		}
		
		/* INTERFACE devoron.components.multicontainers.table.IContainersControlPanel */
		
		public function setCurrentContainer(dc:IDataContainer):void
		{
			selectedLB.setText(dc.dataContainerName + "          ");
		}
		
		private function selectContentViewListener(e:SelectionEvent):void
		{
			super.dispatchEvent(new AWEvent(AWEvent.ACT));
		}
	
	}

}