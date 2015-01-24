package app.services.dummy
{
	import app.models.vo.OriginalText;
	import app.models.vo.RatingQueryParams;
	import app.models.vo.TopicQueryParams;
	import app.services.api.ChattingCatServiceSignal;
	import app.services.api.IChattingCatService;
	import app.services.vo.AccessToken;
	import app.services.vo.Grant;
	import app.signals.services.UpdateUserInfoSignal;

	import feathers.data.ListCollection;

	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.setTimeout;

	import robotlegs.bender.framework.api.ILogger;

	public class DummyService implements IChattingCatService
	{
		[Inject]
		public var logger:ILogger;

		[Inject]
		public var updateUserInfoSignal:UpdateUserInfoSignal;


		private var _eventSignal:ChattingCatServiceSignal;
		
		public function DummyService()
		{
			_eventSignal = new ChattingCatServiceSignal();
		}

		public function get eventSignal():ChattingCatServiceSignal
		{
			return _eventSignal;
		}

		private function loadJSONFromDirectory(filename:String):Object
		{

			var targetFile:File = File.applicationDirectory.resolvePath('assets/'+filename);
			if(targetFile.exists)
			{
				var targetStream:FileStream = new FileStream();
				targetStream.open(targetFile, FileMode.READ);
				var rawData:String = targetStream.readUTFBytes(targetStream.bytesAvailable);
				targetStream.close();

				var result:Object = JSON.parse(rawData);
				logger.info(result.toString());
				return result;
			}
			else
			{
				logger.error("file not exists");
				return null;
			}
		}

		public function getTopics(params:TopicQueryParams):void
		{
			var topics:ListCollection = fetchTopics();
//			var topics:Vector.<OriginalText> = getEmptyTopics();
			params.data = topics;
			setTimeout(function():void{

				_eventSignal.dispatch(ChattingCatServiceSignal.COMPLETE, params);
			}, 1000)


		}

		public function getEmptyTopics():Vector.<OriginalText>
		{
			return new <OriginalText>[];
		}


		public function fetchTopics():ListCollection
		{
			var filename:String = 'dummy/topics.json';
			var result:Object = loadJSONFromDirectory(filename);
			var topics:ListCollection = new ListCollection();

			var rawTopics:Array = result.topics;
			var metaTag:Object = result.meta;

			for(var i:int = 0; i < rawTopics.length; i++)
			{
				topics.push(new OriginalText().setData(rawTopics[i]));
			}

			return topics;

		}

		public function ping():void
		{
			_eventSignal.dispatch(ChattingCatServiceSignal.SERVICE_ONLINE, null);
		}

		public function login():void
		{
		}

		public function join():void
		{
		}

		public function me():void
		{

		}

		public function updateUserInfo():void
		{

			var dummyUser:Object = {}
			dummyUser.id = 1658;
			dummyUser.uid = "12401240120410241240124";
			dummyUser.email = "geunbaelee@gmail.com";
			dummyUser.username = "geun";
			dummyUser.available_catnips = 641.5;
			dummyUser.uid = "12401240120410241240124";
			dummyUser.role = "student";
			dummyUser.confirmed = true;
			dummyUser.locked = false;
			dummyUser.qualify_state = "ready";
			dummyUser.qualified = "false";
			dummyUser.name = "geunbae lee";
			dummyUser.join_group = "2013/04/15";

			updateUserInfoSignal.dispatch({info: dummyUser});

		}

		public function isRequireAuthorization():Boolean
		{
			return false;
		}

		public function setAccessToken(value:AccessToken):void
		{
		}

		public function get grant():Grant
		{
			return null;
		}

		public function getTopic(params:TopicQueryParams):void
		{

		}

		public function createTopic(params:Object):void
		{
			_eventSignal.dispatch(ChattingCatServiceSignal.COMPLETE, {useBusyIndicator: params.useBusyIndicator});
		}

		public function createRating(params:RatingQueryParams):void
		{
			_eventSignal.dispatch(ChattingCatServiceSignal.COMPLETE, {useBusyIndicator: params.useBusyIndicator});
		}


		public function setEnablePushNotification(value:Boolean):void
		{
		}

		public function getDeveloperPayload(paymentType:String):void
		{
		}

		public function verifyReceipt(paymentType:String, receipt:Object, developerPayload:String, signature:String):void
		{
		}

		public function consumeReceipt(paymentType:String, receipt:Object, developerPayload:String, signature:String):void
		{
		}

		public function updateDeviceInfo(user_id:String, registraion_code:String, device_uuid:String):void
		{
			_eventSignal.dispatch(ChattingCatServiceSignal.UPDATE_DEVICE_INFO_COMPLETE, {});
		}
	}
}
