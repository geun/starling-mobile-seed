package app.services
{
	public interface IDialogService
	{
		function initialize(key:String):void;
		function toast(content:String, duration:int = 0):void;
	}
}
