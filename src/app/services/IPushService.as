package app.services
{
	import org.osflash.signals.Signal;

	public interface IPushService
	{
		function unregister():void;
		function register():void;
		function initialize(key:String, gcmSenderKey:String):void
		function getDeviceToken():String;
		function get enable():Boolean;
		function set enable(value:Boolean):void;

		function get eventSignal():Signal;

		function isSupported():Boolean;
		function version():String;

	}
}