package app.views.base
{
	import app.config.ISetting;

	import feathers.controls.Screen;
	import feathers.events.FeathersEventType;

	import flash.ui.Keyboard;

	import org.osflash.signals.Signal;

	import robotlegs.extensions.starlingViewMap.api.IStarlingViewBase;

	import starling.events.KeyboardEvent;

	public class ScreenBase extends Screen implements IStarlingViewBase
	{
		public static const SETTING_UPDATED:String = "screen-setting-update";

		public static const EVENT_KEYBOARD_DISPATCHED:String = "event-keyboard-dispatched";

		protected var _setting:ISetting;

		public var onEnterCompleted:Signal;
		public var onExitCompleted:Signal;

		private var _eventSignal:Signal;

		public function ScreenBase()
		{
			super();
			onEnterCompleted = new Signal();
			onExitCompleted = new Signal();

			_eventSignal = new Signal(String, Object);

			onEnterCompleted.add(enterTransitionsComplete);
			onExitCompleted.add(exitTranstionsComplete);
		}

		public function onKeyboardDownHandler(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.BACK)
			{
				_eventSignal.dispatch(EVENT_KEYBOARD_DISPATCHED, e)
			}
		}

		public function setup():void
		{

		}

		public function destory():void
		{

		}

		public function invalidLayout():void
		{

		}


		public function enterTransitions():void
		{
			//override
			onEnterCompleted.dispatch();
		}

		public function enterTransitionsComplete():void
		{
			//override
		}

		public function exitTranstions():void
		{

			//override
			onExitCompleted.dispatch();
		}

		public function exitTranstionsComplete():void
		{
			//override
			this.visible = false;
		}

		public function onEnterView():void
		{
			trace("ScreenBase.onEnterView");
			this.addEventListener(KeyboardEvent.KEY_DOWN, onKeyboardDownHandler);
			enterTransitions();
		}

		public function onExitView():void
		{
			trace("ScreenBase.onExitView");
			this.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyboardDownHandler);
			exitTranstions();
			//override
		}

		public function get setting():ISetting
		{
			return _setting;
		}

		public function set setting(value:ISetting):void
		{
			if(this._setting == value) return;
			_setting = value;
			this._eventSignal.dispatch(SETTING_UPDATED, null)
		}

		public function get eventSignal():Signal
		{
			return _eventSignal;
		}

		public function set eventSignal(value:Signal):void
		{
			_eventSignal = value;
		}
	}
}
