package app.services.dummy
{
	import app.services.IApplicationService;

	public class DummyApplicationService implements IApplicationService
	{
		public function initialize(key:String):void
		{
		}

		public function getUniqueID():String
		{
			return "";
		}

		public function visibleiOSStatusBar(show:Boolean = false, animation:String = 'none'):void
		{
		}

		public function getDeviceInfo():Object
		{
			return null;
		}

		public function DummyApplicationService()
		{
		}
	}
}
