package com.mallets.sound 
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlSoundPlayer 
	{
		private static var _sounds:Array = new Array();
		
		public function MlSoundPlayer() 
		{
			
		}
		
		public static function addSound(name:String, sound:Sound):void
		{
			if ( !_hasThisSound(name) )
				_sounds.push(new MlSound(name, sound));
			else
				throw new Error("The sound" + name + " already exists.");
		}
		
		public static function play(sound_name:String):void
		{
			if ( _hasThisSound(sound_name) )
			{
				var sound:MlSound = getSoundByName(sound_name);
				sound.play();
			}
		}
		
		public static function stop(sound_name:String):void
		{
			if ( _hasThisSound(sound_name) )
			{
				var sound:MlSound = getSoundByName(sound_name);
				sound.stop();
			}
		}
		
		private static function _hasThisSound(sound_name:String):Boolean
		{
			var val:Boolean = false;
			
			for each(var snd:MlSound in _sounds)
			{
				if (snd.name == sound_name)
				{
					val = true;
					break;
				}				
			}
			
			return val;
		}
		
		public static function getSoundByName(sound_name:String):MlSound
		{
			var sound:MlSound;
			
			for each(var snd:MlSound in _sounds)
			{
				if (snd.name == sound_name)
				{
					sound = snd;
					break;
				}
			}
			
			return sound;
		}
	}

}