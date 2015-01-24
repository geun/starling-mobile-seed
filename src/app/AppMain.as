package app
{
	import app.signals.flow.InitializeCompletSignal;
	import app.views.base.StarlingRoot;

	import flash.display.Bitmap;
	import flash.display.BitmapData;

	import flash.display.Loader;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.utils.ByteArray;

	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.signalCommandMap.SignalCommandMapExtension;

	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;
	import robotlegs.extensions.starlingViewMap.StarlingViewMapExtension;

	import starling.core.Starling;

	public class AppMain extends Sprite
	{
		private var _starling:Starling;
		private var _context:IContext;
		private var _launchImage:Bitmap;

		private var initializeCompletSignal:InitializeCompletSignal;

		public function AppMain()
		{
			if(this.stage)
			{
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
				this.stage.align = StageAlign.TOP_LEFT;
			}
			showLaunchImage();
			this.mouseEnabled = this.mouseChildren = false;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);

		}

		private function onAddToStage(e:Event):void
		{

			configure();
			startup();

			trace(stage.stageWidth, stage.stageHeight);
			stage.addEventListener(Event.RESIZE, onStageResizeHandler, false, int.MAX_VALUE, true);
			stage.addEventListener(Event.DEACTIVATE, onStageDeactiveHandler, false, 0, true);

		}

		private function startup():void
		{
		}

		private function configure():void
		{

			Starling.handleLostContext = true;
			Starling.multitouchEnabled = false;

			this._starling = new Starling(StarlingRoot, stage);
			this._starling.enableErrorChecking = false;
			this._starling.showStats = false;

			invalidateViewPort();
			this._starling.start();

			this._context = (new Context())
				.install(MVCSBundle)
				.install(StarlingViewMapExtension)
				.install(SignalCommandMapExtension)
				.configure(AppConfig, new ContextView(this), _starling);

			this._starling.addEventListener("rootCreated", onStarlingRootCreatedHandler)

			initializeCompletSignal = _context.injector.getInstance(InitializeCompletSignal);
			initializeCompletSignal.addOnce(onInitializeCompleteHandler);

		}

		private function onInitializeCompleteHandler():void
		{
			trace("AppMain.onInitializeCompleteHandler");
			if(this._launchImage)
			{
				this.removeChild(this._launchImage);
				this._launchImage = null;
			}
		}


		private function onStageResizeHandler(e:Event):void
		{
			trace("AppMain.onStageResizeHandler", this.stage.stageWidth, this.stage.stageHeight)
			invalidateViewPort();
		}

		private function invalidateViewPort():void
		{
			this._starling.stage.stageWidth = this.stage.stageWidth;
			this._starling.stage.stageHeight = this.stage.stageHeight;

			const viewPort:Rectangle = this._starling.viewPort;
			viewPort.width = this.stage.stageWidth;
			viewPort.height = this.stage.stageHeight;

			if(this._launchImage)
			{
				this._launchImage.width = viewPort.width;
				this._launchImage.height = viewPort.height;
			}

			try
			{
				this._starling.viewPort = viewPort;
				//				AppSetting.setStageSzie(stage.stageWidth, stage.stageHeight);

			} catch (error:Error)
			{
				// todo: handle exception
			}
		}

		private function onStarlingRootCreatedHandler(e:Object):void
		{
			trace("AppMain.onStarlingRootCreatedHandler")
		}

		private function onStageDeactiveHandler(e:Event):void
		{
			this._starling.stop();
			this.stage.addEventListener(Event.ACTIVATE, onStageActiveHandler, false, 0, true);
		}

		private function onStageActiveHandler(e:Event):void
		{
			this.stage.removeEventListener(Event.ACTIVATE, onStageActiveHandler);
			this._starling.start();
		}

		private function showLaunchImage():void
		{
			trace("AppMain.showLaunchImage");
			_launchImage = new Assets.backgroundPng() as Bitmap;
			_launchImage.width = Capabilities.screenResolutionX;
			_launchImage.height = Capabilities.screenResolutionY;
			this.addChild(_launchImage);
		}


	}
}
