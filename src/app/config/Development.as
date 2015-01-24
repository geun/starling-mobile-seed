package app.config
{
	import app.models.Device;
	import app.views.pages.Pages;

	public class Development implements ISetting
	{
		private var _scale:Number = 1.0;
		private var _controlSize:Number = 58;
		private var _gridSize:Number = 88;

		private var _ragularFontSize:int = 30;
		private var _largeFontSize:int = 35;

		private var _defaultLimit:int = 15;
		private var _maxInputSize:int = 700;

		private var _perCatnips:int = 70;

		private var _paddingTop:int = 0;

		private var _currentDevice:app.models.Device;

		private var _googleBase64DecodeKey:String;

		private var _paymentType:String;
		private var _uniqueDeviceID:String;
		private var _deviceInfo:Object;

		public function Development()
		{
		}

		public function get afterSignInPage():String
		{
			return Pages.LIST;
		}

		public function get afterSingUpPage():String
		{
			return Pages.LIST;
		}


		public function get scale():Number
		{
			return _scale;
		}

		public function set scale(value:Number):void
		{
			_scale = value;
		}

		public function get controlSize():Number
		{
			return _controlSize;
		}

		public function set controlSize(value:Number):void
		{
			_controlSize = value;
		}

		public function get gridSize():Number
		{
			return _gridSize;
		}

		public function set gridSize(value:Number):void
		{
			_gridSize = value;
		}

		public function get largeFontSize():int
		{
			return _largeFontSize;
		}

		public function get defaultLimit():int
		{
			return _defaultLimit;
		}

		public function get maxInputSize():int
		{
			return _maxInputSize;
		}

		public function get perCatnips():int
		{
			return _perCatnips;
		}

		public function get paddingTop():int
		{
			return _paddingTop;
		}

		public function set paddingTop(value:int):void
		{
			_paddingTop = value;
		}

		public function get currentDevice():app.models.Device
		{
			return this._currentDevice;
		}

		public function set currentDevice(value:app.models.Device):void
		{
			if(this._currentDevice == value) return;
			this._currentDevice = value;
		}


		public function get googleBase64DecodeKey():String
		{
			return _googleBase64DecodeKey;
		}

		public function set googleBase64DecodeKey(value:String):void
		{
			_googleBase64DecodeKey = value;
		}

		public function get paymentType():String
		{
			return _paymentType;
		}

		public function set paymentType(value:String):void
		{
			_paymentType = value;
		}

		public function get uniqueDeviceID():String
		{
			return this._uniqueDeviceID;
		}

		public function set uniqueDeviceID(value:String):void
		{
			this._uniqueDeviceID = value;
		}

		public function get deviceInfo():Object
		{
			return _deviceInfo;
		}

		public function set deviceInfo(value:Object):void
		{
			_deviceInfo = value;
		}
	}
}
