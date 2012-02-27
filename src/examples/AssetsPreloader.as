package examples
{
	import com.mallets.assets.MlAssets;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	
	/**
	 * Mallets - Assets preloader example
	 * @author Francisco Prado
	 */
	public class AssetsPreloader extends Sprite 
	{
		
		public var progress:TextField = new TextField();
		
		public function AssetsPreloader():void 
		{
			/* The MlAssets will get the main.xml file (bin/xml/main.xml)
			and download the assets pointed through the XML nodes. */
			MlAssets.init();
			MlAssets.container = this;
			this.addEventListener(Event.COMPLETE, init);
			this.addEventListener(ProgressEvent.PROGRESS, onProgress);
			
			progress.width = progress.height = 300;
			addChild(progress);
		}
		
		public function init(evt:Event):void {
			progress.text = "ALL DOWNLOADS ARE COMPLETE.";
			
			/* How to get the resource:
			Getting the asset called beach (id = beach) from MlAssets
			and adding to stage. */
			var bmp:Bitmap = new Bitmap(MlAssets.asset.beach);
			bmp.scaleX = bmp.scaleY = 0.5;
			addChildAt(bmp, 0);
		}
		
		public function onProgress(evt:ProgressEvent):void
		{
			progress.text = "Progress: " + Math.round(MlAssets.progress * 100) + "%";
		}
	}
	
}