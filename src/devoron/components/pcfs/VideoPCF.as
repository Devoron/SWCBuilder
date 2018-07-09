package devoron.components.pcfs
{
	import devoron.components.pcfs.PathChooserForm;
	
	/**
	 * VideoPCF
	 *
	 * AVI, QuickTime (MP4/M4V, 3GP/2G2, MOV, QT), 
	 * HDVideo/AVCHD (MTS, M2TS, TS, MOD, TOD), 
	 * WindowsMedia (WMV, ASF, DVR-MS), DVD/VOB, 
	 * VCD/SVCD, MPEG/MPG/DAT, Matroska Video (MKV), 
	 * Real Media Video (RM, RMVB), Flash Video (SWF, FLV), 
	 * DV, AMV, MTV, NUT, H.264/MPEG-4, DivX, XviD, MJPEG
	 *
	 * @author Devoron
	 */
	public class VideoPCF extends PathChooserForm
	{
		
		public function VideoPCF(title:String, listener:Function = null)
		{
			super(title);
			var extension:Array = [];
			extension.push("avi", "mp4", "m4v", "3gp", "2g2", "mov", "qt");
			extension.push("wmv", "asf", "drv-ms", "mkv", "rm", "rmvb", "swf");
			setExtensions(extension);
			setFileSelectionMode(PathChooserForm.FILES_ONLY);
			if (listener != null)
				addActionListener(listener);
		}
	
	}

}