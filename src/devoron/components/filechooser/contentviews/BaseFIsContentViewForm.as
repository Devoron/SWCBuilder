package devoron.components.filechooser.contentviews 
{
	import flash.events.Event;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.decorators.ColorDecorator;
	import org.aswing.event.AWEvent;
	import org.aswing.Icon;
	import org.aswing.JPanel;
	import org.aswing.JToggleButton;
	import org.aswing.util.HashMap;
	import org.aswing.VectorListModel;
	
	[Event(name = "itemClick", type = "devoron.components.filechooser.contentviews.FIContentViewEvent")]
	[Event(name = "itemDoubleClick", type = "devoron.components.filechooser.contentviews.FIContentViewEvent")]
	[Event(name = "itemMouseDown", type = "devoron.components.filechooser.contentviews.FIContentViewEvent")]
	[Event(name = "itemRollOver", type = "devoron.components.filechooser.contentviews.FIContentViewEvent")]
	[Event(name = "itemRollOut", type = "devoron.components.filechooser.contentviews.FIContentViewEvent")]
	[Event(name = "itemReleaseOutSide", type = "devoron.components.filechooser.contentviews.FIContentViewEvent")]
	
	
	/**
	 * BaseFIsContentViewForm
	 * @author Devoron
	 */
	public class BaseFIsContentViewForm extends JPanel implements IContentView
	{
		protected var data:Array;
		private var consoleCommands:HashMap;
		
		public function BaseFIsContentViewForm() 
		{
			buttonMode = true;
			//setPreferredHeight(24);
			
			//setConsoleComands("select 
			
			//addGuy "Andreas Rønning" 27
			
			consoleCommands = new HashMap();
			consoleCommands.put("selectFile", selectFile);
			
			//DConsole.createCommand("selectFiles", selectFile);
			//filesList.addSelectionListener(filesListSelectionHandler);
			//filesList.setSelectionMode(JList.SINGLE_SELECTION);
			
		}
		
		
		protected function selectFile(fileName:String):void 
		{
			//gtrace("поиск имени");
		}
		
		//protected function selectFiles(
		
		protected function createIconButton(icon:Icon, tooltipText:String):JToggleButton {
			var contentViewBtn:JToggleButton= new JToggleButton("", icon);
			contentViewBtn.setToolTipText(tooltipText);
			contentViewBtn.setBackgroundDecorator(null);
			contentViewBtn.addActionListener(contentViewBtnHandler);
			//contentViewBtn.addActionListener(contentViewChangedHandler)
			return contentViewBtn;
		}
		
		protected function contentViewBtnHandler(e:Event):void 
		{
			if (e.currentTarget is JToggleButton) {
				if ((e.currentTarget as JToggleButton).isSelected()) {
					//gtrace(getSize());
					//this.setBorder(new LineBorder(null, new ASColor(0x000000, 0.4), 1, 2));
					//setBackgroundDecorator(new ColorDecorator(new ASColor(0x000000, 0.14), null, 2));
					var bd:ColorDecorator = new ColorDecorator(new ASColor(0XFFFFFF, 0.15), null, 2);
					bd.setGaps(0, 0, 4, -8);
					setBackgroundDecorator(bd);
					repaint();
				}
				else {
					//this.setBorder(null);
					setBackgroundDecorator(null);
					repaint();
				}
			}
			super.dispatchEvent(new AWEvent(AWEvent.ACT));
		}
		
		public function setSelected(b:Boolean):void {
				if (b) {
					//gtrace(getSize());
					//this.setBorder(new LineBorder(null, new ASColor(0x000000, 0.4), 1, 2));
					//setBackgroundDecorator(new ColorDecorator(new ASColor(0x000000, 0.14), null, 2));
					var bd:ColorDecorator = new ColorDecorator(new ASColor(0XFFFFFF, 0.15), null, 2);
					bd.setGaps(0, 0, 4, -8);
					setBackgroundDecorator(bd);
					repaint();
				}
				else {
					//this.setBorder(null);
					setBackgroundDecorator(null);
					repaint();
				}
		}
		
		public function addActionListener(listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			super.addEventListener(AWEvent.ACT, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeActionListener(listener:Function):void
		{
			super.removeEventListener(AWEvent.ACT, listener);
		}
		
		/* INTERFACE devoron.components.filechooser.contentviews.IContentView */
		
		public function setData(dataArray:Array):void 
		{
			data = dataArray;
		}
		
		public function getData():Array 
		{
			return data;
		}
		
		
		
		public function addIContentViewListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		/* INTERFACE devoron.components.filechooser.contentviews.IContentView */
		
		public function getViewFIComponent():Component 
		{
			return null;
		}
		
		public function setConsoleComands(commands:Array):void
		{
			
		}
		
		public function setFilesModel(model:VectorListModel):void 
		{
			
		}
		
		public function getSelectedValue():* 
		{
			return null;
		}
		
		public function clear():void 
		{
			
		}
		
		
		/* INTERFACE devoron.components.filechooser.contentviews.IContentView */
		
		public function getSupportedModels():Array 
		{
			return [];
		}
		
		
		
	}

}