package devoron.dataui
{
	import devoron.data.core.base.SimpleDataComponent;
	import devoron.dataui.bindings.DataUIController;
	import devoron.dataui.bindings.DataUIModel;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.decorators.GradientBackgroundDecorator;
	import org.aswing.event.AWEvent;
	import org.aswing.util.HashMap;
	import org.aswing.VectorListModel;
	
	/**
	 * ClipboardSelectionRect
	 * @author Devoron
	 */
	public class ClipboardSelectionRect extends Sprite
	{
		//private var selectionRect:Sprite;
		private var oldX:Number;
		private var oldY:Number;
		private var selectedItems:VectorListModel = new VectorListModel();
		private var desktopFg:Sprite;
		private var oldDecorators:HashMap = new HashMap();
		private var model:DataUIModel;
		private var dataUIController:DataUIController;
		
		public function ClipboardSelectionRect(model:DataUIModel)
		{
			this.model = model;
		
		}
		
		public function onMouseDown(e:MouseEvent):void
		{
			//Main_PRICE2000.tracer("2:dsfdsjkfjsdk");
			//desktop.addChild(selectionRect);
			
			/**/
			graphics.clear();
			//desktop.removeChild(selectionRect);
			
			oldX = e.localX;
			oldY = e.localY;
			//desktop.addChild(selectionRect);
			
			/**/
			graphics.moveTo(e.localX, e.localY);
			
			//desktop.graphics.moveTo
			super.mouseChildren = true;
			super.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			super.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onMouseMove(e:MouseEvent):void
		{
			graphics.clear();
			graphics.moveTo(oldX, oldY);
			graphics.beginFill(0x0E1012, 0.2);
			graphics.lineStyle(1, 0xFFFFFF, 0.4);
			graphics.drawRect(oldX, oldY, e.localX - oldX, e.localY - oldY);
			graphics.endFill();
		}
		
		public function onPaint(e:AWEvent):void
		{
			//drawUnvisibleSprite(desktopFg);
			//addChild(desktopFg);
		}
		
		private function drawUnvisibleSprite(target:Sprite = null):Sprite
		{
			if (target == null)
				target = new Sprite;
			target.graphics.beginFill(0XFFFFFF, 0.001);
			target.graphics.drawRect(super.x, super.y, super.width, super.height);
			target.graphics.endFill();
			return target;
		}
		
		private function clearSelection():void
		{
		/*var size:int = selectedItems.getSize();
		   for (var i:int = 0; i < size; i++)
		   {
		   (selectedItems.get(i) as OperationBox).setSelected(false);
		   }
		 selectedItems.clear();*/
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			/*	clearSelection();
			
			   // циклом перебрать все выделенные контейнеры
			   for each (var item:DisplayObject in operationBoxes)
			   {
			   if (item.hitTestObject(selectionRect))
			   {
			   OperationBox(item).setSelected(true);
			   selectedItems.append(item);
			   }
			
			   //item.scaleX = item.scaleY = 2;
			   }
			 */
			
			for each (var comp:*in model.dataChangeComponents)
			{
				if (comp is SimpleDataComponent)
					continue;
				
				if (comp.visible == true && comp.hitTestObject(this))
				{
					//Main_PRICE2000.tracer("3:selected " + compsAndValues[comp]);
					if (comp is Component)
					{
						//comp.setBackgroundDecorator(new ColorDecorator(new ASColor(0xFFFFFF, 0.2), new ASColor(0xFFFFFF, 0.2), 2));
						//comp.repaint();
						
						var colors:Array = [0XFFFFFF, 0XFFFFFF, 0XFFFFFF, 0XFFFFFF, 0XFFFFFF];
						var alphas:Array = [0.24, 0.14, 0.08, 0.04, 0.01];
						var ratios:Array = [0, 70, 145, 200, 255];
						var matrix:Matrix = new Matrix();
						matrix.createGradientBox(270, 22, 0, 0, 0);
						//oldDecorators.put(comp, (comp.getBackgroundDecorator());
						comp.setBackgroundDecorator(new GradientBackgroundDecorator(GradientBackgroundDecorator.LINEAR, colors, alphas, ratios, matrix, "pad", "rgb", 0, new ASColor(0xFFFFFF, 0), 0));
						comp.repaint();
						
						throw new Error("Определены компоненты для Clipboard через ClipboardSelectionRect. Необходимы дальнейшие действия");
						
					}
						//comp.addActionListener(dataChangeHandler);
						//dataChangeComponents.push(comp);
				}
			}
			
			graphics.clear();
			super.removeEventListener(MouseEvent.MOUSE_OUT, onMouseUp);
			//desktop.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			super.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			//super.removeChild(selectionRect);
			//desktop.removeChild(desktopFg);
		}
	
	}

}