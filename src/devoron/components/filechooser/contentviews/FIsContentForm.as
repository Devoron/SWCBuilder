package devoron.components.filechooser.contentviews 
{
	import org.aswing.AssetIcon;
	import org.aswing.JButton;
	/**
	 * FIsContentForm
	 * @author Devoron
	 */
	public class FIsContentForm extends BaseFIsContentViewForm
	{
		[Embed(source = "../../../../../assets/icons/FileChooser/content_icon16.png")]
		private var CONTENT_ICON16:Class;
		
		public function FIsContentForm() 
		{
			setName("Content");
			append(createIconButton(new AssetIcon(new CONTENT_ICON16), "Content"));
		}
		
	}

}