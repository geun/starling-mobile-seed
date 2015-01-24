package robotlegs.extensions.starlingViewMap.api
{
	public interface IStarlingViewBase 
	{

		function setup():void;
		function destory():void;
		function invalidLayout():void;
		function onEnterView():void;
		function onExitView():void;
	}
}