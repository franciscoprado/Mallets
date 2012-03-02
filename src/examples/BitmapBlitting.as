package examples
{
	import com.mallets.blitting.MlBlitting;
	import com.mallets.assets.MlAssets;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.ProgressEvent;
	import flash.ui.Keyboard;
	
	/**
	 * Using Bitmap Blitting
	 * @author Francisco Prado
	 */
	public class BitmapBlitting extends Sprite 
	{
		private var keys_pressed:Object = new Object();
		private var player:MlBlitting;
		
		public function BitmapBlitting():void 
		{
			MlAssets.init();
			MlAssets.container = this;
			this.addEventListener(Event.COMPLETE, init);
		}
		
		private function init(evt:Event):void 
		{
			player = new MlBlitting(MlAssets.asset.sprite, 8, 4);
			player.x = stage.stageWidth / 2;
			player.y = stage.stageHeight / 2;
			addChild(player);
			
			stage.frameRate = 30;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stage.addEventListener(Event.ENTER_FRAME, movePlayer);
		}
		
		private function onKeyDown(evt:KeyboardEvent):void
		{
			if (!keys_pressed[evt.keyCode])
				keys_pressed[evt.keyCode] = true;
		}
		
		private function onKeyUp(evt:KeyboardEvent):void
		{
			keys_pressed[evt.keyCode] = false;
		}
		
		private function movePlayer(evt:Event):void
		{
			var idle:Boolean = true;
			
			if (keys_pressed[Keyboard.RIGHT])
			{
				player.x += 5;
				player.changeRow(2);
				idle = false;
			}			
			else if (keys_pressed[Keyboard.LEFT])
			{
				player.x -= 5;
				player.changeRow(1);
				idle = false;
			}
			
			if (idle)
			{
				player.changeRow(0);
			}
		}
	}
	
}