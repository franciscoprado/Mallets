package com.mallets.sound 
{
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlSound
	{
		private var _name:String;
		private var _sound:Sound;
		private var _channel:SoundChannel;
		private var _is_playing:Boolean = false;
		private var _timer:Timer;
		
		public function MlSound(name:String, sound:Sound) 
		{
			_name = name;
			_sound = sound;
		}
		
		private function _onTick(evt:TimerEvent):void
		{
			_is_playing = false;
		}
		
		public function play():void
		{
			_channel = _sound.play();
			_is_playing = true;
			_timer = new Timer(getLength(), 1);
			_timer.addEventListener(TimerEvent.TIMER, _onTick);
		}
		
		public function stop():void
		{
			_channel.stop();
			_is_playing = false;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		/**
		 * Return the length of a sound in seconds or miliseconds
		 * @param	in_seconds to get the length in seconds (true) or miliseconds (false)
		 * @return
		 */
		public function getLength(in_seconds:Boolean = false):Number
		{
			var length:Number;
			
			if (in_seconds)
				length = _sound.length / 1000;
			else
				length = _sound.length;
				
			return length;
		}
		
		public function isPlaying():Boolean
		{
			return _is_playing;
		}
		
	}

}