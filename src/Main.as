package 
{
	import com.mallets.blitting.MlBlitting;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.system.Security;
	import flash.text.TextField;
	import com.mallets.assets.MlAssets;
	import com.mallets.ui.MlListBox;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * Mallets main class
	 * @author Francisco Prado
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			MlAssets.init();
			MlAssets.container = this;
			this.addEventListener("ASSETS_COMPLETE", init);
		}
		
		public function init(evt:Event):void {
			
			for (var i:uint = 0; i <= 100; i++)
			{
				var blit:MlBlitting = new MlBlitting(MlAssets.asset.sprite, 8, 4);
				blit.x = Math.random() * (stage.stageWidth - 50);
				blit.y = Math.random() * (stage.stageHeight - 50);
				blit.addEventListener(MouseEvent.CLICK, onClick);
				addChild(blit);
			}
			
			var monitor:MovieMonitor = new MovieMonitor();
			addChild(monitor);
		}
		
		public function onClick(evt:MouseEvent):void
		{
			trace('click');
		}
	}
	
}