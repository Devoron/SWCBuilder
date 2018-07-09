package devoron.components.filechooser.renderers
{
	import devoron.file.FileInfo;
	import devoron.components.labels.DSLabel;
	import adobe.utils.CustomActions;
	import ascb.filters.ColorMatrixArrays;
	import ascb.util.DateFormat;
	import devoron.components.filechooser.FileChooser;
	import devoron.components.filechooser.FileChooserHelper;
	import devoron.components.filechooser.IFileChooserHelper;
	import flash.display.Bitmap;
	import org.aswing.ASColor;
	import org.aswing.AssetIcon;
	import org.aswing.border.LineBorder;
	import org.aswing.Component;
	import org.aswing.decorators.ColorBackgroundDecorator;
	import org.aswing.decorators.ColorDecorator;
	import org.aswing.ext.Form;
	import org.aswing.ext.GridList;
	import org.aswing.ext.GridListCell;
	import org.aswing.geom.IntDimension;
	import org.aswing.JLabel;
	import org.aswing.JList;
	import org.aswing.ListCell;
	
	public class FileCellRenderer implements ListCell, GridListCell
	{
		public namespace standart;
        public namespace grid;
		
		private static var dateFormatter:DateFormat = new DateFormat("d/m/Y H:i");
		public var selectedBG:ColorDecorator = new ColorDecorator(new ASColor(0x000000, 0.14));
		protected var selectedColor:ASColor = new ASColor(0XFFFFFF, 0.15);
		protected var unselectedColor:ASColor = new ASColor(0XFFFFFF, 0);
		protected var comp:DSLabel;
		
		protected var nameLB:DSLabel;
		protected var modificationDateLB:DSLabel;
		protected var sizeLB:DSLabel;
		private var fi:FileInfo;
		
		private var current:Namespace;
		
		//use namespace grid;
		
		public function FileCellRenderer()
		{
			//use grid;
			current = grid;
			current::paint();
		/*	comp = new Form();
			comp.mouseChildren = false;
			comp.mouseEnabled = true;
			comp.buttonMode = true;
			comp.setPreferredSize(new IntDimension(100, 100));
			nameLB = new DSLabel();
			//nameLB.
			nameLB.setForeground(new ASColor(0XFFFFFF, 0.8));
			modificationDateLB = new DSLabel();
			modificationDateLB.setPreferredWidth(100);
			//modificationDateLB.setForeground(new ASColor(0X363636, 0.8));
			modificationDateLB.setForeground(new ASColor(0xE1E2D6, 0.4));
			sizeLB = new DSLabel();
			sizeLB.setForeground(new ASColor(0X4D4D4D, 0.8));
			comp.addLeftHoldRow(0, nameLB);
			comp.addLeftHoldRow(0, modificationDateLB, 40, sizeLB);*/
			
		}
		
		standart function paint():void {
			/*comp = new Form();
			comp.mouseChildren = false;
			comp.mouseEnabled = true;
			comp.buttonMode = true;*/
			nameLB = new DSLabel();
			nameLB.setForeground(new ASColor(0XFFFFFF, 0.8));
			modificationDateLB = new DSLabel();
			modificationDateLB.setPreferredWidth(100);
			//modificationDateLB.setForeground(new ASColor(0X363636, 0.8));
			modificationDateLB.setForeground(new ASColor(0xE1E2D6, 0.4));
			sizeLB = new DSLabel();
			sizeLB.setForeground(new ASColor(0X4D4D4D, 0.8));
			//comp.addLeftHoldRow(0, nameLB);
			//comp.addLeftHoldRow(0, modificationDateLB, 40, sizeLB);
			
		}
		
		grid function paint():void {
			/*comp = new Form();
			comp.mouseChildren = false;
			comp.mouseEnabled = true;
			comp.buttonMode = true;
			comp.setPreferredSize(new IntDimension(100, 100));
			comp.setSize(new IntDimension(100, 100));
			comp.setMinimumSize(new IntDimension(100, 100));*/
			nameLB = new DSLabel();
			//nameLB.setForeground(new ASColor(0X800040, 0.8));
			//nameLB.setBackgroundDecorator(new ColorBackgroundDecorator(new ASColor(0xFFFF00, 0.2)));			
			modificationDateLB = new DSLabel();
			modificationDateLB.setPreferredWidth(100);
			nameLB.setPreferredSize(new IntDimension(100, 100));
			nameLB.setSize(new IntDimension(100, 100));
			nameLB.setMinimumSize(new IntDimension(100, 100));
			nameLB.setVerticalTextPosition(JLabel.BOTTOM);
			//modificationDateLB.setForeground(new ASColor(0X363636, 0.8));
			modificationDateLB.setForeground(new ASColor(0xE1E2D6, 0.4));
			sizeLB = new DSLabel();
			sizeLB.setForeground(new ASColor(0X4D4D4D, 0.8));
			//comp.addLeftHoldRow(0, nameLB);
			//comp.addLeftHoldRow(0, modificationDateLB, 40, sizeLB);
			//nameLB.setBackground(new ASColor(0x000000, 0.4));
			nameLB.setBackgroundDecorator(selectedBG);
			nameLB.buttonMode = true;
			comp = nameLB;
		}
		
		public function getCellComponent():Component
		{
			if(!comp){
			current::paint();
			}
			return comp;
		}
		
		public function getCellValue():*
		{
			return fi;
		}
		
		public function setCellValue(value:*):void
		{
			gtrace("ПОЛУЧЕННОЕ ЗНАЧЕНИЕ " + value);
			if (!value)
				return;
			fi = FileInfo(value);
			nameLB.setText(fi.name);
			nameLB.setIcon(new AssetIcon(new Bitmap(fi.icons[1])));
			modificationDateLB.setText(dateFormatter.format(fi.modificationDate));
			//sizeLB.setText(String(Math.round((fi.size / 1024) * 100) / 100) + " KB");
			sizeLB.setText(bytesToString(fi.size));
			
			
			// получить от FileChooser'a preview для этого файла
			// если preview нет, то получить от FileChooser'a FileChooserHelper для этого файла
			// подисаться на события от этого FCH
			// если событие FCH_PREVIEW_COMPLETE, то отобразить Icon, которая пришла с событием
			// если событие FCH_PREVIEW_ERROR, то отписаться от FCH и ничего не менять
			// если событие 
			
			
			if(!fi.isDirectory){
			var previewObject:* = FileChooser.cachedPreview.get(fi.nativePath);
			if (!previewObject) {
				var j:int = 0;
				for (var i:int = 0;i < FileChooser.helpers.length; i++) 
				{
					j = 0;
					var exts:Array = FileChooser.helpers[i].getSupportedExtensions();
					
					if (exts.indexOf(fi.extension.toLowerCase()) != -1) {
					var helper:IFileChooserHelper = FileChooser.helpers[i];
					if(helper.isEnabled())
						helper.getPreviewObject(fi, onPreviewObjectComplete);
					}
					else {
					nameLB.setIcon(new AssetIcon(new Bitmap(fi.icons[1])));	
					}
					
				}
			}
			else {
				onPreviewObjectComplete(previewObject);
			}	
			}
			
			
			if (fi.isDirectory)
			{
				sizeLB.setVisible(false);
			}
			else
			{
				sizeLB.setVisible(true);
			}
		}
		
		private function onPreviewObjectComplete(previewObj:* ):void 
		{
			if (!previewObj)
			return;
			nameLB.setIcon(previewObj.icon);
			nameLB.repaint();
			FileChooser.cachedPreview.put(previewObj.path, previewObj);
			//gtrace("4:добавлен в кэш " + object.path);
		}
		
		protected function bytesToString(size:Number):String
		{
			var result:String = "";
			// GB
			if (size >= 1073741824)
			{
				result += String(int(size / 1073741824)) + " GB ";
				size = size % 1073741824;
			}
			
			// MB
			if (size >= 1048576)
			{
				result += String(int(size / 1048576)) + " MB ";
				size = size % 1048576;
			}
			
			// KB с точностью до 2х знаков после запятой
			result += String(Math.round((size / 1024) * 100) / 100) + " KB ";
			return result;
		}
		
		public function setListCellStatus(list:JList, isSelected:Boolean, index:int):void
		{
			current = standart;
			comp.setBorder(new LineBorder(null, isSelected ? selectedColor : unselectedColor, 1, 3));
		}
		
		/* INTERFACE org.aswing.ext.GridListCell */
		
		public function setGridListCellStatus(gridList:GridList, selected:Boolean, index:int):void
		{
			current = grid;
			comp.setBorder(new LineBorder(null, selected ? selectedColor : unselectedColor, 1, 3));
			//comp.setBackground(new ASColor(0x000000, selected ? 0.24 : 0 ));
			//comp.setBackgroundDecorator(selected ? new ColorDecorator(new ASColor(0x000000, 0.14)) : null);
			selectedBG.setColor(selected ? new ASColor(0x000000, 0.14) : new ASColor(0x000000, 0));
			/*if (selected) {
				
			}
			if(comp.getBackgroundDecorator())
			comp.setBackgroundDecorator(selected ? selectedBG : null);*/
		}
	}
}