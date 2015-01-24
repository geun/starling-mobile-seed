package app.services
{
	public interface IAnalyticsService
	{
		function initialize(analyticsId:String, uuid:String):void;
		function trackView(viewName:String):void;
		function trackEvent(category:String, eventName:String):void;
		function trackTapButton(labelName:String):void;
		function trackException():void;
	}
}
