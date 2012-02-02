package com.mallets.pathfinding
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlObstacle extends Sprite
	{
		
		public function MlObstacle(size:Number) 
		{
			graphics.beginFill(0xcccccc);
			graphics.drawRect(0, 0, size, size);
			graphics.endFill();
		}
		
	}

}