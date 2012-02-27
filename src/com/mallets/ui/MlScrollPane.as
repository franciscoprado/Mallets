package com.mallets.ui 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import com.mallets.assets.MlAssets;
	
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlScrollPane extends Sprite 
	{
		
		private var _bar:DisplayObject;
		private var _mask:Sprite = new Sprite();
		private var _pane:DisplayObject;
		private var _content:DisplayObject;
		private var _border:DisplayObject;
		private var _pane_width:Number;
		private var _pane_height:Number;
		private var _bar_width:Number;
		private var _bar_height:Number;
		private var _tick:Timer = new Timer(24);
		
		/**
		 * Create a scroll pane, with features like a scroll bar and mouse wheel support.
		 * @param	pane_width The width of content
		 * @param	pane_height The height of content
		 * @param	bar_width The width of scroll bar
		 * @param	bar_height The height of scroll bar
		 */
		public function MlScrollPane(pane_width:Number, pane_height:Number, with_border:Boolean = true, content:DisplayObject = null) {
			_pane_width = pane_width;
			_pane_height = pane_height;
			
			_setButtons();
			_defineSizes();
			_addAllObjectsToStage();
			_createMask();
			
			if (with_border)
				_setBorder();
		}
		
		private function _setButtons():void
		{
			var pane_bmp:Bitmap = new Bitmap(MlAssets.asset.pane);
			var bar_bmp:Bitmap = new Bitmap(MlAssets.asset.scrollbar);
			
			_pane = new Sprite();
			_bar = new Sprite();
			Sprite(_pane).addChild(pane_bmp);
			Sprite(_bar).addChild(bar_bmp);
			Sprite(_bar).buttonMode = true;
		}
		
		private function _setBorder():void 
		{
			_border = new Sprite();
			Sprite(_border).graphics.lineStyle(1);
			Sprite(_border).graphics.drawRect(0, 0, _pane_width - _bar_width, _pane_height);
		}
		
		public function addContent(content:DisplayObject):void {
			if(_content) removeChild(_content);			
			if (!content) content = new Sprite();
			
			_content = content;
			_content.mask = _mask;
			
			_addAllObjectsToStage();
			
			_setListeners();
			
			_tick.start();
		}
		
		private function _defineSizes():void
		{
			_bar_width = _bar.width;
			_bar_height = _bar.height;
			_pane.x = _pane_width;
			_pane.height = _pane_height;			
			_bar.y = _pane.y = 0;
		}
		
		private function _addAllObjectsToStage():void
		{
			addChild(_pane);
			addChild(_mask);
			addChild(_bar);
			
			if (_content) addChild(_content);
			if (_border) addChild(_border);
		}
		
		private function _createMask():void
		{
			_bar.x = _pane_width - (_bar_width / 2);
			_mask.graphics.beginFill(0xFF0000);
			_mask.graphics.drawRect(0, 0, _pane_width - _bar_width, _pane_height);
			_mask.graphics.endFill();
			_mask.x = _mask.y = 2;
		}
		
		private function _drag(evt:MouseEvent):void {
			Sprite(_bar).startDrag(false, new Rectangle(_pane_width - (_bar_width / 2), 0, 0, _pane_height - _bar_height));
			stage.addEventListener(MouseEvent.MOUSE_UP, _drop );
		}
		
		private function _drop(evt:MouseEvent):void {
			Sprite(_bar).stopDrag();
		}
		
		private function _mouseWheel(evt:MouseEvent):void {
			var roll:Number = evt.delta * 15;
			var trajectory:Number = _bar.y - roll;
			
			if (trajectory > 0 && trajectory < (_pane_height - _bar_height) ){
				_bar.y = trajectory;
			}
			else if (trajectory > (_pane_height - _bar_height) ) {
				_bar.y = _pane_height - _bar_height;
			}
			else if (trajectory < 0) {
				_bar.y = 0;
			}
		}
		
		private function _scroll(evt:TimerEvent):void {
			if (_bar.y == 0) { 
				_content.y = 0;
			}
			
			if(_content.height > _pane_height){
				var pct:Number = (_bar.y) / (_pane_height - _bar_height);
				var limit:Number = _pane_height - _content.height;
				var trajectory:Number = limit * pct;
				
				_content.y = trajectory;
				_bar.visible = true;
			}
			else {
				_bar.visible = _pane.visible = false;
			}
		}
		
		private function _setListeners():void {
			_bar.addEventListener(MouseEvent.MOUSE_DOWN, _drag );
			_bar.addEventListener(MouseEvent.MOUSE_UP, _drop );
			_tick.addEventListener(TimerEvent.TIMER, _scroll);
			addEventListener(MouseEvent.MOUSE_WHEEL, _mouseWheel);
		}
		
	}

}