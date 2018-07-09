package devoron.components.pcfs
{
	import devoron.components.pcfs.PathChooserForm;
	
	/**
	 * XmlPCF
	 * @author Devoron
	 */
	public class XmlPCF extends PathChooserForm
	{
		
		public function XmlPCF(title:String, listener:Function = null)
		{
			super(title);
			setExtensions(["xml"]);
			setFileSelectionMode(PathChooserForm.FILES_ONLY);
			if (listener != null)
				addActionListener(listener);
		}
	
	}

}