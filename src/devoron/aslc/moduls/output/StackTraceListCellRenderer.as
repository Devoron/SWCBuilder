package devoron.aslc.moduls.output
{
	import devoron.file.FileInfo;
	import devoron.sdk.runtime.errors.ErrorValue;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import net.kawa.tween.easing.Linear;
	import net.kawa.tween.KTween;
	import org.aswing.AbstractListCell;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.decorators.ColorDecorator;
	import org.aswing.ext.Form;
	import org.aswing.JLabel;
	import org.aswing.JList;
	
	public class StackTraceListCellRenderer extends AbstractListCell
	{
		protected var selectedColor:ASColor = new ASColor(0XFFFFFF, 0.15);
		protected var unselectedColor:ASColor = new ASColor(0xFFFFFF, 0.14);
		protected var comp:Form;
		
		protected var pathLB:JLabel;
		protected var descriptionLB:JLabel;
		//protected var lineLB:JLabel;
		protected var positionLB:JLabel;
		protected var citatLB:JLabel;
		
		private var rootDirectory:FileInfo;
		private var clb:ColorDecorator;
		private var isSelected:Boolean;
		private var errorValue:ErrorValue;
		
		
		public function StackTraceListCellRenderer()
		{
			comp = new Form();
			//comp.addEventListener(MouseEvent.MOUSE_OUT, onMOut);
			//comp.addEventListener(MouseEvent.MOUSE_OVER, onMOver);
			//pathLB.setSelectable(true);
			
			pathLB = new JLabel();
			pathLB.setForeground(new ASColor(0XFFFFFF, 0.6));
			pathLB.setOpaque(false);
			
			descriptionLB = new JLabel();
			descriptionLB.setForeground(new ASColor(0XFFFFFF, 0.6));
			descriptionLB.setOpaque(false);
			
			
			/*lineLB = new JLabel();
			lineLB.setForeground(new ASColor(0XFFFFFF, 0.6));
			lineLB.setOpaque(false);*/
			
			positionLB = new JLabel();
			positionLB.setForeground(new ASColor(0XFFFFFF, 0.6));
			positionLB.setOpaque(false);
			
			citatLB = new JLabel();
			citatLB.setForeground(new ASColor(0XFFFFFF, 0.6));
			citatLB.setOpaque(false);
			
			comp.addLeftHoldRow(0, positionLB, descriptionLB);
			//comp.addLeftHoldRow(0, /*lineLB,*/ positionLB, pathLB);
			
			//pathLB
			//pathLB.setBackground(new ASColor(0x000000, 0.4));
			clb = new ColorDecorator(new ASColor(0x000000, 0), null, 2);
			comp.setBackgroundDecorator(clb);
			//comp.addLeftHoldRow(0, 5, pathLB);
			comp.buttonMode = true;
			
			
			comp.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			comp.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			comp.doubleClickEnabled = true;
			comp.mouseChildren = false;
			comp.addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
			comp.alpha = 0.54;
		}
		
		private function onDoubleClick(e:MouseEvent):void 
		{
			trace("даблик " + value.path);
			//pathLB.setForeground(new ASColor(0xC93C18, 0.4));
			//clb.setColor(new ASColor(0xE2130E, 1));
			
			//if(e
			
			(new File(value.path)).openWithDefaultApplication();
			
			
			// временно !!
			var fi:File = new File(value.path);
			if (fi.extension == "as")
			{
				/*var editosFactory:StudioDataProcessorsProvider = new StudioDataProcessorsProvider();
				var editor:IDataProcessor = editosFactory.getDataProcessor(fi.name, AS3Editor, fi.nativePath, false);
				StudioWorkspace.instance.append(editor.getView(), { layout: StudioWorkspaceLayout.TAB, icon: null, title: fi.name + "." + fi.extension } );
				StudioWorkspace.instance.tabs.setSelectedIndex(StudioWorkspace.instance.tabs.getTabCount()-1);*/
					//trace("DBBBBB " + editor.getView())
			}
			
			//comp.alpha = 0.04;
		}
		
		private function onRollOut(e:MouseEvent):void
		{
			if (isSelected)
				comp.alpha = 1;
			else
				KTween.to(comp, 0.15, {alpha: 0.54}, Linear.easeIn).init();
		
		/*if (v)
		   {
		   alpha = 0;
		   super.setVisible(true);
		   KTween.to(this, 0.15, {alpha: 1}, Linear.easeIn).init();
		   }
		   else
		   {
		   //super.setVisible(false);
		   KTween.to(this, 0.08, {alpha: 0}, Linear.easeIn, onAlphaReduceComplete).init();
		 }*/
		}
		
		private function onRollOver(e:MouseEvent):void
		{
			KTween.to(comp, 0.15, {alpha: 1}, Linear.easeIn).init();
		}
		
		private function onMOver(e:MouseEvent):void
		{
			//KTween.to(clb, 0.15, {alpha: 1}, Linear.easeIn).init();
			pathLB.setForeground(new ASColor(0XFFFFFF, 0.6));
			clb.setColor(new ASColor(0x000000, 0.14));
		}
		
		private function onMOut(e:MouseEvent):void
		{
			clb.setColor(new ASColor(0x000000, 0));
			pathLB.setForeground(new ASColor(0XFFFFFF, 0.4));
		}
		
		public override function getCellComponent():Component
		{
			return comp;
		}
		
		public override function getCellValue():*
		{
			return errorValue;
		}
		
		public override function setCellValue(value:*):void
		{
			this.value = value;
			//if (!value)
				//return;
			//rootDirectory = FileInfo(value);
		/**
		 * Было !!
		 *
		 * pathLB.setText(value.text);
		 */
		
		 if (value is ErrorValue) {
			//va
			 var errorValue:ErrorValue = value as ErrorValue;
			 descriptionLB.setText(errorValue.description);
			positionLB.setText("["+errorValue.line + ":" + errorValue.position+"]");
		 } 
		 else {
			 	descriptionLB.setText( (value as Object).codePath);
			//pathLB.setText( (value as Object).filePath);
			//positionLB.setText( (value as Object).line);
			positionLB.setText( "#" + (value as Object).messageNum + " : " + (value as Object).line);
		 } 
		 
		
		 
			//errorValue = value as ErrorValue;
			//pathLB.setText(errorValue.path);
			
			//lineLB.setText(errorValue.line);
			//positionLB.setText("[" + errorValue.line + " : " + errorValue.position + "]");
		
			//pathLB.setText(rootDirectory.name);
			//var bi:Bitmap = new Bitmap(rootDirectory.icons[1]);
			//bi.filters = [new ColorMatrixFilter([0.3086, 0.6094, 0.0820, 0, 0, 0.3086, 0.6094, 0.0820, 0, 0, 0.3086, 0.6094, 0.0820, 0, 0, 0, 0, 0, 1, 0])];
		
			//pathLB.setIcon(new AssetIcon(bi));
		}
		
		public function setListCellStatus2(list:JList, isSelected:Boolean, index:int):void
		{
			//clb.setColor( isSelected ? selectedColor : unselectedColor);
			pathLB.setForeground(isSelected ? list.getSelectionForeground() : list.getForeground());
			//comp.setBorder(new LineBorder(null, isSelected ? selectedColor : unselectedColor, 1, 2));
		}
		
		public override function  setListCellStatus(list:JList, isSelected:Boolean, index:int):void
		{
			this.isSelected = isSelected;
			//var com:Component = getCellComponent();
			if (isSelected)
			{
				/*pathLB.setBackground(list.getSelectionBackground());
				 pathLB.setForeground(list.getSelectionForeground());*/
				
				//pathLB.setForeground(new ASColor(0xFFFFFF, 0.4));
				clb.setColor(new ASColor(0x000000, 0.14));
				
			}
			else
			{
				pathLB.setBackground(list.getBackground());
				//pathLB.setForeground(list.getForeground());
				//pathLB.setForeground(new ASColor(0xFFFFFF, 0.4));
				clb.setColor(new ASColor(0x000000, 0));
			}
			pathLB.setFont(list.getFont());
		}
	
	}
}