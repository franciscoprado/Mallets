package examples 
{
	import com.mallets.assets.MlAssets;
	import com.mallets.ui.MlCheckBox;
	import com.mallets.ui.MlListBox;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
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
		public var check:MlCheckBox;
		public var value_selected:TextField;
		
		public function UIComponents() 
		{
			MlAssets.init();
			MlAssets.container = this;
			this.addEventListener(Event.COMPLETE, init);
		}
		
		public function init(evt:Event):void
		{
			list = new MlListBox();
			check = new MlCheckBox("Click here");
			value_selected = new TextField();
			
			list.addItems(['Michael', 'John', 'Mary', 'Ted', 'Will', 'James', 'Lisa']);
			
			// when the listbox has changed its value.
			list.addEventListener(Event.CHANGE, onValueChange);
			list.dispatchEvent(new Event(Event.CHANGE));
			
			// when the checkbox is clicked, will trace its value.
			check.addEventListener(MouseEvent.CLICK, onCheckClick);
			check.x = 500;
			
			value_selected.width = 300;
			value_selected.y = 50;
			
			addChild(value_selected);
			addChild(list);
			addChild(check);
		}
		
		public function onValueChange(evt:Event):void
		{
			value_selected.text = String("Selected: " + list.value).toUpperCase();
		}
		
		public function onCheckClick(evt:MouseEvent):void
		{
			trace("Checkbox value:", check.checked);
		}
		
	}

}