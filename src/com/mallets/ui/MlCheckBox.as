package com.mallets.ui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import com.mallets.assets.MlAssets;
	import com.mallets.font.MlFont;
	
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlCheckBox extends Sprite
	{
		private var _label:MlLabel = new MlLabel();
		private var _text_format:TextFormat;
		private var _check:DisplayObject;
		private var _checkbox:DisplayObject;
		private var _is_checked:Boolean = false;
		
		/**
		 * Create a checkbox with a caption
		 * @param	label the text caption of checkbox
		 * @param	text_size the size of text
		 */
		public function MlCheckBox(label:String = "", format:TextFormat = null)
		{
			if (format)
				this._text_format = format;
				
			_setButtons();
			_setLabel(label);
			_setListeners();
		}
		
		private function _setButtons():void
		{
			_check = new Bitmap(MlAssets.asset.check);
			_checkbox = new Bitmap(MlAssets.asset.checkbox);
			
			_check.y = -5;
			
			buttonMode = true;
			mouseChildren = false;
			cacheAsBitmap = true;
			
			addChild(_checkbox);
			addChild(_check);
		}
		
		private function _setLabel(label:String):void
		{
			if (!_text_format)
			{
				_text_format = new TextFormat();
				_text_format.font = MlFont.getFontName();
				_text_format.align = TextFormatAlign.LEFT;
				_text_format.size = 15;
			}
			
			_label.text = label;
			_label.setTextFormat(_text_format);
			_label.x = _checkbox.width + 10;
			addChild(_label);
		}
		
		private function _setListeners():void
		{
			addEventListener(MouseEvent.CLICK, _onClick);
		}
		
		private function _onClick(evt:MouseEvent):void
		{
			if (_is_checked)
				_is_checked = false;
			else
				_is_checked = true;
			
			_check.visible = _is_checked;
		}
		
		public function setTextFormat(text_format:TextFormat):void
		{
			_label.setTextFormat(text_format);
		}
		
		public function set label(text:String):void
		{
			_label.text = text;
		}
		
		public function get label():String
		{
			return _label.text;
		}
		
		/**
		 * Return if it is checked (true) or not (false)
		 */
		public function get checked():Boolean
		{
			return _is_checked;
		}
		
		/**
		 * Set the value of checkbox, true if checked or false, unchecked
		 */
		public function set checked(value:Boolean):void
		{
			_is_checked = value;
			_check.visible = _is_checked;
		}
	}

}