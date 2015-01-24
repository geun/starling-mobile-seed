package app.models
{

import app.views.pages.Pages;

import org.osflash.signals.Signal;

	import robotlegs.bender.framework.api.ILogger;

	public class AppStatus
	{

		[Inject]
		public var logger:ILogger;

		private var _previousView:String;
		private var _currentView:String;
		private var _updateViewSignal:Signal;

		private var _currentSelectedOriginalText:Object;
		private var _currentSelectedCorrectedText:Object;

		private var _currentPopupView:String;

		private var _updatePopupViewSignal:Signal;

		private var _popupViewStack:Array;

		public function AppStatus()
		{
			_popupViewStack = [];
			_updateViewSignal = new Signal(String, String);
			_updatePopupViewSignal = new Signal(String, Boolean);
		}

		public function updatePopupView(targetView:String, enable:Boolean):void
		{
			if(enable)
			{
				_popupViewStack.push(targetView);
				_currentPopupView = targetView;
			}
			else
			{
				if(_popupViewStack.length > 0)
				{
					trace("AppStatus.updatePopupView", _currentPopupView);
					var idx:int = _popupViewStack.indexOf(targetView);
					_popupViewStack.splice(idx, 1);
					_currentPopupView = _popupViewStack[_popupViewStack.length - 1];
					trace("AppStatus.updatePopupView.after", _currentPopupView);
				}
				else
				{
					_currentPopupView = null;
				}
			}
			_updatePopupViewSignal.dispatch(targetView, enable);
		}

		public function updateView(targetView:String):void
		{

			if(targetView == Pages.BACK)
			{
				var swap:String = _previousView;
				_previousView = _currentView;
				_currentView = swap;
			}
			else
			{
				_previousView = _currentView;
				_currentView = targetView;
			}

			_updateViewSignal.dispatch(_currentView, _previousView);
		}

		public function isPopuped():Boolean
		{
			return _currentPopupView != null;
		}

		public function get currentView():String
		{
			return _currentView;
		}

		public function get updateViewSignal():Signal
		{
			return _updateViewSignal;
		}

		public function get previousView():String
		{
			return _previousView;
		}

		public function get currentSelectedOriginalText():Object
		{
			return this._currentSelectedOriginalText;
		}

		public function set currentSelectedOriginalText(value:Object):void
		{
			if(this._currentSelectedOriginalText == value) return;
			this._currentSelectedOriginalText = value;
		}

		public function get currentSelectedCorrectedText():Object
		{
			return _currentSelectedCorrectedText;
		}

		public function set currentSelectedCorrectedText(value:Object):void
		{
			if(this._currentSelectedCorrectedText == value) return;
			_currentSelectedCorrectedText = value;
		}

		public function get currentPopupView():String
		{
			return _currentPopupView;
		}

		public function set currentPopupView(value:String):void
		{
			_currentPopupView = value;
		}

		public function get updatePopupViewSignal():Signal
		{
			return _updatePopupViewSignal;
		}
	}
}
