package app.views.base
{
	import app.Assets;
	import app.config.ISetting;
	import app.models.AppStatus;
	import app.models.Device;
	import app.services.IApplicationService;
	import app.signals.flow.AppInitializeSignal;
	import app.signals.ui.UpdateViewSignal;
	import feathers.themes.FlatThemeOpenSans;


	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import starling.core.Starling;

	public class StarlingRootMediator extends StarlingMediator
	{

		[Inject]
		public var appStatus:AppStatus;

		[Inject]
		public var updateViewSignal:UpdateViewSignal;

		[Inject]
		public var setting:ISetting;

		[Inject]
		public var appInitializeSignal:AppInitializeSignal;

		[Inject]
		public var applicationService:IApplicationService;


		private var view:StarlingRoot;


		public function StarlingRootMediator()
		{
			super();
		}

		override public function initialize():void
		{
			trace("StarlingRootMediator.initialize");
			var theme:FlatThemeOpenSans = new FlatThemeOpenSans();
//			var theme:FlatTheme = new MinimalMobileTheme();
//			var theme:ChattingCatMobileTheme = new ChattingCatMobileTheme();
			Assets.init(Starling.current.nativeStage, 1);
			Assets.initializeComplete.addOnce(assetsInitializeHandler);

			setting.currentDevice = new Device();
			//initialize setting
			//setting.scale = theme.scale;
			//setting.controlSize = theme.controlSize;
			//setting.gridSize = theme.gridSize;

			setting.scale = 1.0;
			setting.controlSize = 88;
			setting.gridSize = 88;

			view = viewComponent as StarlingRoot;
			view.setting = setting;
			super.initialize();

			view.visibleiOSStatusSignal.add(onVisibleiOSStatusHandler);
			appStatus.updateViewSignal.add(onUpdateViewHanlder);

			appStatus.updatePopupViewSignal.add(onUpdatePopupViewHandler);
			//update view
			//todo: move to initialize command
//			updateViewSignal.dispatch(MobilePages.START_UP);

		}

		private function assetsInitializeHandler():void
		{
			view.bootstrap();
			appInitializeSignal.dispatch();

		}

		private function onUpdatePopupViewHandler(targetView:String, enable:Boolean):void
		{
			switch(targetView)
			{
			}
		}


		//The animation to use (either "fade", "slide" or "none" )
		private function onVisibleiOSStatusHandler(show:Boolean):void
		{
//			applicationService.visibleiOSStatusBar(show, 'none');
		}


		private function onUpdateViewHanlder(targetView:String, previousView:String):void
		{
			trace("StarlingRootMediator.onUpdateViewHanlder");
			trace(targetView, previousView);

			switch(targetView)
			{
				default:
				{
					view.updateView(targetView);
				}
			}
		}

	}
}
