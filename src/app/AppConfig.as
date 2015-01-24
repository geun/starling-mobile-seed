package app
{
	import app.commands.flow.AppInitializeCommand;
	import app.commands.ui.PopupViewCommand;
	import app.commands.ui.UpdateViewCommand;
	import app.config.Development;
	import app.config.ISetting;
	import app.models.AppStatus;
	import app.services.IIAPService;

	import app.services.dummy.DummyAlert;
	import app.services.dummy.DummyAnalyticsService;
	import app.services.dummy.DummyApplicationService;
	import app.services.dummy.DummyDialogService;
	import app.services.dummy.DummyIAPService;
	import app.services.dummy.DummyPushService;
	import app.services.IAlert;
	import app.services.IAnalyticsService;
	import app.services.IApplicationService;
	import app.services.IDialogService;


	import app.services.IPushService;
	import app.signals.ui.PopupViewSignal;

	import app.signals.flow.AppInitializeSignal;
	import app.signals.flow.InitializeCompletSignal;
	import app.signals.ui.UpdateViewSignal;
	import app.views.base.StarlingRoot;
	import app.views.base.StarlingRootMediator;
	import app.views.pages.TestView;
	import app.views.pages.TestViewMediator;

	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;

	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IInjector;
	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.bender.framework.api.LogLevel;

	public class AppConfig implements IConfig
	{

		[Inject]
		public var context:IContext;

		[Inject]
		public var commandMap:ISignalCommandMap;

		[Inject]
		public var mediatorMap:IMediatorMap;

		[Inject]
		public var injector:IInjector;

		[Inject]
		public var logger:ILogger;

		public function configure():void
		{

			context.logLevel = LogLevel.DEBUG;
			//logger.info("config.")

			injector.map(ISetting).toSingleton(Development);

			injector.map(AppStatus).asSingleton();
			injector.map(InitializeCompletSignal).asSingleton();


			injector.map(IAlert).toSingleton(DummyAlert);
			injector.map(IIAPService).toSingleton(DummyIAPService);
			injector.map(IDialogService).toSingleton(DummyDialogService);
			injector.map(IPushService).toSingleton(DummyPushService);
			injector.map(IAnalyticsService).toSingleton(DummyAnalyticsService);
			injector.map(IApplicationService).toSingleton(DummyApplicationService);

			//student initialize
			commandMap.map(AppInitializeSignal).toCommand(AppInitializeCommand);

			//ui signal
			commandMap.map(UpdateViewSignal).toCommand(UpdateViewCommand);
			//commandMap.map(PopupNewChatSignal).toCommand(PopupNewChatCommand);
			//commandMap.map(PopupLoadingViewSignal).toCommand(PopupLoadingViewCommand);
			commandMap.map(PopupViewSignal).toCommand(PopupViewCommand);

			//views
			mediatorMap.map(TestView).toMediator(TestViewMediator);
			mediatorMap.map(StarlingRoot).toMediator(StarlingRootMediator);

		}


	}
}
