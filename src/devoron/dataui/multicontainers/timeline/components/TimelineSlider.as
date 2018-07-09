package devoron.components.multicontainers.timeline.components
{
	import devoron.studio.modificators.timeline.TimelineEvent;
	import devoron.studio.modificators.timeline.TimelineLabel;
	import devoron.studio.modificators.timeline.Track;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import org.aswing.ASColor;
	import org.aswing.decorators.ColorDecorator;
	import org.aswing.ext.Form;
	import org.aswing.JList;
	import org.aswing.JScrollBar;
	
	/**
	 * ...
	 * @author Devoron
	 */
	public class TimelineSlider extends JScrollBar
	{
		private var tracks:Array;
		private var tracksForm:JList;
		private var sp:Sprite;
		private var tsbg:TimelineSliderBackgroundDecorator;
		private var label:TimelineLabel;
		
		public function TimelineSlider(orientation:int = 1, value:int = 0, extent:int = 10, min:int = 0, max:int = 100)
		{
			super(orientation, value, extent, min, max);
			
			tsbg = new TimelineSliderBackgroundDecorator(new ASColor(0x80FF80, 0.24), new ASColor(0xFF0000));
			super.setBackgroundDecorator(tsbg);
			
			super.addEventListener(Event.ADDED_TO_STAGE, onStage);
			super.setHeight(20);
			super.setPreferredHeight(20);
		
		}
		
		private function onStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			
			sp = new Sprite();
			//sp.width = tracksForm.getWidth();
			//sp.height = tracksForm.getHeight();
			//sp.width = 1880;
			//sp.height = 40;
			//
			//sp.graphics.lineStyle(1);
			sp.graphics.beginFill(0x80FF00, 0.4);
			sp.graphics.drawRect(0, 0, 1880, 40);
			sp.graphics.endFill();
			stage.addChild(sp);
			gtrace(sp.x, sp.y, sp.width, sp.height);
		
			//gtrace(sp.width);
		
		}
		
		public function setTracks(tracks:Array):void
		{
			this.tracks = tracks;
			tsbg.setTracks(tracks);
		}
		
		public function updateMiniature():void
		{
			gtrace("update miniature " + tracks.length);
			tsbg.update();
		/*sp.graphics.clear();
		
		   for each (var track:Track in tracks)
		   {
		   //gtrace(track.getBounds(tracksForm));
		   var labels:Array = track.getLabels();
		   for each (var label:TimelineLabel in labels)
		   {
		   var labelBounds:Rectangle = label.getBounds(tracksForm);
		   //gtrace(
		   sp.graphics.beginFill(0xFFFFFF, 0.4);
		   sp.graphics.drawRect(labelBounds.x, labelBounds.y, labelBounds.width, labelBounds.height);
		   sp.graphics.endFill();
		   }
		   }
		
		   gtrace("super.getWidth() " + super.getWidth());
		   gtrace("super.getHeight() " + super.getHeight());
		
		   sp.width = super.getWidth();
		   sp.height = super.getHeight();*/
		
		}
		
		override public function updateUI():void
		{
			//super.updateUI();
			setUI(new TimelineScrollBarUI());
		}
		
		public function setTracksForm(tracksForm:JList):void
		{
			this.tracksForm = tracksForm;
			tsbg.setTracksForm(tracksForm);
		}
		
		public function setSelectedLabel(label:TimelineLabel):void
		{
			if (this.label != null)
			{
				this.label.removeEventListener(TimelineEvent.LABEL_CHANGED, onLabelMoved);
			}
			
			label.addEventListener(TimelineEvent.LABEL_CHANGED, onLabelMoved);
			
			this.label = label;
		}
		
		private function onLabelMoved(e:TimelineEvent):void
		{
			//gtrace("ldjasksdj");
			tsbg.update();
		}
	
	}

}