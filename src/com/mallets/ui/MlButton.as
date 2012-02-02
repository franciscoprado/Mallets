package com.mallets.ui 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import com.mallets.assets.MlAssets;
	import com.mallets.font.MlFont;
	
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlButton extends Sprite
	{
		private var _label:MlLabel = new MlLabel();
		private var _text_format:TextFormat = new TextFormat();
		private var _button:DisplayObject;
		private var _button_over:DisplayObject;
		private var _button_down:DisplayObject;
		
		/**
		 * Create a button with a image as background
		 * @param	image the background image of button
		 * @param	label the text of label (caption)
		 * @param	image_over mouse over image, set if you want
		 * @param	image_down mouse down image, set if you want
		 */
		public function MlButton(label:String = "", text_size:Number = 15) 
		{
			_setButtons();
			_setLabel(label, text_size);
			_setListeners();
		}
		
		private function _setLabel(label:String, text_size:Number):void
		{
			_text_format.font = MlFont.getFontName();
			_text_format.align = TextFormatAlign.CENTER;
			_text_format.size = text_size;
			
			_label.text = label;
			_label.width = _button.width;
			_label.y = (_button.height - Number(text_size)) / 4;
			_label.setTextFormat(_text_format);	
			addChild(_label);
		}
		
		private function _setButtons():void
		{
			_button = new Bitmap(MlAssets.asset.button);
			_button_over = new Bitmap(MlAssets.asset.button_over);
			_button_down = new Bitmap(MlAssets.asset.button_down);
			
			mouseChildren = false;
			buttonMode = true;
			cacheAsBitmap = true;
			
			addChild(_button);			
		}
		
		private function _setListeners():void
		{
			if (_button_down)
			{
				addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
				addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			}
			
			if (_button_over)
			{
				addEventListener(MouseEvent.MOUSE_OVER, _onMouseOver);
				addEventListener(MouseEvent.MOUSE_OUT, _onMouseOut);
			}
		}
		
		private function _onMouseOver(evt:MouseEvent):void
		{
			addChild(_button_over);
			addChild(_label);
		}
		
		private function _onMouseOut(evt:MouseEvent):void
		{
			try 
			{
				removeChild(_button_down);
			}
			catch (e:Error)
			{
			}
			
			removeChild(_button_over);
			addChild(_button);
			addChild(_label);
		}
		
		private function _onMouseDown(evt:MouseEvent):void
		{
			addChild(_button_down);
			addChild(_label);
		}
		
		private function _onMouseUp(evt:MouseEvent):void
		{
			try 
			{
				removeChild(_button_down);
			}
			catch (e:Error)
			{
				dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER));
			}
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
	}

}