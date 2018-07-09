package devoron.sdk.aslc.core.utils 
{
	import devoron.utils.airmediator.AirMediator;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Devoron
	 */
	public class ConfigurationMaker 
	{
		
		public function ConfigurationMaker() 
		{
			
		}
		
		public static function createConfigFile(outputPath:String, sources:Vector.<String>, classNames:Vector.<String>):String {
			var str:String = '<?xml version="1.0" encoding="utf-8"?>\n';
			str +="<flex-config>\n";
			str +="	<compiler>\n";
			str +="		<as3>true</as3>\n";
			str +="		<optimize>false</optimize>\n";
			str +="		<strict>false </strict>\n";
			//str +="		<debug>false</debug>\n";
			str +="		<external-library-path>\n";
			str +="			<path-element>F:\\airglobal.swc</path-element>\n";
			str +="		</external-library-path>\n";
			str += "		<source-path>\n";
			
			for each (var classPath:String in sources) 
			{
				str +="			<path-element>"+classPath+"</path-element>\n";
			}
			
			
			
			//str +="			<path-element>F:\\Projects\\projects\\flash\\studio\\studiolibs\\</path-element>\n";
			str +="		</source-path>\n";
			str +="	</compiler>\n";
			str += "	<include-classes>\n";
			
			for each (var className:String in classNames) 
			{
				str +="		<class>"+className+"</class>\n";
			}
			
			
			str +="	</include-classes>\n";
			//str +="	<output>score-ranking-as3.swc</output>\n";
			str += "</flex-config>\n";
			
			
			return str;

		}
		
	}

}