package app.views.base
{
	import app.config.ISetting;

	import feathers.controls.PanelScreen;

	import org.osflash.signals.Signal;

	import robotlegs.extensions.starlingViewMap.api.IStarlingViewBase;

	public class PanelBase extends PanelScreen implements IStarlingViewBase
	{
		public static const SETTING_UPDATED:String = "screen-setting-update";

		protected var _setting:ISetting;

		public var onEnterCompleted:Signal;
		public var onExitCompleted:Signal;

		private var _eventSignal:Signal;

		public function PanelBase()
		{
			super();
			onEnterCompleted = new Signal();
			onExitCompleted = new Signal();

			_eventSignal = new Signal(String, Object);

			onEnterCompleted.add(enterTransitionsComplete);
			onExitCompleted.add(exitTranstionsComplete);
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
			enterTransitions();
		}

		public function onExitView():void
		{
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
