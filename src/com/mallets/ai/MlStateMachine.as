package com.mallets.ai
{
	
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlStateMachine
	{
		private var currentState:IState;
		private var previousState:IState;
		private var nextState:IState;
		
		public function MlStateMachine()
		{
			currentState = null;
			previousState = null;
			nextState = null;
		}
		
		// prepare a state for use after the current state
		public function setNextState(s:IState):void
		{
			nextState = s;
		}
		
		// Update the FSM. Parameter is the frametime for this frame.
		public function update(time:Number):void
		{
			if (currentState)
			{
				currentState.update(time);
			}
		}
		
		// Change to another state
		public function changeState(s:IState):void
		{
			if (currentState)
			{
				currentState.exit();
			}
			
			previousState = currentState;
			currentState = s;
			currentState.enter();
		}
		
		// Change back to the previous state
		public function goToPreviousState():void
		{
			changeState(previousState);
		}
		
		// Go to the next state
		public function goToNextState():void
		{
			changeState(nextState);
		}
	
	}

}