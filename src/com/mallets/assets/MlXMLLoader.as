package com.mallets.assets
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlXMLLoader implements ILoader
	{
		private var _loader:URLLoader = new URLLoader();
		private var _bytesTotal:Number = -1;
		private var _init_download:Boolean = false;
		private var _data:XML;
		private var _progress:Number;
		private var _id:String;
		private var _file:String;
		private var _complete:Boolean = false;
		private var _queue:MlLoaderQueue;
		
		/**
		 *
		 * @param	id The id of object.
		 * @param	file_source The path to the file.
		 */
		public function MlXMLLoader(id:String, file_source:String):void
		{
			_id = id;
			_file = file_source;
			
			_loader.load(new URLRequest(_file));
			_setListeners();			
		}
		
		public function init():void
		{
			_loader = new URLLoader();
			_loader.load(new URLRequest(_file));			
			_setListeners();
		}
		
		private function _setListeners():void
		{
			_loader.addEventListener(ProgressEvent.PROGRESS, _onProgress);
			_loader.addEventListener(Event.COMPLETE, _onComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, _onIOError);
		}
		
		private function _onProgress(evt:ProgressEvent):void
		{
			if (!_init_download)
			{
				_bytesTotal = Number(evt.bytesTotal);
				_loader.close();
				_init_download = true;
				
				if (_queue)
					_queue.dispatchEvent(new Event("INFO_COMPLETE"));
			}
			else
			{
				_progress = evt.bytesLoaded / evt.bytesTotal;
				_queue.dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));				
			}
		}
		
		private function _onComplete(evt:Event):void
		{
			_complete = true;
			_data = XML(evt.target.data);
			_queue.dispatchEvent(new Event("START_NEXT_LOADER"));
		}
		
		private function _onIOError(evt:IOErrorEvent):void
		{
			trace("ERROR: the file " + file + " was not found.");
			_queue.remove(this);
		}
		
		public function get progress():Number
		{
			return _progress;
		}
		
		public function get bytesTotal():Number
		{
			return _bytesTotal;
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function get file():String
		{
			return _file;
		}
		
		public function get isComplete():Boolean
		{
			return _complete;
		}
		
		public function set queue(loader_queue:MlLoaderQueue):void
		{
			_queue = loader_queue;
		}
		
		public function getContent():Object
		{
			return _data;
		}
	
	}

}