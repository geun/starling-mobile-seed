package app.services
{
	import org.osflash.signals.Signal;

	public interface IIAPService
	{
		function initialize(key:String):void;

		function get eventSignal():Signal;
		function get stroeItemList():*;
		function makePurchase( productId:String, developPayload:String ):void;
		function makeConsume( productId:String, developPayload:String ):void;

		function setup(key:String):void;

	}
}
