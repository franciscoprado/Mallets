package com.mallets.ai
{
	
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public interface IState
	{
		function enter():void; // called on entering the state
		function exit():void; // called on leaving the state
		function update(time:Number):void;
	}

}