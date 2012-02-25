package com.mallets.assets
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.display.Loader;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlSoundLoader implements ILoader
	{
		private var _loader:Sound = new Sound();
		private var _bytesTotal:Number = -1;
		private var _init_download:Boolean = false;
		private var _data:Sound;
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
		/**
		 *
		 * @param	id The id of object.
		 * @param	file_source The path to the file.
		 */
		public function MlSoundLoader(id:String, file_source:String):void
		{
			_id = id;
			_file = file_source;
			
			_loader.load(new URLRequest(_file));
			_setListeners();			
		}
		
		public function init():void
		{
			_loader = new Sound();
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
			_data = _loader;
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