package com.mallets.ai 
{
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlSampleState implements IState 
	{
		private var fsm:MlStateMachine;
		
		public function MlSampleState() 
		{
			
		}
		
		public function enter():void
		{
			trace('ENTER STATE');
		}
		
		public function exit():void
		{
			trace('EXIT STATE');
		}
		
		public function update(time:Number):void
		{
			trace('UPDATE STATE');
		}
		
	}

}