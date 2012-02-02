package com.mallets.assets
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlLoaderQueue extends EventDispatcher
	{
		private var _queue:Array = new Array();
		private var _total_loaders:uint = 0;
		private var _bytesTotal:Number;
		private var _bytesLoaded:Number;
		private var _current:uint = 0;
		private var _with_info_complete:uint = 0;
		private var _current_loader:ILoader;
		private var _total_bytes_to_load:Number = 0;
		private var _total_bytes_loaded:Number = 0;
		private var _total_progress:Number = 0;
		
		public function MlLoaderQueue()
		{
			this.addEventListener(Event.COMPLETE, _onAllComplete);
			this.addEventListener(ProgressEvent.PROGRESS, _onProgress);
			this.addEventListener("INFO_COMPLETE", _onInfoComplete);
			this.addEventListener("START_NEXT_LOADER", _onLoaderComplete);
		}
		
		public function init():void
		{
			if (_total_loaders > 0)
			{
				_current_loader = _queue[_current];
			}
		}
		
		public function add(loader:ILoader):void
		{
			if (!_contains(loader))
			{
				loader.queue = this;
				_queue.push(loader);
				_total_loaders++;
			}
		}
		
		private function _onAllComplete(evt:Event):void
		{
			
		}
		
		private function _onLoaderComplete(evt:Event):void
		{
			_startNext();
		}
		
		private function _onInfoComplete(evt:Event):void
		{
			_with_info_complete++;
			_checkAllInfoComplete();
		}
		
		private function _checkAllInfoComplete():void
		{
			if (_with_info_complete == _total_loaders)
			{
				_defineTotalBytes();
				_current_loader.init();
			}
		}
		
		private function _defineTotalBytes():void
		{
			for each(var loader:ILoader in _queue)
			{
				_total_bytes_to_load += loader.bytesTotal;
			}
		}
		
		private function _onProgress(evt:ProgressEvent):void
		{
			_total_progress = _total_bytes_loaded / _total_bytes_to_load;
		}
		
		private function _startNext():void
		{
			_total_bytes_loaded += _current_loader.bytesTotal;
			_current++;
			
			if (_queue[_current])
			{
				_current_loader = _queue[_current];
				_current_loader.init();
			}
			else {
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		private function _contains(loader:ILoader):Boolean
		{
			for each (var ld:ILoader in _queue)
			{
				if (ld.id == loader.id)
				{
					return true;
					break;
				}
			}
			
			return false;
		}
		
		public function get progress():Number
		{
			return _total_progress;
		}
		
		public function getContent(content_id:String):Object
		{
			var obj:Object;
			
			for each(var loader:ILoader in _queue)
			{
				if (loader.id == content_id)
				{
					obj = loader.getContent();
					break;
				}
			}
			
			return obj;
		}
	}

}