package com.mallets.keycombo 
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlKeyCombo 
	{
		private var container:Stage;
		private var keys_limit:uint;
		private var timer:Timer;
		private var keys_pressed:Array = new Array();
		
		public function MlKeyCombo(container:Stage, delay:Number = 1000, keys_limit:uint = 4) 
		{
			this.container = container;
			this.keys_limit = keys_limit;
			
			timer = new Timer(delay, 0);
			timer.start();
			
			timer.addEventListener(TimerEvent.TIMER, onTick);
			container.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			container.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function onKeyDown(evt:KeyboardEvent):void
		{
			addKey(evt.keyCode);
			
			if (keys_pressed.length == 1)
			{
				timer.stop();
				timer.start();
			}
		}
		
		private function onKeyUp(evt:KeyboardEvent):void
		{
			if (keys_pressed.length == keys_limit)
				removeFirst();
			//removeKey(evt.keyCode);
		}
		
		public function get keysPressed():Array
		{
			return this.keys_pressed;
		}
		
		private function onTick(evt:TimerEvent):void
		{
			removeFirst();
		}
		
		private function addKey(key:uint):void
		{
			if (keys_pressed.length == keys_limit)
				removeFirst();
			
			keys_pressed.push(key);
		}
		
		private function removeFirst():void
		{
			var new_array:Array = [];
			
			for (var i:uint = 1; i < keys_pressed.length; i++)
			{
				new_array.push(keys_pressed[i]);
			}
			
			keys_pressed = new_array;
		}
		
		private function removeKey(key:uint):void
		{
			if (keys_pressed.indexOf(key))
			{
				var new_array:Array = [];
				
				for (var i:uint; i < keys_pressed.length; i++)
				{
					if (keys_pressed[i] != key)
					{
						new_array.push(keys_pressed[i]);
					}
				}
				
				keys_pressed = new_array;
			}
		}
		
		public function hasCombo(combo_keys:Array):Boolean
		{
			var query:String = combo_keys.join();
			var pressed:String = keys_pressed.join();
				
			if (pressed.indexOf(query) != -1)
			{
				keys_pressed = [];
				return true;
			}
			
			return false;
		}
		
		public function destroy():void
		{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, onTick);
			timer = null;
			keys_pressed = null;
		}
		
	}

}