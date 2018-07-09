package devoron.components.filechooser
{
	import com.doublefx.as3.thread.api.CrossThreadDispatcher;
	import com.doublefx.as3.thread.api.Runnable;
	import com.doublefx.as3.thread.Thread;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	
	// Don't need to extend Sprite anymore.
	public class SpectrumWorker implements Runnable
	{
		
		/**
		 * Mandatory declaration if you want your Worker be able to communicate.
		 * This CrossThreadDispatcher is injected at runtime.
		 */
		public var dispatcher:CrossThreadDispatcher;
		
		//public static var DEFAULT_LOADER_INFO:LoaderInfo;
		
		// Implements Runnable interface
		public function run(args:Array):void
		{
			dispatcher.dispatchError(new Error("dkfjsdkfjsdkf"));
			//dispatcher.dispatchResult(dispatcher.getSharedProperty("sound"));
			dispatcher.dispatchResult("В рот мне ноги!");
			dispatcher.dispatchProgress(10, 100);
			return;
			
			var bytes:ByteArray = dispatcher.getSharedProperty("soundBytes");
			/*sound = new Sound();
			sound.addEventListener(Event.COMPLETE, completeHandler);*/
			//sound.load(request);
			
			//sound.loadCompressedDataFromByteArray(bytes, bytes.length);
		
			// очистить графику
			//spectrum.graphics.clear();
		
			//spectrum.cacheAsBitmap = true;
		
			
			var bd:BitmapData = new BitmapData(197, 100);
			bd.lock();
			var length:Number = bytes.length;
			
			//sound.extract(bytes, length, 0);
			
			var w:uint = 197;
			var h:uint = 100;
			
			var inc:Number = w / (length / 200);
			var n:Number = 0;
			bytes.position = 0;
			var i:int = 0;
			var xpos:Number = 0;
			
			var spectrum:Sprite = new Sprite();
			var g:Graphics = spectrum.graphics;
			g.lineStyle(1, 0xFF0000, 1);
			//g.lineStyle(1, 0xFFFFFF, .1);
			g.moveTo(0, h * .5);
			
			//spectrumGraphics.
			
			var pos:uint = 0;
			var l:uint = bytes.length;
			var halfH:Number = h * .5;
			
			while (pos < l)
			{
				bytes.position = pos;
				n = (bytes.readFloat() + bytes.readFloat()) * .5;
				
				g.lineTo(xpos, halfH + halfH * n);
				
				//bd.fillRect(new Rectangle(xpos, halfH + halfH * n, 1, 1), 0x000000);
				
				xpos += inc;
				pos += 1600;
			}
			
			bytes.position = 0;
			
			bd.unlock();
			
			/*	var sp:Sprite = new Sprite();
			   sp.graphics.beginFill(0x008080);
			   sp.graphics.drawRect(0, 0, 197, 100);
			   sp.graphics.endFill();*/
			
			bd.draw(spectrum);
			
			var ba:ByteArray = new ByteArray();
			bd.copyPixelsToByteArray(bd.rect, ba);
			//dispatcher.dispatchResult("Количество байт " + bytes.length);
			dispatcher.dispatchResult(ba);
		}
	}
}