package devoron.values.font
{
	import devoron.data.core.base.DataStructurObject;
	import flash.utils.flash_proxy;
	import org.aswing.ASFont;
	
	use namespace flash_proxy;
	
	public dynamic class ASFontValue extends DataStructurObject
	{
		public var type:String = "ASFont";
		
		public function ASFontValue(sourceFont:ASFont = null)
		{
			super();
			if (sourceFont)
			{
				this["name"] = sourceFont.getName();
				this["size"] = sourceFont.getSize();
				this["underline"] = sourceFont.isUnderline();
				this["italic"] = sourceFont.isItalic();
				this["bold"] = sourceFont.isBold();
				this["embeds"] = sourceFont.isEmbedFonts();
				dataName = "ASFont";
				dataType = "font";
					//gtrace
					//setDataToContainer(data);
			}
		}
		
		override public function toString():String{
			var sd:String = super.toString();
			return super.toString();
		}
		
		override public function clone(targetClass:Class = null):DataStructurObject 
		{
			return super.clone(ASFontValue);
		}
		
		public function getName():String
		{
			return this["name"];
		}
	
	}

}