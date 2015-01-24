package app.services
{
	public interface IAlert
	{
		function showAlert(title:String,message:String, button1:String = "OK", callback1:Function = null, button2:String = null, callback2:Function = null):void;
	}
}
