package com.mallets.social 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.external.ExternalInterface;
	import flash.net.navigateToURL;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlSocial 
	{
		public var email_sender:URLLoader;
		public var email_url:String;
		public var email_sent:Boolean = false;
		public var email_status:String;
		
		public function MlSocial() 
		{
			
		}
		
		/**
		 * Open a new browser tab leading to a specific Facebook link
		 * @param	url_to_share
		 * @param	title_of_content
		 */
		public function shareOnFacebook(url_to_share:String, title_of_content:String):void {
			var url_fb:String = "http://www.facebook.com/sharer.php?u=" + url_to_share + "&t=" + title_of_content;
			navigateToURL(new URLRequest(url_fb), "_blank");
		}
		
		/**
		 * Open a new browser tab leading to a specific Twitter message box
		 * @param	original_referer the URL that wants share
		 * @param	text message text
		 * @param	related a @ user related
		 * @param	via the (@) user that shared the link/message
		 */
		public function shareOnTwitter(original_referer:String, text:String, related:String = null, via:String = null):void {
			var url_tw:String = "https://twitter.com/intent/tweet?original_referer=" + original_referer;
			url_tw += "&text=" + text;
			
			if (related)
				url_tw += "&related=" + related;
			
			if (via)
				url_tw += "&via=" + via;
				
			navigateToURL(new URLRequest(url_tw), "_blank");
		}
		
		/**
		 * 
		 * @param	from
		 * @param	to
		 * @param	subject
		 * @param	message
		 */
		public function sendEmail(from:String, to:String, subject:String, message:String):void 
		{
			var email_data:Object = new Object();
			var request:URLRequest = new URLRequest(email_url);
			
			email_data['from'] = from;
			email_data['to'] = to;
			email_data['subject'] = subject;
			email_data['message'] = message;
			
			email_sender.data = email_data;
			email_sender.addEventListener(Event.COMPLETE, _onComplete);
			email_sender.addEventListener(ProgressEvent.PROGRESS, _onProgress);
			email_sender.addEventListener(IOErrorEvent.IO_ERROR, _onIOError);
			email_sender.dataFormat = URLLoaderDataFormat.VARIABLES;
			
			request.method = URLRequestMethod.POST;
			
			email_sender.load(request);
		}
		
		private function _onComplete(evt:Event):void
		{
			email_status = "SENT";
			email_sent = true;
		}
		
		private function _onProgress(evt:ProgressEvent):void
		{
			email_status = "PLEASE WAIT, SENDING...";
			email_sent = false;
		}
		
		private function _onIOError(evt:IOErrorEvent):void
		{
			email_status = "FILE NOT FOUND";
			email_sent = false;
		}
		
		public function getCurrentURL():String
		{
			if (ExternalInterface.available)
			{
				var value:String = ExternalInterface.call("getCurrentURL");
			}
			
			return value;
		}
	}

}