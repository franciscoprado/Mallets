package com.mallets.assets
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Security;
	import com.mallets.language.MlLanguage;
	import com.mallets.sound.MlSoundPlayer;
	
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlAssets
	{
		private static var _assets_xml:XML;
		private static var _all_assets:Object = new Object();
		private static var _progress:Number;
		private static var _queue:MlLoaderQueue;
		public static var container:Object;
		
		/**
		 * Start the assets download
		 */
		public static function init():void
		{
			var main_xml_loader:URLLoader = new URLLoader();
			main_xml_loader.addEventListener(Event.COMPLETE, startLoadAssets);
			main_xml_loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			main_xml_loader.load(new URLRequest("xml/assets.xml"));
		}
		
		/**
		 * Start the loading process of resources (assets), like JPGs, MP3, among others.
		 * @param	assets
		 */
		private static function startLoadAssets(evt:Event):void
		{
			_assets_xml = new XML(evt.target.data);
			
			_queue = new MlLoaderQueue();
			
			for each (var asset_name:* in _assets_xml.*.asset)
			{
				var src:String = asset_name.@src;
				var id:String = asset_name.@id;
				var arr:Array = String(src).split(".");
				var file_extension:String = String(arr[arr.length - 1]).toLowerCase();
				var loaderType:ILoader = MlLoaderFactory.getLoaderType(file_extension, src, id);
				_queue.add(loaderType);
			}
			
			_queue.addEventListener(Event.COMPLETE, completeHandler);
			_queue.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			_queue.init();
		}
		
		private static function progressHandler(evt:ProgressEvent):void
		{
			_progress = _queue.progress;
			container.dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
		}
		
		private static function completeHandler(evt:Event):void
		{
			for each(var asset_name:* in _assets_xml.*.asset)
			{
				var src:String = asset_name.@src;
				var id:String = asset_name.@id;
				var arr:Array = String(src).split(".");
				var file_extension:String = String(arr[arr.length - 1]).toLowerCase();
				var asset_data:Object = MlAssetFactory.getAsset(file_extension, _queue.getContent(id));
				
				// add to languages, or not, like a common asset
				if (asset_name.@type == "language") 
					MlLanguage.addLanguage(id, XML(asset_data));
				else if (file_extension == "mp3")
					MlSoundPlayer.addSound(id, Sound(asset_data));
					
				_all_assets[id] = asset_data;
			}
			
			container.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private static function errorHandler(evt:Event):void
		{
			trace("Asset not found: ");
		}
		
		public static function get progress():Number
		{
			return _progress;
		}
		
		/**
		 * get the asset table with all assets
		 */ 
		public static function get asset():Object {
			return _all_assets;
		}
	
	}

}