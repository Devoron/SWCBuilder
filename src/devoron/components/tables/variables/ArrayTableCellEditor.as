package devoron.components.tables.variables
{
	//import MAINS.other.editors.Main_PRICE2000;
	import devoron.components.tables.variables.ValuesTableModel;
	import devoron.components.buttons.DSButton;
	import devoron.components.darktable.DarkTableCellEditor;
	import devoron.components.frames.StudioFrame;
	import devoron.components.tables.DSTable;
	import devoron.components.tables.TableControlPanel;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import org.aswing.ASColor;
	import org.aswing.AssetIcon;
	import org.aswing.border.EmptyBorder;
	import org.aswing.CellEditor;
	import org.aswing.Component;
	import org.aswing.Container;
	import org.aswing.event.AWEvent;
	import org.aswing.event.CellEditorListener;
	import org.aswing.event.SelectionEvent;
	import org.aswing.ext.Form;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntRectangle;
	import org.aswing.Insets;
	import org.aswing.JButton;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
	import org.aswing.layout.BorderLayout;
	import org.aswing.table.DefaultTableModel;
	import org.aswing.table.TableCellEditor;
	import org.aswing.tree.TreeCellEditor;
	import org.aswing.util.ArrayUtils;
	import org.aswing.util.DepthManager;

	/**
	 * ArrayTableCellEditor
	 * CellEditor для редатиктирования ячеек с типом Array.
	 * Создаёт фрейм с 
	 * @author Devoron
	 */
	public class ArrayTableCellEditor extends StudioFrame implements CellEditor, TableCellEditor, TreeCellEditor
	{
		[Embed(source="../../../../../assets/icons/commons/assets_manager_icon16.png")]
		private var ARRAY_EDITOR_ICON16:Class;
		
		private const PACKAGES_MANAGER_ICON:String = "../assets/icons/packages_manager_icon20.png";
		private const INFO_ICON:String = "../assets/icons/info_icon20.png";
		private const WARNING_ICON:String = "../assets/icons/warning_icon20.png";
		
		private var modulForm:Form;
		private var arrayTableScP:JScrollPane;
		private var acceptBtn:JButton;
		private var cancelBtn:JButton;
		private var valuesTable:DSTable;
		private var valuesTableModel:DefaultTableModel;
		private var valuesTableTCP:TableControlPanel;
		private var colorComponent:Container;
		protected var relatedModuls:Vector.<String>;
		private var clickCountToStart:int;
		private var listeners:Array;
		
		public function ArrayTableCellEditor(ownerSprite:Sprite = null)
		{
			setResizable(false);
			setIcon(new AssetIcon(new ARRAY_EDITOR_ICON16, 16, 16));
			setSize(new IntDimension(430, 350));
			
			modulForm = new Form();
			//modulForm.filters = [new GlowFilter()];
			modulForm.setBorder(new EmptyBorder(null, new Insets(5, 5, 10, 5)));
			
			super.setContentPane(modulForm);
			
			relatedModuls = new Vector.<String>();
			
			listeners = new Array();
			clickCountToStart = 2;
			
			createElementsTable();
		}
		
		override public function show():void
		{
			super.show();
			setLocationRelativeTo();
		}
		
		public function getValues():Array
		{
			return valuesTable.getData();
		}
		
		public function setValues(arr:Array):void
		{
			//valuesTable.setData(arr);
			valuesTableModel.setData(arr);
		}
		
		//**************************************************** ♪ ОБРАБОТЧИКИ СОБЫТИЙ ***************************************		
		
		private function addValueBtnHandler(e:AWEvent):void
		{
			//valuesTable.addEmptyElement();
		}
		
		public function removeValueBtnHandler(e:AWEvent):void
		{
			var selId:int = valuesTable.getSelectedRow();
			if (selId == -1)
				return;
			
			valuesTableModel.getData()[selId] = null;
			
			// удалить из модели таблицы
			valuesTableModel.removeRow(selId);
			
			var valuesCount:uint = valuesTableModel.getData().length;
			if (valuesCount > 0)
			{
				selId = selId < valuesCount ? selId : valuesCount - 1;
				valuesTable.getSelectionModel().setSelectionInterval(selId, selId);
			}
		}
		
		public function setCountEditable(b:Boolean):void
		{
			acceptBtn.setEnabled(b);
			cancelBtn.setEnabled(b);
		}
		
		protected function dataTableSelectionHandler(e:SelectionEvent):void
		{
		/*super.dataTableSelectionHandler(e);
		
		   var selId:int = dataStructursTable.getSelectedRow();
		   if (selId == -1)
		   return;
		
		   lightsModel.clear();
		
		   // выбранная структура данных
		   var dataStructur:DataStructur = dataStructursTableModel.getData()[selId];
		   var lightPickerId:uint = dataStructur.getDataByContainerName("LightPickerId").lightPickerId;
		
		   // собрать все источники света, относящиеся к этому lightPicker'у
		   var lightEditor:* = GameStudio.instance.getModulByName("Light editor");
		   if (!lightEditor)
		   return;
		
		   var dataStructurs:Array = lightEditor.getDataStructurs();
		   for each (var item:*in dataStructurs)
		   {
		   var ds:* = item.getDataByContainerName("LightPicker");
		   if (ds.lightPickerId == lightPickerId)
		   {
		   lightsModel.append(item.lightName);
		   }
		 }*/
		}
		
		public function startCellEditing(owner:Container, value:*, bounds:IntRectangle):void
		{
			bounds.width = 315;
			bounds.height = 300;
			//bounds.x -= 150;
			//colorComponent.formRow2.setVisible(true);
			
			//getEditorComponent().setLocationXY(bounds.x, bounds.y);
			//getEditorComponent().setLocationR
			
			getEditorComponent().repaint();
			//colorComponent.colorChooserFrame.changeOwner(owner.stage/*AsWingUtils.getOwnerAncestor(button)*/);
			/*colorComponent.colorChooserFrame.*/
			changeOwner(owner.stage /*AsWingUtils.getOwnerAncestor(button)*/);
			
			var r:Rectangle = owner.getBounds(owner.stage);
			//colorComponent.colorChooserFrame.setLocationXY(r.x + owner.mouseX - colorComponent.colorChooserFrame.getWidth() * .5, r.y + owner.mouseY - colorComponent.colorChooserFrame.getHeight() * .5);
			
			//getEditorComponent().setVisible(true);
			//colorComponent.setASColor(value);
			
			//colorComponent.alpha = 0;
			//colorComponent.colorChooserFrame.setVisible(!colorComponent.colorChooserFrame.isVisible())
			show();
			toFront();
			//colorComponent.setLocationRelativeTo(showChooserBtn);
			//colorChooserFrame.bringToTop();
			//colorComponent.colorChooserFrame.bringToTop(owner);
			
			DepthManager.bringToTop(super);
			//super.startCellEditing(owner, value, bounds);
		}
		
		/**
		 * Subclass override this method to implement specified value transform
		 */ /*protected function transforValueFromText(text:String):*{
		   return text;
		 }*/
		
		public function getEditorComponent():Component
		{
			if (colorComponent == null)
			{
				colorComponent = getContentPane();
					//colorComponent.colorChooserFrame.setModal(true);
					//colorComponent.formRow1.setVisible(false);
					//colorComponent.formRow2.setVisible(true);
					//colorComponent.setBackgroundDecorator(new formDec());
			}
			return colorComponent;
		}
		
		private function stopCellEditing2(clr:ASColor):void
		{
			
			removeEditorComponent();
			fireEditingStopped();
		}
		
		protected function removeEditorComponent():void
		{
			/*getEditorComponent().removeFromContainer();
			 popup.dispose();*/
			//colorComponent.colorChooserFrame.setVisible(false);
			super.tryToClose();
		}
		
		public function getCellEditorValue():*
		{
			
			//Main_PRICE2000.tracer("завершено редактирование " + colorComponent.getColor());
			//return colorComponent.getColor();
			return "colorComponent.getASColor()";
		}
		
		/**
		 * Sets the value of this cell.
		 * @param value the new value of this cell
		 */
		protected function setCellEditorValue(value:*):void
		{
			//Main_PRICE2000.tracer("dsfs")
			//colorComponent.setColor(value);
		}
		
		public override function toString():String
		{
			return "DarkTableCompoundCellEditor[]";
		}
		
		/* INTERFACE org.aswing.CellEditor */
		
		public function isCellEditable(clickCount:int):Boolean
		{
			return clickCount == clickCountToStart;
		}
		
		public function stopCellEditing():Boolean
		{
			//colorComponent.setVisible(false);
			//setVisible(false);
			tryToClose();
			fireEditingStopped();
			return true;
		}
		
		public function addCellEditorListener(l:CellEditorListener):void
		{
			listeners.push(l);
		}
		
		public function removeCellEditorListener(l:CellEditorListener):void
		{
			ArrayUtils.removeFromArray(listeners, l);
		}
		
		protected function fireEditingStopped():void
		{
			for (var i:Number = listeners.length - 1; i >= 0; i--)
			{
				var l:CellEditorListener = CellEditorListener(listeners[i]);
				l.editingStopped(this);
			}
		}
		
		protected function fireEditingCanceled():void
		{
			for (var i:Number = listeners.length - 1; i >= 0; i--)
			{
				var l:CellEditorListener = CellEditorListener(listeners[i]);
				l.editingCanceled(this);
			}
		}
		
		/**
		 * Returns the number of clicks needed to start editing.
		 * @return the number of clicks needed to start editing
		 */
		public function getClickCountToStart():Number
		{
			return clickCountToStart;
		}
		
		public function isCellEditing():Boolean
		{
			var editorCom:Component = getEditorComponent();
			return editorCom != null && editorCom.isShowing();
		}
		
		public function cancelCellEditing():void
		{
			removeEditorComponent();
			fireEditingCanceled();
		}
		
		/*public function updateUI():void
		   {
		
		 }*/
		
		//**************************************************** ☼ СОЗДАНИЕ КОМПОНЕНТОВ ***************************************
		
		protected function createElementsTable():void
		{
			valuesTableModel = new ValuesTableModel();
			//dataStructursTableModel.setColumnNames(["Value, Type"]);
			valuesTable = new DSTable(valuesTableModel);
			valuesTable.setDefaultEditor("String", new DarkTableCellEditor());
			//valuesTable.setDefaultEditor("Type", new TypeCellEditor());
			valuesTable.setDefaultEditor("Type", new DarkTableCellEditor());
			arrayTableScP = new JScrollPane(valuesTable, JScrollPane.SCROLLBAR_ALWAYS, JScrollPane.SCROLLBAR_NEVER);
			arrayTableScP.setPreferredSize(new IntDimension(368, 280));
			arrayTableScP.buttonMode = true;
			
			modulForm.addLeftHoldRow(2, 20, arrayTableScP);
			
			valuesTableTCP = new TableControlPanel(valuesTable);
			//valuesTableTCP
			acceptBtn = createButton("Accept", acceptBtnHandler);
			cancelBtn = createButton("Cancel", removeValueBtnHandler);
			
			var pan:JPanel = new JPanel(new BorderLayout());
			acceptBtn.setPreferredWidth(81);
			acceptBtn.setPreferredHeight(16);
			
			cancelBtn.setPreferredWidth(81);
			cancelBtn.setPreferredHeight(16);
			//acceptBtn.setBorder(new EmptyBorder(null, new Insets(5)));
			
			var buttonsPane:JPanel = new JPanel(new BorderLayout);
			buttonsPane.append(acceptBtn, BorderLayout.WEST);
			buttonsPane.append(cancelBtn, BorderLayout.EAST);
			pan.append(buttonsPane, BorderLayout.CENTER);
			pan.append(valuesTableTCP, BorderLayout.EAST);
			pan.setPreferredWidth(368);
			//modulForm.addRightHoldRow(0, acceptBtn,  valuesTableTCP);
			modulForm.addRightHoldRow(0, pan);
			modulForm.addRightHoldRow(0, [0, 15]);
			//modulForm.addRightHoldRow(0, acceptBt,  valuesTableTCP);
		}
		
		private function acceptBtnHandler(e:AWEvent):void
		{
			//this.stopCellEditing();
			dispatchEvent(new AWEvent(AWEvent.ACT));
		}
		
		protected function createButton(text:String, listener:Function):JButton
		{
			var btn:DSButton = new DSButton(text);
			btn.setPreferredWidth(120);
			btn.buttonMode = true;
			btn.setForeground(new ASColor(0xFFFFFF, 0.5));
			btn.setMaximumHeight(16);
			btn.addActionListener(listener);
			return btn;
		}
	
	}

}

