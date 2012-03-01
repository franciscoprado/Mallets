package examples 
{
	import com.mallets.assets.MlAssets;
	import com.mallets.language.MlLanguage;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	/**
	 * Translating text: example
	 * @author Francisco Prado
	 */
	public class TranslatingText extends Sprite 
	{
		
		public function TranslatingText() 
		{
			MlAssets.init();
			MlAssets.container = this;
			this.addEventListener(Event.COMPLETE, init);
		}
		
		public function init(evt:Event):void
		{
			var message:TextField = new TextField();
			message.width = 500;
			addChild(message);
			
			// Setting Brazilian portuguese (the pt_br.xml file) as default.
			MlLanguage.defaultLanguage = "pt_br";
			
			/* This will show 'Você poderia me ajudar?', which is 
			'Can you help me?' in portuguese. */
			message.text = "From English to Portuguese: " + MlLanguage.getText("Can you help me?");
		}
		
	}

}