package app.models
{
	import flash.system.Capabilities;

	import org.osflash.signals.Signal;

	public class Device
	{
		private var _isIos:Boolean;
		private var _pushEnable:Boolean;

		private var _eventSignal:Signal;

		private var _os:String;
		private var _registraionCode:String;
		private var _isIOS7:Boolean;

		private var _tutorTitmeLimit20:Boolean;

		private var _catnipPush1:Boolean;
		private var _catnipPush2:Boolean;
		private var _catnipPush3:Boolean;
		private var _timeLimitPush1:Boolean;
		private var _timeLimitPush2:Boolean;
		private var _timeLimitPush3:Boolean;

		public static const MOBILE_PUSH_ENABLE:String = 'mobile_push_enable';

		public static const TUTOR_CATNIP_PUSH1:String = "tutor_catnip_push1";
		public static const TUTOR_CATNIP_PUSH2:String = "tutor_catnip_push1";
		public static const TUTOR_CATNIP_PUSH3:String = "tutor_catnip_push1";

		public static const TUTOR_TIME_LIMIT_PUSH1:String = "tutor_time_limit_push1";
		public static const TUTOR_TIME_LIMIT_PUSH2:String = "tutor_time_limit_push2";
		public static const TUTOR_TIME_LIMIT_PUSH3:String = "tutor_time_limit_push3";

		public function Device()
		{
			_eventSignal = new Signal(String, Object);
		}

		public function initialize(registraionCode:String, _pushEnable = true):void
		{
			this._registraionCode = registraionCode;

//			this._pushEnable = true;
//			this._catnipPush1 = false;
//			this._catnipPush2 = false;
//			this._catnipPush3 = false;
//			this._timeLimitPush1 = false;
//			this._timeLimitPush2 = false;
//			this._timeLimitPush3 = false;
		}


		public function get isIos():Boolean
		{
			return _isIos;
		}

		public function set isIos(value:Boolean):void
		{
			_isIos = value;
		}

		public function get pushEnable():Boolean
		{
			return _pushEnable;
		}

		public function set pushEnable(value:Boolean):void
		{
			if(_pushEnable == value) return;
			_pushEnable = value;
			_eventSignal.dispatch(Device.MOBILE_PUSH_ENABLE, value);
		}

		public function get os():String
		{
			return _os;
		}

		public function set os(value:String):void
		{
			_os = value;
		}

		public function get registraionCode():String
		{
			return _registraionCode;
		}

		public function set registraionCode(value:String):void
		{
			_registraionCode = value;
		}

		public function get isIOS7():Boolean
		{
			return _isIOS7;
		}

		public function set isIOS7(value:Boolean):void
		{
			_isIOS7 = value;
		}

		public function get eventSignal():Signal
		{
			return _eventSignal;
		}

		public function get catnipPush1():Boolean
		{
			return _catnipPush1;
		}

		public function set catnipPush1(value:Boolean):void
		{
			if(_catnipPush1 == value) return;
			_catnipPush1 = value;
			_eventSignal.dispatch(Device.TUTOR_CATNIP_PUSH1, value);
		}

		public function get catnipPush2():Boolean
		{
			return _catnipPush2;
		}

		public function set catnipPush2(value:Boolean):void
		{
			if(_catnipPush2 == value) return;
			_catnipPush2 = value;
			_eventSignal.dispatch(Device.TUTOR_CATNIP_PUSH2, value);
		}

		public function get catnipPush3():Boolean
		{
			return _catnipPush3;
		}

		public function set catnipPush3(value:Boolean):void
		{
			if(_catnipPush3 == value) return;
			_catnipPush3 = value;
			_eventSignal.dispatch(Device.TUTOR_CATNIP_PUSH3, value);
		}

		public function get timeLimitPush1():Boolean
		{
			return _timeLimitPush1;
		}

		public function set timeLimitPush1(value:Boolean):void
		{
			trace("Device.timeLimitPush1",value, _timeLimitPush1);
			if(_timeLimitPush1 == value) return;
			_timeLimitPush1 = value;
			_eventSignal.dispatch(Device.TUTOR_TIME_LIMIT_PUSH1, value);
		}

		public function get timeLimitPush2():Boolean
		{
			return _timeLimitPush2;
		}

		public function set timeLimitPush2(value:Boolean):void
		{
			if(_timeLimitPush2 == value) return;
			_timeLimitPush2 = value;
			_eventSignal.dispatch(Device.TUTOR_TIME_LIMIT_PUSH2, value);
		}

		public function get timeLimitPush3():Boolean
		{
			return _timeLimitPush3;
		}

		public function set timeLimitPush3(value:Boolean):void
		{
			if(_timeLimitPush3 == value) return;
			_timeLimitPush3 = value;
			_eventSignal.dispatch(Device.TUTOR_TIME_LIMIT_PUSH3, value);
		}

		public function updateSettings(settings):void
		{
			trace("Device.updateSettings");
			if (settings.time_limit_push1)
			{
				trace("Device.updateSettings", settings.time_limit_push1);
				this.timeLimitPush1 = this.converBoolean(settings.time_limit_push1);
			}
			if (settings.time_limit_push2)
			{
				this.timeLimitPush2 = this.converBoolean(settings.time_limit_push2);
			}
			if (settings.time_limit_push3)
			{
				this.timeLimitPush3 = this.converBoolean(settings.time_limit_push3);
			}
			if (settings.catnip_push1)
			{
				this.catnipPush1 = this.converBoolean(settings.catnip_push1);
			}
			if (settings.catnip_push2)
			{
				this.catnipPush2 = this.converBoolean(settings.catnip_push2);
			}
			if (settings.catnip_push3)
			{
				this.catnipPush3 = this.converBoolean(settings.catnip_push3);
			}
		}

		private function converBoolean(input):Boolean
		{
			return input == "true" ? true : false
		}


	}
}
