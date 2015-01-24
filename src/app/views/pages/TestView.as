package app.views.pages
{
	import app.views.base.PanelBase;

	import feathers.controls.TabBar;
	import feathers.data.ListCollection;

	import robotlegs.extensions.starlingViewMap.impl.StarlingViewBase;

	import starling.core.Starling;

	import starling.events.Event;

	public class TestView extends PanelBase
	{
		private var navigationBar:TabBar;

		private static const HOME_SCREEN:String = "homeScreen";
		private static const BROWSE_SCREEN:String = "browseScreen";
		private static const SKETCH_SCREEN:String = "sketchScreen";
		private var navHeight:int;

		public function TestView()
		{
			super();
		}

		override public function setup():void
		{
			trace("TestView.initialize")
			buildComponent();
			invalidLayout();
		}

		private function buildComponent():void
		{
			this.headerProperties.title = "Tools";

			navigationBar = new TabBar();
			navigationBar.dataProvider = new ListCollection([
				{label:"Browse", data:BROWSE_SCREEN},
				{label:"Home", data:HOME_SCREEN},
				{label:"Sketch", data:SKETCH_SCREEN}
			]);
			navigationBar.selectedIndex = 1;
//			navigationBar.width = stage.stageWidth;
//			navigationBar.addEventListener(Event.CHANGE, navigationBarChanged);
			addChild(navigationBar);
		}

		private function navigationBarChanged(e:Event):void
		{
		}

		override public function invalidLayout():void
		{

			trace("TestView.invalidLayout")
			navigationBar.validate();
			trace(navigationBar.width, navigationBar.height)
//			trace(this.pixelScale, this.dpi)
			navigationBar.width = stage.stageWidth;
			navigationBar.height = 140;

			navHeight = Math.round(navigationBar.height);
		}
	}
}
