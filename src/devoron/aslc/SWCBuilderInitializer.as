package devoron.aslc
{
	import devoron.aslc.moduls.libraries.SWCBuilderForm;
	import devoron.aslc.moduls.output.OutputForm;
	import devoron.aslc.moduls.project.ProjectsProviderForm;
	import devoron.aslc.SWCBuilder;
	import devoron.dataui.DataContainerForm;
	import devoron.studio.tools.RegistrationFonts;
	import devoron.utils.airmediator.AirMediator;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Capabilities;
	import org.aswing.AsWingManager;
	import org.aswing.paling.PalingLAF;
	import org.aswing.UIManager;
	
	/**
	 * SWCBuilderInitializer
	 * @author Devoron
	 */
	public class SWCBuilderInitializer extends Sprite
	{
		[Embed(source="../../../assets/icons/commons/Hide_arrowRight_pressedImage.png")]
		private var hid:Class;
		private var swcBuilderSprite:Sprite;
		private var swcBuilder:SWCBuilder;
		
		public function SWCBuilderInitializer()
		{
			if (stage)
				init(null);
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		
		}
		
		private function init(e:Event):void
		{
			new RegistrationFonts();
			
			AirMediator.init();
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.frameRate = 60;
			swcBuilderSprite = new Sprite();
			swcBuilderSprite.mouseChildren = true;
			stage.addChild(swcBuilderSprite);
			
			// редактор игры
			AsWingManager.initAsStandard(swcBuilderSprite);
			AsWingManager.setRoot(swcBuilderSprite);
			AsWingManager.setInitialStageSize(Capabilities.screenResolutionX, Capabilities.screenResolutionY);
			
			UIManager.setLookAndFeel(new PalingLAF());
			
			
			// инициализировать AS3LivecodeTool
			initASLCTool();
		}
		
		private function initASLCTool():void
		{
			// инициализировать модули
			var modulComponents:Vector.<DataContainerForm> = initModuls();
			
			// инициализировать оболочку
			swcBuilder = new SWCBuilder(modulComponents);
			swcBuilder.show();
			//swcBuilder.setLocationRelativeTo();
		}
		
		
		private function initModuls():Vector.<DataContainerForm>
		{
			var m:Vector.<DataContainerForm> = new Vector.<DataContainerForm>();
			m.push(new ProjectsProviderForm);
			m.push(new SWCBuilderForm());
			//m.push(new OutputForm());
			return m;
		}
	
	}

}