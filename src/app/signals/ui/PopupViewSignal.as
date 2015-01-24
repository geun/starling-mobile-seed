package app.signals.ui
{
	import org.osflash.signals.Signal;

	public class PopupViewSignal extends Signal
	{
		public function PopupViewSignal()
		{
			super(String, Boolean);
		}
	}
}
