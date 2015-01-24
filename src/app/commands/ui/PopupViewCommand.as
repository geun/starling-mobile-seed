package app.commands.ui
{
	import app.models.AppStatus;

	public class PopupViewCommand
	{
		[Inject]
		public var page:String;

		[Inject]
		public var enable:Boolean;

		[Inject]
		public var appStatus:AppStatus;

		public function execute():void
		{
			trace("PopupViewCommand.execute", page, enable);


			this.popup(page,enable);
		}

		public function popup(page:String, enable:Boolean):void
		{
			appStatus.updatePopupView(page, enable);
		}
	}
}
