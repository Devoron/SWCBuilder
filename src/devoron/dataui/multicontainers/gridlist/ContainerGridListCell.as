/*
   Copyright aswing.org, see the LICENCE.txt.
 */

package devoron.dataui.multicontainers.gridlist
{
	import devoron.data.core.base.IDataContainer;
	import devoron.dataui.DataContainerForm;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import net.kawa.tween.easing.Linear;
	import net.kawa.tween.KTween;
	import org.aswing.ASColor;
	import org.aswing.border.LineBorder;
	import org.aswing.Component;
	import org.aswing.ext.GridList;
	import org.aswing.ext.GridListCell;
	import org.aswing.geom.IntDimension;
	import org.aswing.JLabel;
	
	/**
	 * The default grid list cell render value.toString() as texts.
	 *
	 */
	public class ContainerGridListCell extends JLabel implements GridListCell
	{
		private var selected:Boolean;
		
		protected var value:*;
		
		public function ContainerGridListCell()
		{
			super();
			setOpaque(true);
			//setBackground(new org.aswing.ASColor);
			/*	setPreferredWidth(64);
			   setPreferredHeight(64);
			   setSize(new IntDimension(64, 64));
			 setMinimumSize(new IntDimension(64, 64));*/
			setVerticalAlignment(JLabel.CENTER);
			setHorizontalAlignment(JLabel.CENTER);
			
			buttonMode = true;
			//setBorder(new LineBorder(null, new ASColor(0xFFFFFF, 0.44), 1, 2));
			
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			alpha = 0.24;
		}
		
		private function onRollOut(e:MouseEvent):void
		{
			if (selected)
				alpha = 0.75;
			else
				KTween.to(this, 0.25, {alpha: 0.34}, Linear.easeIn).init();
		
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
			KTween.to(this, 0.25, {alpha: 0.75}, Linear.easeIn).init();
		}
		
		public function setCellValue(value:*):void
		{
			this.value = value;
			//setText(value.dataContainerName + "");
			//gtrace("2:value.name " + value.dataContainerName + " " + value.dataContainerType);
			setIcon((value as IDataContainer).dataContainerIcon);
			//setIcon((value as DataContainerForm).icon);
		}
		
		public function getCellValue():*
		{
			return value;
		}
		
		public function getCellComponent():Component
		{
			return this;
		}
		
		public function setGridListCellStatus(gridList:GridList, selected:Boolean, index:int):void
		{
			this.selected = selected;
			if (selected)
			{
				setBackground(new ASColor(0x000000, 0.14));
				//setB
				//getBorder().getDisplay(gridList).filters = [new GlowFilter(0xFFFFFF, 0.8, 6, 6, 2, 2, true)];
				
				setBorder(new LineBorder(null, new ASColor(0xFFFFFF, 0.24), 1, 2));
					//alpha = 0.24;
			}
			else
			{
				//setBackground(new ASColor(0XFFFFFF, 0.08));
				setBackground(new ASColor(0XFFFFFF, 0));
				//getBorder().getDisplay(gridList).filters = null;
				
				setBorder(new LineBorder(null, new ASColor(0xFFFFFF, 0), 1, 2));
				
					//setBorder(new LineBorder(null, new ASColor(0xFFFFFF, 0.24), 1, 2));
			}
		
		}
	
	}
}