package app.config
{
	import app.models.Device;
	public interface ISetting
	{
		function get afterSignInPage():String;
		function get afterSingUpPage():String;

		function get scale():Number;
		function set scale(value:Number):void;
		function get controlSize():Number;
		function set controlSize(value:Number):void;
		function get gridSize():Number;
		function set gridSize(value:Number):void;

		function get defaultLimit():int;
		function get maxInputSize():int;

		function get perCatnips():int;
		function get paddingTop():int;
		function set paddingTop(value:int):void;

//		function get isIos():Boolean;
//		function set isIos(value:Boolean):void;
//
		function get currentDevice():Device;
		function set currentDevice(value:Device):void;

		function get googleBase64DecodeKey():String;
		function set googleBase64DecodeKey(value:String):void;

		function get paymentType():String;
		function set paymentType(value:String):void;

		function get uniqueDeviceID():String;
		function set uniqueDeviceID(value:String):void;

		function get deviceInfo():Object
		function set deviceInfo(value:Object):void

	}
}
