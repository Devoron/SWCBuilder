package devoron.data.dsgridlist
{
	import devoron.components.ComponentDragImage;
	import devoron.studio.guidesinger.GUIDesingerDnDHandler;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import net.kawa.tween.KTween;
	import net.kawa.tween.easing.Linear;
	import org.aswing.ASColor;
	import org.aswing.ASFont;
	import org.aswing.ASFontAdvProperties;
	import org.aswing.Component;
	import org.aswing.JLabel;
	import org.aswing.decorators.ColorDecorator;
	import org.aswing.dnd.DragManager;
	import org.aswing.dnd.SourceData;
	import org.aswing.event.AWEvent;
	import org.aswing.event.DragAndDropEvent;
	import org.aswing.event.SelectionEvent;
	import org.aswing.ext.Form;
	import org.aswing.ext.GridList;
	import org.aswing.ext.GridListCell;
	import org.aswing.geom.IntDimension;
	
	
	
	/**
	 * The default grid list cell render value.toString() as texts.
	 *
	 */
	public class DataStructurGridListCell extends JLabel implements GridListCell
	{
		private var dataStructurTypeLB:JLabel;
		private var dataStructurIconLB:JLabel;
		
		private var bg:ColorDecorator;
		private var defaultForm:Form;
		private var downloadForm:Form;
		private var selLB:JLabel;
		private var value:*;
		
		public function DataStructurGridListCell()
		{
			super("32");
			//setOpaque(true);
			setPreferredWidth(115);
			setPreferredHeight(115);
			setSize(new IntDimension(115, 115));
			setMinimumSize(new IntDimension(115, 115));
			buttonMode = true;
			
			bg = new ColorDecorator(new ASColor(0x000000, 0.14), null, 4);
			super.setBackgroundDecorator(bg);
			//
			
			//dataStructurTypeLB = createLabel("АИ 90", 15, new ASColor(0xFFFFFF, 0.72));
			//dataStructurIconLB = createLabel("АИ 90", 15, new ASColor(0xFFFFFF, 0.72));
			
			//addLeftHoldRow(0, dataStructurTypeLB);
			//addLeftHoldRow(0, dataStructurIconLB);
			//dataStructurTypeLB.setIcon(icon);
			
			setDraggable(true);
		
		}
		
		public function setDraggable(b:Boolean):void
		{
			super.setDragEnabled(b);
			if (b)
			{
				super.addEventListener(DragAndDropEvent.DRAG_RECOGNIZED, __startDrag);
				super.addEventListener(DragAndDropEvent.DRAG_DROP, __stopDrag);
			}
			else
			{
				super.removeEventListener(DragAndDropEvent.DRAG_RECOGNIZED, __startDrag);
				super.removeEventListener(DragAndDropEvent.DRAG_DROP, __stopDrag);
			}
		}
		
		private function __stopDrag(e:DragAndDropEvent):void
		{
			//PathChooserForm.removeDragAcceptableInitiator(e.getDragInitiator());
			//ShaderEditor.controller.removeDragAcceptableInitiator(e.getDragInitiator());
			gtrace("5:перетаскано");
		}
		
		protected function __startDrag(e:DragAndDropEvent):void
		{
			
			// здесь Desktop должен получить компонент для перетаскивания
			//ShaderEditor.view.desktop.addDragAcceptableInitiator(e.getDragInitiator());
			
			//PathChooserForm.addDragAcceptableInitiator(e.getDragInitiator());
			// здесь мы запускаем процесс перетаскивания со специально созданным объектом DnDHadler
			//DragManager.startDrag(e.getDragInitiator(), null, null, new DnDHadler ());
			var com:JLabel = e.getDragInitiator() as JLabel;
			
			//GameStudio.instance.propertiesPanel1.addDragAcceptableInitiator(com);
			//GameStudio.instance.propertiesPanel1.setD
			//GameStudio.instance.propertiesPanel2.addDragAcceptableInitiator(com);
			
			//World.worldSprite.addDragAcceptableInitiator(com);
			
			var dragImage:ComponentDragImage = new ComponentDragImage(com);
			
			//BitmapDataUtils
			
			// для ShaderEditor'a
			//DragManager.startDrag(e.getDragInitiator(), new SourceData(com.getText(), null), dragImage, new DnDHandler2());
			// для GUIEditor'a
			DragManager.startDrag(e.getDragInitiator(), new SourceData(com.getText(), null), dragImage, new GUIDesingerDnDHandler());
		}
		
		
		private function onFocusOut(e:FocusEvent):void
		{
			//typesList.setSelectedIndex(-1);
		}
		
		private function onSelectionChange(e:SelectionEvent):void
		{
			//if (typesList.getSelectedValue() != null)
				//showOrderForm();
		}
		
		
		private function showOrderForm():void
		{
			/*selectedCran = (typesList.getSelectedValue() as Cran);
			var selFuelType:String = selectedCran.fuelType;
			orderForm.setSelectedFuelType(selFuelType);
			orderForm.show();
			orderForm.addEventListener(PopupEvent.POPUP_CLOSED, onClosed);
			orderForm.addActionListener(onOrderCreated);*/
		}
		
		private function onOrderCreated(e:AWEvent):void
		{
			/*selectedCran.addEventListener(Event.DEACTIVATE, onCranDeactivate);
			selectedCran.setVolumeToDownload(orderForm.getOrder().volume);
			selectedCran.setActive(true);
			typesList.updateListView();*/
		}
		
		//private function onClosed(e:PopupEvent):void
		//{
			//orderForm.removeEventListener(PopupEvent.POPUP_CLOSED, onClosed);
		//}
		
		private function onRollOver(e:MouseEvent):void
		{
			//(e.currentTarget as JButton).setAlpha(
			KTween.to(e.currentTarget, 0.1, {alpha: 1}, Linear.easeIn).init();
		}
		
		private function onRollOut(e:MouseEvent):void
		{
			KTween.to(e.currentTarget, 0.1, {alpha: 0.4}, Linear.easeIn).init();
		}
		
		private function createLabel(text:String, size:uint, foreground:ASColor):JLabel
		{
			var lb:JLabel = new JLabel(text);
			lb.setPreferredWidth(60);
			//lb.setBackgroundDecorator(new ColorDecorator(new ASColor(0x008000, 0.3)));
			lb.setForeground(foreground);
			//lb.setForeground(new ASColor(0xFFFFFF, 0.7));
			//lb.setBackground(new ASColor(0xFFFFFF, 0.7));
			var advProp:ASFontAdvProperties = new ASFontAdvProperties(true, "advanced", "pixel");
			var font:ASFont = new ASFont("Consolas", size, false, false, false, advProp);
			lb.setFont(font);
			return lb;
		}
		
		private function createInputForm():Form
		{
			return null;
		}
		
		public function setCellValue(value:*):void
		{
			this.value = value;
			//var lb:JLabel = new JLabel("", value.icon);
			//lb.setPreferredSize(new IntDimension(100, 100));
			
			//dataStructurTypeLB.setIcon(value.icon);
			//super.setIcon(new JLabelIcon());
			super.setIcon(value.icon);
			
			/*if (column){
				if (column != value){
					column.removeEventListener(Event.CHANGE, onColumnStateChange);
				}
			}
			
			column = value as Column;
			column.addEventListener(Event.CHANGE, onColumnStateChange);
			dataStructurTypeLB.setText("");
			columnNumberLB.setText(String(column.index + 1));*/
			/*(selBCB.getModel() as VectorListModel).clear();
			   (selBCB.getModel() as VectorListModel).appendAll(column.types);
			 selBCB.setSelectedIndex(0);*/
			
		/*	lockLB.setVisible(!column.isActive());
			typesList.setEnabled(column.isActive());
			
			(typesList.getModel() as VectorListModel).clear();
			(typesList.getModel() as VectorListModel).appendAll(column.crans);*/
		
		}
		
		/*private function onColumnStateChange(e:Event):void 
		{
			//gtrace(e);
			lockLB.setVisible(!column.isActive());
			typesList.setEnabled(column.isActive());
		}*/
		
		public function getCellValue():*
		{
			//return column;
			return value;
		}
		
		public function getCellComponent():Component
		{
			return this;
		}
		
		public function setGridListCellStatus(gridList:GridList, selected:Boolean, index:int):void
		{
			if (selected)
			{
				//if (!column.isActive()){
					//lockLB.setVisible(!column.isActive());
					//KTween.to(lockLB, 0.2, {alpha: 0.5}, Linear.easeIn).init();
				//}
				
				//KTween.to(cameraBtn, 0.2, {alpha: 0.6}, Linear.easeIn).init();
				
				//KTween.to(bg.getDisplay(null), 0.1, {alpha: 0}, Linear.easeIn, complete).init();
				
				//lbBG.setColor(new ASColor(0x515151, 0.08));
				//lbBG.getDisplay(null).filters = [new GlowFilter(0xFFFFFF, 0.24, 6, 6, 2, 2, false), new BlurFilter(4, 4, 2)];
			}
			else
			{
				//if (!column.isActive()){
					//lockLB.setVisible(!column.isActive());
					//KTween.to(lockLB, 0.2, {alpha: 0.2}, Linear.easeIn).init();
				//}
				
			}
		
		}
		
		private function complete():void
		{
			//bg.setImage(null);
			//KTween.to(bg.getDisplay(null), 0.15, {alpha: 1}, Linear.easeIn).init();
			//KTween.to(bi, 0.3, {alpha: 0.7}, Linear.easeIn).init();
		}
	
	}
}