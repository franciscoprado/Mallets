package com.mallets.ui 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
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
	public class MlListBox extends Sprite 
	{
		private var _label:MlLabel = new MlLabel();
		private var _listbox:DisplayObject;
		private var _list_items:MlScrollPane;
		private var _image_down:DisplayObject;
		private var _visible:Boolean = false;
		private var _content:Sprite;
		private var _values:Array = new Array();
		private var _list_width:Number;
		private var _list_height:Number;
		private var _text_format:TextFormat = new TextFormat();
		
		public function MlListBox(items:Array = null, text_size:Number = 15) 
		{
			_setButtons();
			_setLabel(text_size);
			_setListeners();
			
			if (items) 
				_updateValues(items);
		}
		
		public function addItems(values:Array):void
		{
			_updateValues(values);
			_label.text = _values[0];
			_label.setTextFormat(_text_format);
			_createList();
		}
		
		private function _updateValues(arr:Array):void
		{
			for each(var value:* in arr)
			{
				_values.push(value);
			}
		}
		
		private function _setButtons():void
		{
			var listbox_bmp:Bitmap = new Bitmap(MlAssets.asset.listbox);
			
			_listbox = new Sprite();
			Sprite(_listbox).addChild(listbox_bmp);
			
			_list_items = new MlScrollPane(180, 100);
			
			cacheAsBitmap = true;
			buttonMode = true;
			
			_list_width = _listbox.width;
			_list_height = _listbox.height;
			
			_list_items.y = _list_height;
			_list_items.visible = _visible;	
			
			Sprite(_listbox).mouseChildren = false;
			Sprite(_listbox).addChild(_label);
			addChild(_listbox);			
		}
		
		private function _setLabel(text_size:Number):void
		{
			_text_format.font = MlFont.getFontName();
			_text_format.align = TextFormatAlign.LEFT;
			_text_format.size = text_size;
			
			_label.x = _list_items.x = 20;
			_label.y = (_listbox.height - Number(_text_format.size)) / 4;			
		}
		
		private function _setListeners():void
		{
			_listbox.addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			_listbox.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			_listbox.addEventListener(MouseEvent.MOUSE_OVER, _onMouseOver);
			_listbox.addEventListener(MouseEvent.MOUSE_OUT, _onMouseOut);
			_list_items.addEventListener(FocusEvent.FOCUS_OUT, _onFocusOut);
		}
		
		private function _createList():void
		{
			if (_content)
				_list_items.removeChild(_content);
			
			_content = new Sprite();
			
			for (var i:uint = 0; i < _values.length; i++ )
			{
				var item:MlListItem = new MlListItem(_values[i], _list_width, _list_height);
				item.y = i * _list_height;
				item.addEventListener(MouseEvent.CLICK, _onItemClick);
				item.addEventListener(MouseEvent.MOUSE_OVER, _onItemOver);
				item.addEventListener(MouseEvent.MOUSE_OUT, _onItemOut);
				_content.addChild(item);
			}
			
			_list_items.addContent(_content);			
		}
		
		private function _onItemClick(evt:MouseEvent):void
		{
			var item:MlListItem = MlListItem(evt.target);
			_label.text = item.value;
			_label.setTextFormat(_text_format);
			_listbox.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		private function _onItemOver(evt:MouseEvent):void
		{
			MlListItem(evt.target).showBorder();
		}
		
		private function _onItemOut(evt:MouseEvent):void
		{
			MlListItem(evt.target).hideBorder();
		}
		
		private function _onMouseOver(evt:MouseEvent):void
		{
			evt.target.alpha = 0.7;
		}
		
		private function _onMouseOut(evt:MouseEvent):void
		{
			evt.target.alpha = 1;
		}
		
		private function _onMouseDown(evt:MouseEvent):void
		{
			addChild(_list_items);
			
			if (_visible)
				_visible = false;
			else 
				_visible = true;
				
			_list_items.visible = _visible;
		}
		
		private function _onFocusOut(evt:Event):void
		{
			_visible = false;
			_list_items.visible = _visible;
			trace('lost focus')
		}
		
		private function _onMouseUp(evt:MouseEvent):void
		{
			
		}
		
		public function get value():String
		{
			return _label.text;
		}
		
		public function get selectedLabel():String
		{
			return _label.text;
		}
	}

}