package com.mallets.ui 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import com.mallets.font.MlFont;
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlListItem extends Sprite
	{
		private var _text_format:TextFormat = new TextFormat();
		private var _text:MlLabel = new MlLabel();
		private var _width:Number;
		private var _height:Number;
		
		public function MlListItem(value:String, item_width:Number, item_height:Number) 
		{
			_width = item_width;
			_height = item_height;
			
			_text_format.font = MlFont.getFontName();
			_text_format.align = TextFormatAlign.LEFT;
			_text_format.size = 15;
			
			graphics.beginFill(0xFFFFFF, 0);
			graphics.drawRect(0, 0, _width, _height);
			graphics.endFill();
			
			_text.text = value;
			_text.setTextFormat(_text_format);
			addChild(_text);
			
			mouseChildren = false;
			buttonMode = true;
		}
		
		public function get value():String {
			return _text.text;
		}
		
		public function showBorder():void
		{
			graphics.clear();
			graphics.beginFill(0xFFFFFF, 0);
			graphics.lineStyle(1, 0x000000);
			graphics.drawRect(0, 0, _width, _height);
			graphics.endFill();
			alpha = 0.7;
		}
		
		public function hideBorder():void
		{
			graphics.clear();
			graphics.beginFill(0xFFFFFF, 0);
			graphics.drawRect(0, 0, _width, _height);
			graphics.endFill();
			alpha = 1;
		}
		
	}

}