package app.commands.flow
{
	import app.config.ISetting;
	import app.models.Device;
	import app.services.IAlert;
	import app.services.IAnalyticsService;
	import app.services.IApplicationService;
	import app.services.IDialogService;
	import app.services.IIAPService;
	import app.services.IPushService;
	import app.signals.flow.InitializeCompletSignal;
	import app.signals.ui.UpdateViewSignal;

	import flash.desktop.NativeApplication;

	import robotlegs.bender.framework.api.ILogger;

	public class AppInitializeCommand
	{

		[Inject]
		public var applicationService:IApplicationService;

		[Inject]
		public var pushNotificationService:IPushService;

		[Inject]
		public var updateViewSignal:UpdateViewSignal;

		[Inject]
		public var initializeCompleteSignal:InitializeCompletSignal;

		[Inject]
		public var logger:ILogger;

		[Inject]
		public var setting:ISetting;

		[Inject]
		public var iapService:IIAPService;

		[Inject]
		public var dialogService:IDialogService;


		[Inject]
		public var analyticsService:IAnalyticsService;

		[Inject]
		public var alert:IAlert;

		private var device:Device;

		public function execute():void
		{

			trace("InitializeAppCommand.execute");

			device = setting.currentDevice;
			setting.googleBase64DecodeKey = GOOGLE_KEY;

			createServices();
			//todo: Assset initailize command

		}

		public static const DEV_KEY: String = "b783bcd736c44a76ca3d49dd3d6d4f0a869cfbcaQCwgNdGOMd61SBsJX77yIvQAXGUp9W3u9oJcUw8UsVr3yunxgzxz/KY5CQGlFshjVTTIr4pUMR/TD4g+InjPmnF/jE+er50hijOk5XROAntCJtAL8AH5BNsrgtQe1DAbSZosWj8uKGq+57T2TrbX2iVpu/PunR7okV9pouB1vRPBzAiwGfg1xDzw8ltM+VvpCpQAB5ItNl0/AkNEo57qgtGhWiwPpx4v3i7pcvy93sUENfhkh3Waumy4TaZafezrAA3Fq8eoQx0WeNHCTzJVVlsbZyfqqIlei2e/k3GN34EX2oWFYIPw4VhgywzhEFgELYMWHcH4hvGs+C1WAGEiQw==";
		public static const GCM_SENDER_ID: String = "493923495512";
		public static const GOOGLE_KEY:String = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAlKJwoEwYAsPL5W5Ky7yhEPcLJ11yPCJio6lzMDXqkWjKh21OCeUo8VIYzaNn/7h4B7JhbgiQ7sJy7llwqAAj8aPqqzQ3JYuYEC4b0BwOMNcpzTqv/idIsDxTTbKNNsE2UEiuQjGZmmN+qZRnEpxZ4/OKwadUf0n1U1nEaPDkF7XBxfIt17zVpxZV2Oq7wd7EQ8EMBJ7GV2Mq2GsuO3JJrGMlYF7WaMaRuN4xbTFH92AtWss2kBxINVWBpAD91EptTeyFTJ0trd4LzGJMYXlozoOfZ/HcNzCp0zvfzeGc9nLXrZX0Di5+kZb5bwvpJSfRlB5E6Zqs/+nuzWbk2G/c2wIDAQAB";

		public static const GA_ID:String = "UA-58032771-1";

		private function createServices():void
		{
			applicationService.initialize(DEV_KEY);

			setting.deviceInfo = applicationService.getDeviceInfo();
			setting.uniqueDeviceID = applicationService.getUniqueID();

			analyticsService.initialize(GA_ID, setting.uniqueDeviceID);

//			logger.info("AppInitializeCommand.createServices.deviceInfo" );
			logger.info(["AppInitializeCommand.createServices.uniqueDeviceID", setting.uniqueDeviceID]);
		}

		private function pushNotificationInitializeHandler(eventType:String, data:Object):void
		{
			logger.info("AppInitializeCommand.pushNotificationInitializeHandler");
			var registraionCode:String = pushNotificationService.getDeviceToken();
//			var registraionCode:String = "APA91bEIpj-pYu_ZJ6Ta2B6AHToaXWKXNRIAkfOPZ7M5_jm2Jr6GeNXCxa79FN29fg359IS6G6yzzQiREjZcgdN9hzCr0J35vRTRu1_6cdrHSPe_FtFVKnolkJIT0XbAtKVCEPT6RIa1PzCcVurYL6PIq1l8DKxLm_nyEmr9TtdeQKhHmjkAFOI";

			if(setting.currentDevice.os == "Mac OS 10.9.4" && registraionCode == "")
			{
				logger.info("AppInitializeCommand.pushNotificationInitializeHandler / Mac OS 10.9.4");
				registraionCode = "Mac OS 10.9.4 "+ new Date().getTime();

			}
			device.initialize(registraionCode);


//			setIAPserviceSignal.dispatch();
			serverPing();

		}

		private function serverPing():void
		{
		}

		private function serverPingEventHandler(eventType:String, data:Object):void
		{
			logger.info(["AppInitializeCommand.serverPingEventHandler", eventType]);

		}

		private function preAuthorization():void
		{



		}


	}
}
