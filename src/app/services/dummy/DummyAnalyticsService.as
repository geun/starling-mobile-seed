package app.services.dummy
{
	import app.services.IAnalyticsService;

	public class DummyAnalyticsService implements IAnalyticsService
	{
		public function DummyAnalyticsService()
		{
		}

		public function initialize(analyticsId:String, uuid:String):void
		{
		}

		public function trackView(viewName:String):void
		{
		}

		public function trackEvent(category:String, eventName:String):void
		{
		}

		public function trackTapButton(labelName:String):void
		{
		}

		public function trackException():void
		{
		}
	}
}
