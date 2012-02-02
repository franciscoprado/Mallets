package com.mallets.ui 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlImage extends Sprite 
	{
		private var _description:TextField = new TextField();
		private var _image:DisplayObject;
		
		public function MlImage(image:BitmapData, description:String = "") 
		{
			_description.text = description;
			_image = new Bitmap(image, 'auto', true);
			addChild(_image);
			
			_description.x = 0;
			_description.multiline = true;
			_description.selectable = false;
			_description.y = _image.height;
			
			this.addEventListener(MouseEvent.ROLL_OVER, _onMouseOver);
			this.addEventListener(MouseEvent.ROLL_OUT, _onMouseOut);
		}
		
		private function _onMouseOver(evt:MouseEvent):void {
			if (_description.text)
			{
				addChild(_description);
			}
		}
		
		private function _onMouseOut(evt:MouseEvent):void {
			if (_description.text)
			{
				removeChild(_description);
			}
		}
		
		public function set description(new_description:String):void {
			_description.text = new_description;
		}
		
		public function get description():String {
			return _description.text;
		}
		
	}

}