package app.views.pages
{
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	public class TestViewMediator extends StarlingMediator
	{
		public function TestViewMediator()
		{
			super();
		}

		override public function initialize():void
		{
			trace("TestViewMediator.initialize")
			super.initialize();
		}


	}
}
