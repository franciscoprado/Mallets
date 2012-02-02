package com.mallets.assets 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public interface ILoader
	{
		function init():void;
		function get bytesTotal():Number;
		function get progress():Number;
		function get id():String;
		function get file():String;
		function get isComplete():Boolean;
		function set queue(loader_queue:MlLoaderQueue):void;
		function getContent():Object
	}
	
}