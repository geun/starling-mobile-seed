package app.services.dummy
{
	import app.services.IAlert;

	public class DummyAlert implements IAlert
	{
		public function DummyAlert()
		{
		}

		public function showAlert(title:String, message:String, button1:String = "OK", callback1:Function = null, button2:String = null, callback2:Function = null):void
		{
		}
	}
}
