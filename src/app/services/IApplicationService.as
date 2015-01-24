package app.services
{
	public interface IApplicationService
	{
		function initialize(key:String):void;
		function getUniqueID():String;
		function visibleiOSStatusBar(show:Boolean = false, animation:String = 'none' ):void;
		function getDeviceInfo():Object;
	}
}
