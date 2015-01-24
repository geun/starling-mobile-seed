package app.commands.ui
{
	import app.models.AppStatus;

	import robotlegs.bender.framework.api.ILogger;

	public class UpdateViewCommand
	{

		[Inject]
		public var targetView:String;


		[Inject]
		public var appStatus:AppStatus;
		
		[Inject]
		public var logger:ILogger;

		public function execute():void
		{
			logger.info("UpdateViewCommand.execute");
			appStatus.updateView(targetView);
		}
	}
}
