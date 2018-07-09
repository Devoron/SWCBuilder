package devoron.sdk.sdkmediator.ascsh.commands 
{
	/**
	 * ...
	 * @author ...
	 */
	public class CompcCMD extends CMD
	{
		private var configPath:String;
		private var outputPath:String;
		
		public function CompcCMD(configPath:String, outputPath:String) 
		{
			this.outputPath = outputPath;
			this.configPath = configPath;
			//configPath = "config2.xml";
			//outputPath = "test1.swf";
			//-source-path F:\Projects\projects\flash\studio\Studio13\src\ascsh\ -include-classes CMD -include-sources F:\Projects\projects\flash\studio\Studio13\src\ascsh\CMD.as -external-library-path F:\airglobal.swc -optimize -output AsWing32432.swc
		}
		
		public override function getCode():String {
			//return "compc -load-config=" + configPath + " -o " + ouputPath + "\n"
			
			//var path:String = "F:\\Projects\\projects\\flash\\studio\\Studio13\\src\\ascsh\\";
			//var path:String = "F:\\Projects\\projects\\flash\\studio\\studiolibs\\nochump";
			
			
			
			//return "compc -source-path " + path + " -include-sources " + path +" -external-library-path F:\\airglobal.swc "+ " -optimize -output " + path2 + "\n";
			//return "compc -load-config="+path3+ " -source-path " + path + " -include-sources " + path +" -external-library-path F:\\airglobal.swc "+ " -optimize -output " + path2 + "\n";
			return "compc -load-config+="+configPath +" -output " + outputPath + "\n";
			//return "help";
			
		}
		
		public override function getDesctiption():String {
			return "compc";
		}
		
	}

}