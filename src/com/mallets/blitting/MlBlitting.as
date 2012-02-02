package com.mallets.blitting
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;	
	import flash.utils.getTimer;

	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlBlitting extends Sprite
	{
		private var _spritesheet:BitmapData;
		private var _canvas:BitmapData;
		private var _rect:Rectangle;
		private var _clear_rect:Rectangle;
		private var _bitmap:Bitmap;
		private var _current_tile:Number = 0;
		private var _tile_width:Number;
		private var _tile_height:Number;
		private var _num_cols:Number;
		private var _num_rows:Number;
		private var _total_tiles:Number;
		private var _current_row:uint = 0;
		private var _action:Object = new Object();
		
		/**
		 * Creates a animated sprite with bitmap data.
		 * @param	sprite_data the bitmap data of sprite
		 * @param	num_cols the number of columns with characters
		 * @param	num_rows the number of rows with characters
		 */
		public function MlBlitting(sprite_data:BitmapData, num_cols:Number, num_rows:Number)
		{
			_spritesheet = sprite_data;
			_num_cols = num_cols;
			_num_rows = num_rows;
			
			_init();
			
			this.addEventListener(Event.ENTER_FRAME, _onEnterFrame);
		}
		
		private function _init():void
		{
			_tile_width = _spritesheet.width / _num_cols;
			_tile_height = _spritesheet.height / _num_rows;
			_total_tiles = _num_rows * _num_cols;
			
			_canvas = new BitmapData(_spritesheet.width, _spritesheet.height, true, 0xFFFFFF);
			_clear_rect = new Rectangle(0, 0, _spritesheet.width, _spritesheet.height);			
			_rect = new Rectangle(0, 0, _tile_width, _tile_height);
			_bitmap = new Bitmap(_canvas);
			_canvas.copyPixels(_spritesheet, _rect, new Point(0, 0));
			
			addChild(_bitmap);
		}
		
		private function _onEnterFrame(evt:Event):void
		{
			_canvas.lock();
			_canvas.fillRect(_clear_rect, 0x000000);
			_render();
			_canvas.unlock();
		}
		
		private function _render():void
		{
			_rect.x = (_current_tile % _num_cols) * _tile_width;
			_rect.y = _current_row * _tile_height;
			_canvas.copyPixels(_spritesheet, _rect, new Point(0, 0), null, null, true);
			_current_tile = ++_current_tile % _total_tiles;
		}
		
		/**
		 * Change the row to be render.
		 * @param	new_row the number of row, from 0 (zero) to (max number of rows - 1),
		 */
		public function changeRow(new_row:uint = 0):void
		{
			if (new_row < _num_rows)
				_current_row = new_row;
		}
		
		/**
		 * Create a associative manner to call a row in the sprite.
		 * @param	name the name of action (ex.: "jump")
		 * @param	row the row number to action.
		 */
		public function addAction(name:String, row:uint):void
		{
			if (row < _num_rows)
				_action[name] = row;
			else
				throw new Error("The row " + row + " does not exist.")
		}
		
		/**
		 * Set a new action (will change the row of sprite)
		 * @param	name name of a existing action.
		 */
		public function setAction(name:String):void
		{
			if (_action[name])
				changeRow(_action[name]);
			else
				throw new Error("The action \"" + name + "\" was not set.")
		}
		
		public override function get width():Number
		{
			return _tile_width;
		}
		
		public override function get height():Number
		{
			return _tile_height;
		}
	}

}