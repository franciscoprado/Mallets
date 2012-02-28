package examples 
{
	import com.mallets.assets.MlAssets;
	import com.mallets.sound.MlSoundPlayer;
	import com.mallets.ui.MlButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * Tutorial teaching how to manipulate sounds.
	 * @author Francisco Prado
	 */
	public class TestSound extends Sprite 
	{
		
		public function TestSound() 
		{
			MlAssets.init();
			MlAssets.container = this;
			this.addEventListener(Event.COMPLETE, init);
		}
		
		public function init(evt:Event):void
		{
			/* This buttons will control the sound. 
			Playing, pausing or stopping a song called "track" (see assets.xml file). */
			var play_button:MlButton = new MlButton("PLAY");
			var pause_button:MlButton = new MlButton("PAUSE");
			var stop_button:MlButton = new MlButton("STOP");
			
			pause_button.x = play_button.width + 10;
			stop_button.x = stop_button.width + pause_button.x + 10;
			
			addChild(play_button);
			addChild(pause_button);
			addChild(stop_button);
			
			play_button.addEventListener(MouseEvent.CLICK, playSound);
			pause_button.addEventListener(MouseEvent.CLICK, pauseSound);
			stop_button.addEventListener(MouseEvent.CLICK, stopSound);
		}
		
		private function playSound(evt:MouseEvent):void
		{
			MlSoundPlayer.play("track");
		}
		
		private function pauseSound(evt:MouseEvent):void
		{
			MlSoundPlayer.pause("track");
		}
		
		private function stopSound(evt:MouseEvent):void
		{
			MlSoundPlayer.stop("track");
		}
	}

}