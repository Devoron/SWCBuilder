package devoron.components.tables
{
	import devoron.data.core.base.IDataContainer;
	import devoron.dataui.multicontainers.table.IContainersControlPanel;
	import devoron.components.buttons.CircleBackgroundDecorator;
	import org.aswing.ASColor;
	import org.aswing.Container;
	import org.aswing.event.AWEvent;
	import org.aswing.geom.IntDimension;
	import org.aswing.Icon;
	import org.aswing.JButton;
	import org.aswing.JPanel;
	import org.aswing.layout.FlowLayout;
	import org.aswing.LoadIcon;
	import org.aswing.VectorListModel;
	
	/**
	 * TableControlPanel
	 * @author Devoron
	 */
	public class TableControlPanel extends JPanel implements IContainersControlPanel
	{
		//private var table:DSTable;
		private var table:*;
		public var removeItemBtn:JButton;
		public var copyItemBtn:JButton;
		public var addItemBtn:JButton;
		public var addItemButtonHandler:Function;
		public var removeItemButtonHandler:Function;
		public var copyItemButtonHandler:Function;
		
		public function TableControlPanel(table:*=null)
		{
			super(new FlowLayout(FlowLayout.RIGHT));
			this.table = table;
			
			var ico:LoadIcon = new LoadIcon("F:\\Projects\\projects\\flash\\studio\\Studio13\\assets\\icons\\TableControlPanel\\new_file_thumb.png", 16, 16);
			addItemBtn = appendButton("", ico, addBtnHandler);
			
			var ico2:LoadIcon = new LoadIcon("F:\\Projects\\projects\\flash\\studio\\Studio13\\assets\\icons\\TableControlPanel\\clear_icon8.png", 16, 16);
			removeItemBtn = appendButton("", ico2, removeBtnHandler);
			
			var ico3:LoadIcon = new LoadIcon("F:\\Projects\\projects\\flash\\studio\\Studio13\\assets\\icons\\TableControlPanel\\copy_icon18.png", 16, 16);
			copyItemBtn = appendButton("", ico3, copyBtnHandler);
			
			appendAll(addItemBtn, copyItemBtn, removeItemBtn);
		}
		
		public function appendButton(text:String, icon:Icon = null, listener:Function = null, comIndex:int = -1):JButton
		{
			var btn:JButton = new JButton("", icon);
			btn.addActionListener(listener);
			btn.setPreferredSize(new IntDimension(20, 20));
			btn.setBackgroundDecorator(new CircleBackgroundDecorator(new ASColor(0x000000, 0.08), new ASColor(0xFFFFFF, 0.08), 15));
			append(btn);
			return btn;
		}
		
		protected function copyBtnHandler(e:AWEvent):void
		{
			table.cloneSelectedValues();
		}
		
		protected function removeBtnHandler(e:AWEvent):void
		{
			table.removeSelectedValues();
		}
		
		protected function addBtnHandler(e:AWEvent):void
		{
			table.addDefaultValue();
		}
		
		/* INTERFACE devoron.components.multicontainers.table.IContainersControlPanel */
		
		public function setData(dataArray:Array):void
		{
		
		}
		
		public function getData():Array
		{
			return null;
		}
		
		public function getControlPanel():Container
		{
			return this;
		}
		
		public function addIContentViewListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
		
		}
		
		public function setConsoleComands(commands:Array):void
		{
		
		}
		
		public function addActionListener(listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
		
		}
		
		public function removeActionListener(listener:Function):void
		{
		
		}
		
		public function setContainersModel(model:VectorListModel):void
		{
		
		}
		
		public function getSelectedValue():*
		{
		
		}
		
		public function setSelectedValueIndex(index:uint):void
		{
		
		}
		
		public function clear():void
		{
		
		}
		
		public function setCurrentContainer(dc:IDataContainer):void
		{
		
		}
		
		public function setCurrentContainerIndex(index:uint):void
		{
		
		}
	
	}

}