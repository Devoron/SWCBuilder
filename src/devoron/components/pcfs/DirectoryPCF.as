package devoron.components.pcfs
{
	import devoron.components.pcfs.PathChooserForm;
	
	/**
	 * DirectoryPCF
	 * @author Devoron
	 */
	public class DirectoryPCF extends PathChooserForm
	{
		
		public function DirectoryPCF(title:String, listener:Function = null)
		{
			super(title);
			setExtensions(["dir"]);
			setFileSelectionMode(PathChooserForm.DIRECTORIES_ONLY);
			if (listener != null)
				addActionListener(listener);
		}
	
	}

}