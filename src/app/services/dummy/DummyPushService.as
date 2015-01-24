package app.services.dummy
{
	import app.services.IPushService;

	import org.osflash.signals.Signal;

	public class DummyPushService implements IPushService
	{
		private var _eventSignal:Signal;
		private const REGISTER_SUCCESS:String = "registerSuccess";
		public function DummyPushService()
		{
			_eventSignal = new Signal(String, Object);
		}

		public function unregister():void
		{
		}

		public function register():void
		{
		}

		public function initialize(key:String, gcmSenderKey:String):void
		{
			_eventSignal.dispatch(REGISTER_SUCCESS, {registration_code: ""});
		}

		public function getDeviceToken():String
		{
			return "";
		}

		public function get enable():Boolean
		{
			return false;
		}

		public function set enable(value:Boolean):void
		{
		}

		public function get eventSignal():Signal
		{
			return this._eventSignal;
		}

		public function isSupported():Boolean
		{
			return false;
		}

		public function version():String
		{
			return "";
		}
	}
}
