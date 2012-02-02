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
	import flash.display.Sprite;
	import flash.events.Event;
	import com.mallets.ui.MlListBox;
	
	/**
	 * Mallets main class
	 * @author Francisco Prado
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			MlAssets.init("xml/assets.xml");
			MlAssets.container = this;
			this.addEventListener("ASSETS_COMPLETE", init);
		}
		
		public function init(evt:Event):void {
			var list:MlListBox = new MlListBox();
			list.addItems(['a', 'b', 'c','a', 'b', 'c','a', 'b', 'c']);
			addChild(list);
		}
	}
	
}