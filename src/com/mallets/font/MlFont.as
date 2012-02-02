package com.mallets.font 
{
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlFont 
	{
		[Embed(source="../../../../lib/Mallets.ttf", fontName = 'font', mimeType = "application/x-font")]
		private var _font:Class;
		
		public function MlFont() 
		{
			
		}
		
		public static function getFontName():String {
			return "font";
		}
		
	}

}