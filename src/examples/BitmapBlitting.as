package examples
{
	import com.mallets.blitting.MlBlitting;
	import com.mallets.assets.MlAssets;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	/**
	 * Mallets main class
	 * @author Francisco Prado
	 */
	public class BitmapBlitting extends Sprite 
	{
		
		public function BitmapBlitting():void 
		{
			MlAssets.init();
			MlAssets.container = this;
			this.addEventListener(Event.COMPLETE, init);
			this.addEventListener(ProgressEvent.PROGRESS, onProgress);
		}
		
		public function init(evt:Event):void {
			
			for (var i:uint = 0; i <= 100; i++)
			{
				var blit:MlBlitting = new MlBlitting(MlAssets.asset.sprite, 8, 4);
				blit.x = Math.random() * (stage.stageWidth - 50);
				blit.y = Math.random() * (stage.stageHeight - 50);
				addChild(blit);
			}
		}
		
		public function onProgress(evt:ProgressEvent):void
		{
			trace("Progress:", Math.round(MlAssets.progress * 100));
		}
	}
	
}