package devoron.sdk.sdkmediator
{
	import devoron.sdk.sdkmediator.adl.ADL;
	import devoron.sdk.sdkmediator.adt.ADT;
	import devoron.sdk.sdkmediator.ascsh.ASCSH;
	import devoron.sdk.sdkmediator.asdoc.ASDoc;
	
	/**
	 * SDKMediatorShell
	 * @author Devoron
	 */
	public class SDKShell
	{
		private var ascShell:ASCSH;
		private var adlShell:ADL;
		private var adtShell:ADT;
		private var asdocShell:ASDoc;
		
		public function SDKShell()
		{
			
		}
		
		public function init():void
		{
		
		}
		
		//**************************************************** Actionscript Compliler Shell Management***************************************
		
		private function startASCSH():void
		{
			try
			{
				ascShell = new ASCSH();
				ascShell.setWorkingDirectory("F:\\Projects\\projects\\flash\\studio\\Studio13");
				ascShell.startShell();
			}
			catch (e:Error)
			{
				gtrace(e);
			}
		}
		
		public function get ascsh():ASCSH
		{
			return ascShell;
		}
		
		//**************************************************** Application Developer Launcher Management***************************************
		
		private function startADL():void
		{
			
			try
			{
				//outputField.setText("");
				//startShell();
				
				adlShell = new ADL();
				adlShell.setWorkingDirectory("F:\\Projects\\projects\\flash\\studio\\Studio13");
				adlShell.startShell();
			}
			catch (e:Error)
			{
				trace(String(e));
					//gtrace("ошбика " + e);
			}
		}
		
		public function get adl():ADL
		{
			return adlShell;
		}
		
		//**************************************************** Application Developer Tool Management***************************************
		
		private function startADT():void
		{
			
			try
			{
				//outputField.setText("");
				//startShell();
				
				adtShell = new ADT();
				//adlShell.setWorkingDirectory("F:\\Projects\\projects\\flash\\studio\\Studio13");
				//adtShell.startShell();
			}
			catch (e:Error)
			{
				trace(String(e));
					//gtrace("ошбика " + e);
			}
		}
		
		public function get adt():ADL
		{
			return adlShell;
		}
		
		//**************************************************** Actionscript Documentation Management***************************************
		
		private function startASDoc():void
		{
			
			try
			{
				//outputField.setText("");
				//startShell();
				
				asdocShell = new ASDoc();
				asdocShell.setWorkingDirectory("F:\\Projects\\projects\\flash\\studio\\Studio13");
				asdocShell.startShell();
			}
			catch (e:Error)
			{
				trace(String(e));
					//gtrace("ошбика " + e);
			}
		}
		
		public function get asdoc():ASDoc
		{
			return asdocShell;
		}
		
		
		
	
	}

}

//class

