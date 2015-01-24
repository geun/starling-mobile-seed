package app.views.base
{
	import app.config.ISetting;
	import app.models.Device;
	import app.views.pages.ListView;
	import app.views.pages.Pages;
	import app.views.pages.TestView;

	import feathers.controls.Drawers;

	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.core.PopUpManager;

	import feathers.events.FeathersEventType;
	import feathers.motion.transitions.ScreenFadeTransitionManager;

	import flash.system.Capabilities;

	import flash.ui.Keyboard;

	import org.osflash.signals.Signal;

	import robotlegs.bender.extensions.matching.instanceOfType;

	import robotlegs.extensions.starlingViewMap.api.IStarlingViewBase;

	import robotlegs.extensions.starlingViewMap.impl.StarlingViewBase;

	import starling.display.Quad;

	import starling.display.Sprite;

	import starling.events.Event;
	import starling.events.KeyboardEvent;

	public class StarlingRoot extends StarlingViewBase
	{
		private var testView:TestView;
		private var _navigator:ScreenNavigator;
		private var screenTransitionManager:ScreenFadeTransitionManager;
		private var drawers:Drawers;

		private var _setting:ISetting;
		private var popupContainer:Sprite;
		private var isIos:Boolean;
		private var isIos7:Boolean;
		private var _paddingTop:Number = 0;
		private var iosStatusBarBack:Quad;

		public var visibleiOSStatusSignal:Signal;

		private var device:Device;
		private var bottomMeunVisible:Boolean;

		public function StarlingRoot()
		{
			super();

			this.addEventListener(Event.ADDED_TO_STAGE, onStageHandler);
		}

		private function onStageHandler(e:Event):void
		{
			trace("StarlingRoot.onStageHandler");
//			Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyboardDownHandler);
		}

		private function onKeyboardDownHandler(e:KeyboardEvent):void
		{
			trace("StarlingRoot.onKeyboardDownHandler", e.keyCode);
		    switch(e.keyCode)
		    {
			    case Keyboard.HOME:
				case Keyboard.BACK:
				case Keyboard.SEARCH:
				{
					e.preventDefault();
//					e.stopImmediatePropagation();

					break;
				}
				default:
				{


				}
		    }
		}

		override public function setup():void
		{
			//start here
			trace('StarlingRoot.setup');
			super.setup();

			visibleiOSStatusSignal = new Signal(Boolean);
		}

		public function bootstrap():void
		{
			setDevice();
			buildComponents();
			initailizePopUpManager();
			invalidLayout();
		}

		public function setDevice():void
		{

			device = setting.currentDevice;

			trace("StarlingRoot.setDevice", Capabilities.os);
			trace("StarlingRoot.setDevice", Capabilities.version);

			if(Capabilities.version.indexOf("IOS") == 0)
			{
				var osInfo:Array = Capabilities.os.split(" ");
				var versionNumber:Number = parseFloat(osInfo[2]);
				isIos = true;
				device.isIos = true;
				if(versionNumber >= 7)
				{
					isIos7 = true; /* for ios7 status bar overlay padding bug… */
					device.isIOS7 = true;
					var t:Number = this.stage.stageHeight >= 960 ? 40 : 20;

					setting.paddingTop = t;
					_paddingTop = t;
				}

				this.iosStatusBarBack = new Quad(20, 20, 0x000000);
				this.addChild(iosStatusBarBack);
			}
			else
			{

				device.os = Capabilities.os;
				device.isIos = false;
				device.isIOS7 = false;
			}

		}

		public function buildComponents():void
		{

			this._navigator = new ScreenNavigator();
			this._navigator.addScreen(Pages.LIST, new ScreenNavigatorItem(ListView));
			screenTransitionManager = new ScreenFadeTransitionManager(_navigator);

			this._navigator.addEventListener(FeathersEventType.TRANSITION_START, onTransitionStartHandler);
			this._navigator.addEventListener(FeathersEventType.TRANSITION_COMPLETE, onTransitionCompletedHandler);

			this.addChild(this._navigator);

			this.popupContainer = new Sprite();
			this.addChild(this.popupContainer);

		}

		private function onTransitionCompletedHandler(e:Event):void
		{
			trace("StarlingRoot.onTransitionCompletedHandler", this._navigator.activeScreen);

			if(instanceOfType(IStarlingViewBase).matches(this._navigator.activeScreen))
			{
				var targetPage:IStarlingViewBase  = this._navigator.activeScreen as IStarlingViewBase;
				targetPage.onEnterView();
			}

//			trace(this._navigator.activeScreenID);
		}

		private function onTransitionStartHandler(e:Event):void
		{
			trace("StarlingRoot.onTransitionStartHandler");
//			trace(this._navigator.activeScreenID);
		}

		public function updateView(targetView:String):void
		{
			trace("StarlingRoot.updateView");
			_navigator.showScreen(targetView);
		}

		override  public function invalidLayout():void
		{
			trace("StarlingRoot.invalidLayout", stage.stageWidth, stage.stageHeight)

			const stageWidth:int = stage.stageWidth;
			const stageHeight:int = stage.stageHeight - this._paddingTop;


			if(iosStatusBarBack)
			{
				this.iosStatusBarBack.width = stageWidth;
				this.iosStatusBarBack.height = _paddingTop;
			}
		}

		public function get navigator():ScreenNavigator
		{
			return _navigator;
		}

		public function initailizePopUpManager():void
		{
			PopUpManager.root = popupContainer;
		}

		public function get setting():ISetting
		{
			return _setting;
		}

		public function set setting(value:ISetting):void
		{
			_setting = value;
		}
	}
}
