package com.mallets.blitting 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlTiling extends Bitmap
	{
		private var _width:Number;
		private var _height:Number;
		private var _bitmap_data:BitmapData;
		private var _bitmap:Bitmap;
		
		public function MlTiling(width:Number, height:Number, bitmap_data:BitmapData) 
		{
			this._width = width;
			this._height = height;
			this._bitmap_data = bitmap_data;
			this.cacheAsBitmap = true;
			this.pixelSnapping = PixelSnapping.ALWAYS;
			createTiles();
		}
		
		private function createTiles():void
		{
			if (!_bitmap_data)
				throw new TypeError("BitmapData not found");
				
			var horizontal_limit:Number = Math.floor(_width / _bitmap_data.width);
			var vertical_limit:Number = Math.floor(_height / _bitmap_data.height);
			var _new_data:Sprite = new Sprite();
			
			for (var i:uint = 0; i < _width; i += _bitmap_data.width)
			{
				for (var j:uint = 0; j < _height; j += _bitmap_data.height)
				{
					var bmp:Bitmap = new Bitmap(_bitmap_data);
					bmp.x = i;
					bmp.y = j;
					_new_data.addChild(bmp);
				}
			}
			
			var bdata:BitmapData = new BitmapData(_new_data.width, _new_data.height, true, 0xFFFFFF);
			bdata.draw(_new_data);
			this.bitmapData = bdata;
		}
		
	}

}