package examples 
{
	import com.mallets.keycombo.MlKeyCombo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class KeyboardCombo extends Sprite
	{
		public var output:TextField = new TextField();
		public var combo:MlKeyCombo;
		
		public function KeyboardCombo() 
		{
			combo = new MlKeyCombo(stage, 1000, 6);
			addChild(output);
			
			stage.addEventListener(KeyboardEvent.KEY_UP, checkCombo);
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function checkCombo(evt:KeyboardEvent):void
		{
			if (combo.hasCombo([81, 87, 69]) )
			{
				trace("OK HAS COMBO!");
			}
		}
		
		public function update(evt:Event):void
		{
			output.text = combo.keysPressed.join();
		}
		
	}

}