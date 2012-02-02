package com.mallets.tween 
{
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlTween 
	{
		
		public function MlTween() 
		{
			
		}
		
		public static function to(target:Object, duration:Number, vars:Object):void
		{
			target.y = vars.y;
		}
		
	}

}