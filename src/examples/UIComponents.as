package examples 
{
	import com.mallets.assets.MlAssets;
	import com.mallets.ui.MlLabel;
	import com.mallets.ui.MlListBox;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
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
		public var label:MlLabel;
		
		public function UIComponents() 
		{
			MlAssets.init();
			MlAssets.container = this;
			this.addEventListener(Event.COMPLETE, init);
		}
		
		public function init(evt:Event):void
		{
			label = new MlLabel();
			list = new MlListBox();
			
			label.text = "Value selected: ";
			label.y = 50;
			list.addItems(['Michael', 'John', 'Mary', 'Ted', 'Will', 'James', 'Lisa']);
			
			// when the listbox has changed its value.
			list.addEventListener(Event.CHANGE, onValueChange);
			
			addChild(list);
			addChild(label);
		}
		
		public function onValueChange(evt:Event):void
		{
			label.text = "Value selected: " + list.value;
		}
		
	}

}