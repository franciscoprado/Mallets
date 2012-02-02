package com.mallets.ui 
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import com.mallets.font.MlFont;
	
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlLabel extends TextField 
	{
		private var _text_format:TextFormat = new TextFormat();
		
		public function MlLabel() 
		{
			this.autoSize = TextFieldAutoSize.LEFT;
			this.wordWrap = true;
			this.selectable = false;
			this.multiline = false;
			this.embedFonts = true;
			
			_text_format.font = MlFont.getFontName();
			_text_format.align = TextFormatAlign.LEFT;
			
			this.setTextFormat(_text_format);
		}
		
	}

}