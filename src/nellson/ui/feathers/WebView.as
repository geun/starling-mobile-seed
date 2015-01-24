package nellson.ui.feathers
{
	import feathers.controls.ImageLoader;
	import feathers.core.FeathersControl;

	import flash.display.BitmapData;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.LocationChangeEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	import flash.system.Capabilities;
	import flash.utils.getTimer;

	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class WebView extends FeathersControl
	{
		static public const EVENT_COMPLETE:String = 'webViewComplete';
		static public const EVENT_ERROR:String = 'webViewError';
		static public const EVENT_FOCUS_IN:String = 'webViewFocusIn';
		static public const EVENT_FOCUS_OUT:String = 'webViewFocusOut';
		static public const EVENT_LOCATION_CHANGE:String = 'webViewLocationChange';
		static public const EVENT_LOCATION_CHANGING:String = 'webViewLocationChanging';
		static public const EVENT_URL_SCHEME_TRIGGERED:String = 'webViewUrlSchemeTriggered';

		static protected const INVALIDATION_FLAG_SNAPSHOT:String = 'invalidationFlagSnapshot';
		static protected const IS_IOS:Boolean = Capabilities.manufacturer.toLowerCase().indexOf('ios') > -1;

		protected const HELPER_POINT:Point = new Point();
		protected const VIEW_PORT:Rectangle = new Rectangle();

		protected var stageWebView:StageWebView;
		protected var snapshot:ImageLoader;

		public function WebView()
		{
			super();

			stageWebView = new StageWebView();
			stageWebView.addEventListener(flash.events.Event.COMPLETE, onStageWebViewEvent);
			stageWebView.addEventListener(ErrorEvent.ERROR, onStageWebViewEvent);
			stageWebView.addEventListener(FocusEvent.FOCUS_IN, onStageWebViewEvent);
			stageWebView.addEventListener(FocusEvent.FOCUS_OUT, onStageWebViewEvent);
			stageWebView.addEventListener(LocationChangeEvent.LOCATION_CHANGE, onStageWebViewEvent);
			stageWebView.addEventListener(LocationChangeEvent.LOCATION_CHANGING, onStageWebViewEvent);

			addEventListener(starling.events.Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}

		override protected function initialize():void {
			snapshot = new ImageLoader();
			snapshot.maintainAspectRatio = false;
			snapshot.addEventListener(TouchEvent.TOUCH, onSnapshotTouch);
			addChild(snapshot);
		}

		override protected function draw():void {
			const snapshotInvalid:Boolean = isInvalid(INVALIDATION_FLAG_SNAPSHOT);

			if (snapshotInvalid) {
				if (_freezed) {
					updateSnapshot();
				}
			}

			const stateInvalid:Boolean = isInvalid(INVALIDATION_FLAG_STATE);

			if (stateInvalid) {
				if (visible) {
					stageWebView.stage = Starling.current.nativeStage;
					stageWebView.assignFocus();
				} else {
					stageWebView.stage = null;
				}
			}

			const sizeInvalid:Boolean = isInvalid(INVALIDATION_FLAG_SIZE);

			if (sizeInvalid) {
				snapshot.setSize(actualWidth, actualHeight);
			}
		}

		override public function render(support:RenderSupport, parentAlpha:Number):void {
			updateViewPort();
			stageWebView.viewPort = VIEW_PORT;
			super.render(support, parentAlpha);
		}

		override public function set visible(value:Boolean):void {
			super.visible = value;
			invalidate(INVALIDATION_FLAG_STATE);
		}

		override public function dispose():void {
			stageWebView.removeEventListener(flash.events.Event.COMPLETE, onStageWebViewEvent);
			stageWebView.removeEventListener(ErrorEvent.ERROR, onStageWebViewEvent);
			stageWebView.removeEventListener(FocusEvent.FOCUS_IN, onStageWebViewEvent);
			stageWebView.removeEventListener(FocusEvent.FOCUS_OUT, onStageWebViewEvent);
			stageWebView.removeEventListener(LocationChangeEvent.LOCATION_CHANGE, onStageWebViewEvent);
			stageWebView.removeEventListener(LocationChangeEvent.LOCATION_CHANGING, onStageWebViewEvent);
			stageWebView.loadString('');
			stageWebView.stage = null;
			stageWebView.dispose();
			stageWebView = null;
			super.dispose();
		}

		protected function onRemovedFromStage(event:starling.events.Event):void {
			stageWebView.stage = null;
		}

		protected function onStageWebViewEvent(event:flash.events.Event):void {
			switch (event.type) {
				case flash.events.Event.COMPLETE:
					dispatchEventWith(EVENT_COMPLETE);
					break;
				case ErrorEvent.ERROR:
					dispatchEventWith(EVENT_ERROR, false, event);
					break;
				case FocusEvent.FOCUS_IN:
					dispatchEventWith(EVENT_FOCUS_IN);
					break;
				case FocusEvent.FOCUS_OUT:
					if (_autoFreeze) {
						freezed = true;
					}
					dispatchEventWith(EVENT_FOCUS_OUT);
					break;
				case LocationChangeEvent.LOCATION_CHANGE:
//					const locationChangeEvent:LocationChangeEvent = event as LocationChangeEvent;
//					const location:String = locationChangeEvent.location;
//					dispatchEventWith(EVENT_LOCATION_CHANGE, false, location);
//					break;
				case LocationChangeEvent.LOCATION_CHANGING:
					const locationChangeEvent:LocationChangeEvent = event as LocationChangeEvent;
					const location:String = locationChangeEvent.location;
					if (_urlSchemes) {
						for each (var urlScheme:String in _urlSchemes) {
							if (location.indexOf(urlScheme) == 0) {
								locationChangeEvent.preventDefault();
								locationChangeEvent.stopImmediatePropagation();
								dispatchEventWith(EVENT_URL_SCHEME_TRIGGERED, false, location);
								return;
							}
						}
					}
					dispatchEventWith(EVENT_LOCATION_CHANGING, false, locationChangeEvent);
					break;
			}
		}

		protected function onSnapshotTouch(event:TouchEvent):void {
			if (!_autoFreeze) {
				return;
			}
			const touch:Touch = event.getTouch(snapshot, TouchPhase.BEGAN);
			if (touch) {
				freezed = false;
			}
		}

		protected function updateViewPort():void {
			HELPER_POINT.x = HELPER_POINT.y = 0;
			localToGlobal(HELPER_POINT, HELPER_POINT);
			const f:Number = Starling.current.contentScaleFactor;
			VIEW_PORT.x = Math.round(HELPER_POINT.x * f);
			VIEW_PORT.y = Math.round(HELPER_POINT.y * f);
			VIEW_PORT.width = Math.round(actualWidth * f);
			VIEW_PORT.height = Math.round(actualHeight * f);
		}

		protected function updateSnapshot():void {
			var bitmapData:BitmapData;

			try {
				bitmapData = new BitmapData(VIEW_PORT.width, VIEW_PORT.height, false, 0xffffff);
				stageWebView.drawViewPortToBitmapData(bitmapData);
			} catch (e:Error) {
				bitmapData = null;
				trace(e.getStackTrace());
			}

			if (bitmapData) {
				snapshot.source = Texture.fromBitmapData(bitmapData, false, false, Starling.current.contentScaleFactor);
			}
		}

		public function callJs(funcName:String, ...args):void {
			var call:String = "javascript:";
			var callArgs:Array;
			var i:int;
			if (IS_IOS) {
				// see HTML/JS window.onhashchange and location.hash
				var location:String = stageWebView.location;
				const hashTagIndex:int = location.indexOf('#');
				if (hashTagIndex > -1) {
					location = location.substr(0, hashTagIndex);
				}
				call += "window.location='" + location;
				call += '#';
				callArgs = [funcName];
				if (args) {
					for (i = 0; i < args.length; i++) {
						callArgs[i] = String(args[i]);
					}
				}
				callArgs[callArgs.length] = String(getTimer());
				call += callArgs.join('&');
				call += "'";
			} else {
				call += funcName + "(";
				if (args) {
					callArgs = [];
					for (i = 0; i < args.length; i++) {
						callArgs[i] = "'" + String(args[i]) + "'";
					}
					call += callArgs.join(',');
				}
				call += ")";
			}
			stageWebView.loadURL(call);
		}

		public function assignFocus(direction:String = 'none'):void {
			stageWebView.assignFocus(direction);
		}

		public function historyBack():void {
			stageWebView.historyBack();
		}

		public function historyForward():void {
			stageWebView.historyForward();
		}

		public function loadString(text:String, mimeType:String = 'text/html'):void {
			stageWebView.loadString(text, mimeType);
		}

		public function loadURL(url:String):void {
			stageWebView.loadURL(url);
		}

		public function reload():void {
			stageWebView.reload();
		}

		public function stop():void {
			stageWebView.stop();
		}

		public function get isHistoryBackEnabled():Boolean {
			return stageWebView.isHistoryBackEnabled;
		}

		public function get isHistoryForwardEnabled():Boolean {
			return stageWebView.isHistoryForwardEnabled;
		}

		public function get isSupported():Boolean {
			return StageWebView.isSupported;
		}

		public function get location():String {
			return stageWebView.location;
		}

		public function get title():String {
			return stageWebView.title;
		}

		protected var _autoFreeze:Boolean;

		public function get autoFreeze():Boolean {
			return _autoFreeze;
		}

		public function set autoFreeze(value:Boolean):void {
			_autoFreeze = value;
		}

		protected var _freezed:Boolean;

		public function get freezed():Boolean {
			return _freezed;
		}

		public function set freezed(value:Boolean):void {
			if (value == _freezed) {
				return;
			}
			_freezed = value;
			visible = !_freezed;
			invalidate(INVALIDATION_FLAG_SNAPSHOT);
		}

		protected var _urlSchemes:Vector.<String> = new <String>['mailto:', 'tel:'];

		public function get urlSchemes():Vector.<String> {
			return _urlSchemes;
		}

		public function set urlSchemes(value:Vector.<String>):void {
			_urlSchemes = value;
		}
	}
}