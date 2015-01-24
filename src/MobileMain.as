package
{
	import app.AppMain;

	import flash.display.Sprite;
	import flash.events.Event;


	[SWF(frameRate="60", backgroundColor="0xFFFFFF")]
	public class MobileMain extends Sprite
	{
		public function MobileMain()
		{
			super();
			this.loaderInfo.addEventListener(Event.COMPLETE, loadCompleteHandler);
		}

		private function loadCompleteHandler(e:Event):void
		{
			var app:AppMain = new AppMain();
			this.addChild(app);
		}

	}
}
