package devoron.components.filechooser.renderers
{
	import devoron.components.labels.DSLabel;
	import devoron.file.FileInfo;
	import flash.display.Bitmap;
	import flash.filters.ColorMatrixFilter;
	import org.aswing.ASColor;
	import org.aswing.AssetIcon;
	import org.aswing.border.LineBorder;
	import org.aswing.Component;
	import org.aswing.ext.Form;
	import org.aswing.JList;
	import org.aswing.ListCell;

	public class RootDirectoryCellRenderer implements ListCell
	{
		protected var selectedColor:ASColor = new ASColor(0XFFFFFF, 0.15);
		protected var unselectedColor:ASColor = new ASColor(0XFFFFFF, 0);
		protected var comp:Form;
		
		protected var nameLB:DSLabel;
		
		public function RootDirectoryCellRenderer()
		{
			comp = new Form();
			nameLB = new DSLabel();
			nameLB.setForeground(new ASColor(0XFFFFFF, 0.8));
			comp.addLeftHoldRow(0, nameLB);
			comp.buttonMode = true;
		}
		
		public function getCellComponent():Component
		{
			return comp;
		}
		private var rootDirectory:FileInfo;
		
		public function getCellValue():*
		{
			return rootDirectory;
		}
		
		public function setCellValue(value:*):void
		{
			if (!value)
				return;
			rootDirectory = FileInfo(value);
			
			nameLB.setText(rootDirectory.name);
			var bi:Bitmap = new Bitmap(rootDirectory.icons[1]);
			bi.filters = [new ColorMatrixFilter([0.3086, 0.6094, 0.0820, 0, 0, 0.3086, 0.6094, 0.0820, 0, 0, 0.3086, 0.6094, 0.0820, 0, 0, 0, 0, 0, 1, 0])];
			
			nameLB.setIcon(new AssetIcon(bi));
		}
		
		public function setListCellStatus(list:JList, isSelected:Boolean, index:int):void
		{
			comp.setBorder(new LineBorder(null, isSelected ? selectedColor : unselectedColor, 1, 3));
		}
	}
}