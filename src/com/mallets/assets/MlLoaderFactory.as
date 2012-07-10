package com.mallets.assets 
{
	
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlLoaderFactory 
	{
		
		public function MlLoaderFactory() 
		{
			
		}
		
		public static function getLoaderType(extension:String, source:String, id:String):ILoader {
			var obj:ILoader;
			
			if (extension == "jpg" || extension == "png" || extension == "gif")
			{
				obj = new MlImageLoader(id, source);
			}
			else if (extension == "html" || extension == "txt" || extension == "svg" || extension == "css")
			{
				obj = new MlTextLoader(id, source);
			}
			else if (extension == "xml") 
			{
				obj = new MlXMLLoader(id, source);
			}
			else if (extension == "mp3") 
			{
				obj = new MlSoundLoader(id, source);
			}
			/*else if (extension == "swf") 
			{
				obj = new MlSWFLoader(id, source);
			}
			else if (extension == "css") 
			{
				obj = new MlCSSLoader(id, source);
			}
			else
			{
				obj = new MlBinaryDataLoader(id, source);
			}*/
			
			return obj;
		}
		
	}

}