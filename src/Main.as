package 
{
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
			
		}
	}
	
}