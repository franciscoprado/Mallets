package com.mallets.assets 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.text.StyleSheet;
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlAssetFactory 
	{
		
		public function MlAssetFactory() 
		{
			
		}
		
		/**
		 * 
		 * @param	extension the file extension/type of file
		 * @param	data the content of file
		 * @return
		 */
		public static function getAsset(extension:String, data:Object):Object
		{
			var obj:* = null;
			
			if (data)
			{
				if (extension == "jpg" || extension == "png" || extension == "gif") 
				{
					obj = new BitmapData(data.width, data.height, true, 0xFFFFFF);
					obj.draw(data);
				}
				else if (extension == "xml")
				{
					obj = new XML(data);
				}
				else if (extension == "css")
				{
					obj = new StyleSheet();
					obj.parseCSS(data);
				}
				else if (extension == "mp3")
				{
					obj = data as Sound;
				}
				else if (extension == "txt" || extension == "html" || extension == "svg")
				{
					// THE USE OF SVG LIKE A STRING IS TO REUSE A SAME IMAGE INTO MULTIPLE OBJECTS
					obj = new String(data);
				}
				else 
				{
					obj = data;
				}
			}
			
			return obj;
		}
		
	}

}