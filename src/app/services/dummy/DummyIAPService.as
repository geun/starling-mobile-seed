package app.services.dummy
{
	import app.services.IIAPService;

	import org.osflash.signals.Signal;

	public class DummyIAPService implements IIAPService
	{

		private var _eventSignal:Signal;
		public function DummyIAPService()
		{
			_eventSignal = new Signal(String, Object);
		}

		public function initialize(key:String):void
		{
		}

		public function get eventSignal():Signal
		{
			return this._eventSignal;
		}

		public function get stroeItemList():*
		{
			return null;
		}

		public function makePurchase(productId:String, developPayload:String):void
		{
		}

		public function makeConsume(productId:String, developPayload:String):void
		{
		}

		public function setup(key:String):void
		{
		}
	}
}
