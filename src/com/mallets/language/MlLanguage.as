package com.mallets.language 
{
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlLanguage 
	{
		private static var _language_id:String = "en";
		private static var _languages:Object = new Object();
		
		public function MlLanguage() 
		{
			
		}
		
		/**
		 * Add a new language support for user choice
		 * @param	language_id the id of language (ie: en_us, etc)
		 * @param	language_source the XML with language resource
		 */
		public static function addLanguage(language_id:String, language_source:XML):void
		{
			try
			{
				var lang_object:Object = new Object();
				
				for each(var lang:* in language_source.message) {
					lang_object[lang.@id] = lang;
				}
				
				_languages[language_id] = lang_object;
				_language_id = language_id;
			}
			catch (e:TypeError)
			{
				throw new TypeError();
			}
		}
		
		public static function set standardLanguage(language_id:String):void 
		{
			if (_languages[language_id])
				_language_id = language_id;
		}
		
		public static function get standardLanguage():String 
		{
			return _language_id;
		}
		
		/**
		 * Get the translation of a text. If it was not found, returns the original text
		 * @param	original_text the text to be translated
		 * @return
		 */
		public static function getText(original_text:String):String
		{
			var lang_obj:Object = _languages[_language_id];
			var text:String = original_text;
			
			if (lang_obj && lang_obj[original_text])
				text = lang_obj[original_text];
			
			return text;
		}
		
	}

}