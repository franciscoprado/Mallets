package examples 
{
	import com.mallets.assets.MlAssets;
	import com.mallets.ui.MlListBox;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class UIComponents extends Sprite 
	{
		/* It is important set the type of value here, because
		 * the resources have not been downloaded yet.
		 */
		public var list:MlListBox;
		public var value_selected:TextField;
		
		public function UIComponents() 
		{
			MlAssets.init();
			MlAssets.container = this;
			this.addEventListener(Event.COMPLETE, init);
		}
		
		public function init(evt:Event):void
		{
			value_selected = new TextField();
			list = new MlListBox();
			
			list.addItems(['Michael', 'John', 'Mary', 'Ted', 'Will', 'James', 'Lisa']);
			// when the listbox has changed its value.
			list.addEventListener(Event.CHANGE, onValueChange);
			list.dispatchEvent(new Event(Event.CHANGE));
			
			value_selected.width = 300;
			value_selected.y = 50;
			
			addChild(value_selected);
			addChild(list);
		}
		
		public function onValueChange(evt:Event):void
		{
			value_selected.text = String("Selected: " + list.value).toUpperCase();
		}
		
	}

}