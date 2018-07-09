package devoron.components.pcfs
{
	import devoron.components.pcfs.PathChooserForm;
	
	/**
	 * AS3CodePCF
	 * @author Devoron
	 */
	public class AS3CodePCF extends PathChooserForm
	{
		
		public function AS3CodePCF(title:String, listener:Function = null)
		{
			super(title);
			setExtensions(["as3"]);
			setFileSelectionMode(PathChooserForm.FILES_ONLY);
			if (listener!=null)
				addActionListener(listener);
		}
	
	}

}