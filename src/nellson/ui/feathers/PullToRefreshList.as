package nellson.ui.feathers
{
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.themes.ChattingCat;

	import flash.display.BitmapData;

	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;

	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class PullToRefreshList extends List
	{

		[Embed(source="../../../../assets/images/pullToRefresh/arrow_up.png")]
		private static const DEFAULT_PULL_DOWN_TO_REFRESH_ICON:Class;

		[Embed(source="../../../../assets/images/pullToRefresh/arrow_down.png")]
		private static const DEFAULT_RELEASE_TO_REFRESH_ICON:Class;

		public static const PULL_TO_REFRESH_EVENT:String = "pull_to_refresh_event";

		public static const CLEAR_STATUS:String = "clear_status";
		public static const NORMAL_STATUS:String = "normal_status";
		public static const PULL_STATUS:String = "pull_status";
		public static const LOADING_STATUS:String = "loading_status";
		public static const LOADING_OLD_STATUS:String = "loading_old_status";

		public static const REQUEST_NEW:String = "request_new";
		public static const REQUEST_OLD:String = "request_old";

		private var _pullDownToRefresh:Sprite;
		private var _releaseToRefresh:Sprite;
		private var _loadingNewRecords:Sprite;
		private var _loadingOldRecords:Sprite;

		private var _releaseHeight:Number;

		private var _container:Sprite;

		private var _status:String;
		private var oldListColection:ListCollection;

		private var _refreshPosition:int = 0;
		private var _refreshPadding:int = 5;

		private var _baseScale:Number = 1.0;
		private var _loadingTexture:Vector.<Texture>;

		// ************************************** main
		public function PullToRefreshList(){
			super();

			// <----- add listener
//			this.addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
//			this.addEventListener(Event.CHANGE, changeHandler);
		}


		override protected function initialize():void
		{
			super.initialize();

			buildComponents();

			this.addEventListener(FeathersEventType.INITIALIZE, onIntializeHanlder);
			this.addEventListener(FeathersEventType.BEGIN_INTERACTION, scrollBeginHandler);
			this.addEventListener(FeathersEventType.SCROLL_START, scrollStartHandler);
			this.addEventListener(FeathersEventType.SCROLL_COMPLETE, scrollCompletedHandler);
			this.addEventListener(FeathersEventType.END_INTERACTION, scrollEndHandler);

		}

		private function onIntializeHanlder(event:Event):void
		{
			trace("PullToRefreshList.onIntializeHanlder");
			setUI();
		}

		private function scrollCompletedHandler(e:Event):void
		{
			trace("PullToRefreshList.scrollCompletedHandler", _status);

		}

		private function scrollStartHandler(e:Event):void
		{
			trace("PullToRefreshList.scrollStartHandler", _status);
		}

		public function buildComponents():void
		{
			_container = this.getChildAt(0) as Sprite;
			_pullDownToRefresh = createPullDownToRefresh();
			_releaseToRefresh = createReleaseToRefresh();
			_loadingNewRecords = createLoadingNewRecords();
			_loadingOldRecords = createLoadingOldRecords();

			_container.addChild(_pullDownToRefresh);
			_container.addChild(_releaseToRefresh);
			this.addChild(_loadingNewRecords);
			this.addChild(_loadingOldRecords);
		}


//		private function changeHandler(e:Event):void
//		{
//			if(this.selectedItem)
//			{
//				for(var i:int=0; i<_container.numChildren; i++)
//				{
//					var tmp:DefaultGroupedListItemRenderer = _container.getChildAt(i) as DefaultGroupedListItemRenderer;
//					if(tmp!=null && tmp.data==this.selectedItem)
//					{
//						this.dispatchEvent(new Event(Event.SELECT, false, tmp));
//						return;
//					}
//				}
//			}
//		}

		// ************************************** event - starling.events.FeathersEventType
		private function scrollBeginHandler(e:Event):void
		{
			trace("PullToRefreshList.scrollBeginHandler");
			if(this.stage)
			{
				setUI();
				changeStatus(NORMAL_STATUS);
			}

//			this.addEventListener(Event.ENTER_FRAME, scrollHandler);
		}

		private function scrollEndHandler(e:Event):void
		{
			trace("PullToRefreshList.scrollEndHandler", _status);

			if(_status==PULL_STATUS)
			{
				changeStatus(LOADING_STATUS);
			}

//			this.removeEventListener(Event.ENTER_FRAME, scrollHandler);
		}

		private function scrollHandler(e:Event):void
		{
//			trace("PullToRefreshList.scrollHandler",_verticalScrollPosition, _maxVerticalScrollPosition );
			if(this._verticalScrollPosition < -(_releaseHeight))
			{
				changeStatus(PULL_STATUS);
			}

			else if (this._verticalScrollPosition >= _refreshPosition)
			{
				changeStatus(LOADING_OLD_STATUS);
			}

			else if(this._verticalScrollPosition > -(_releaseHeight))
			{
				changeStatus(NORMAL_STATUS);
			}

		}


		override protected function verticalScrollBar_changeHandler(e:Event):void
		{
//			trace("PullToRefreshList.verticalScrollBar_changeHandler", _verticalScrollPosition,_maxVerticalScrollPosition );
			super.verticalScrollBar_changeHandler(e);
			scrollHandler(e)
		}

		override protected  function  refreshMinAndMaxScrollPositions():void
		{
			super.refreshMinAndMaxScrollPositions();
			_refreshPosition = _maxVerticalScrollPosition - (_maxVerticalScrollPosition >> 4);

		}

		private function scrollCompleteHandler(e:Event):void
		{
			this.removeEventListener(FeathersEventType.SCROLL_COMPLETE, scrollCompleteHandler);
			this.dispatchEvent(new Event(PULL_TO_REFRESH_EVENT, false, REQUEST_NEW));
		}

		private function loadOld_scrollCompleteHandler(e:Event):void
		{
			trace("PullToRefreshList.loadOld_scrollCompleteHandler");
			this.removeEventListener(FeathersEventType.SCROLL_COMPLETE, loadOld_scrollCompleteHandler);
			this.dispatchEvent(new Event(PULL_TO_REFRESH_EVENT, false, REQUEST_OLD));
		}

		// ************************************** getter
		public function get pullDownToRefresh():Sprite
		{
			return _pullDownToRefresh;
		}
		public function get releaseToRefresh():Sprite
		{
			return _releaseToRefresh;
		}
		public function get loadingNewRecords():Sprite
		{
			return _loadingNewRecords;
		}
		public function get loadingOldRecords():Sprite
		{
			return _loadingOldRecords;
		}

		// ************************************** setter
		override public function set dataProvider(value:ListCollection):void{

			super.dataProvider = value;

			if(this.stage){
				setUI();
				changeStatus(CLEAR_STATUS);
			}
		}

		override protected function dataProvider_resetHandler(e:Event):void
		{
			super.dataProvider_resetHandler(e);
		}

		override protected function dataProvider_changeHandler(e:Event):void
		{
			super.dataProvider_changeHandler(e);
		}

		private function onDataChangeHandler(e:Event):void
		{
//			trace("PullToRefreshList.onDataChangeHandler");
//			trace("PullToRefreshList.onDataChangeHandler");
//			trace("PullToRefreshList.onDataChangeHandler");
		}

		public function fetchComplete():void
		{
			if(this.stage)
			{
				setUI();
				changeStatus(CLEAR_STATUS);
			}
		}

//		public function appendNewData(list:ListCollection):void
//		{
//			trace("PullToRefreshList.appendNewData");
//			if (_dataProvider != null)
//			{
//				dataProvider.addAllAt(list, 0);
//			}
//
//			else
//			{
//				dataProvider = list;
//			}
//			if(this.stage){
//				setUI();
//				changeStatus(CLEAR_STATUS);
//			}
//		}
//
//		public function appendOldData(list:ListCollection):void
//		{
//			trace("PullToRefreshList.appendOldData");
//
//			if (_dataProvider != null)
//			{
//				dataProvider.addAll(list);
//			}
//			else
//			{
//				dataProvider = list;
//			}
//
//			if(this.stage)
//			{
//				setUI();
//				changeStatus(CLEAR_STATUS);
//			}
//		}

		// ************************************** private method
		private function setUI():void
		{
			var halfW:Number = this.actualPageWidth/2;
			_pullDownToRefresh.x = halfW - (_pullDownToRefresh.width >> 1);
			_pullDownToRefresh.y = -_pullDownToRefresh.height-_refreshPadding;
			_releaseToRefresh.x = halfW - (_releaseToRefresh.width >> 1);
			_releaseToRefresh.y = -_releaseToRefresh.height-_refreshPadding;
			_loadingNewRecords.x = halfW - (_loadingNewRecords.width >> 1);
			_loadingNewRecords.y = _refreshPadding;
			_loadingOldRecords.x = halfW - (_loadingOldRecords.width >> 1);
			_loadingOldRecords.y = this.actualPageHeight - _loadingOldRecords.height - _refreshPadding;
//
			_releaseHeight = _pullDownToRefresh.height * 2;
		}

		private function changeStatus(status:String):void
		{
			if(this._status == status ) return ;
			if((_status==LOADING_STATUS || _status == LOADING_OLD_STATUS) && status!=CLEAR_STATUS) return;

			_status = status;

			setUI();
			if(_status==NORMAL_STATUS || _status==CLEAR_STATUS)
			{

				_pullDownToRefresh.visible = true;
				_releaseToRefresh.visible = false;
				_loadingNewRecords.visible = false;
				_loadingOldRecords.visible = false;
				this.paddingTop = 0;
				this.paddingBottom = 0;
			}
			else if(_status==PULL_STATUS)
			{
				_pullDownToRefresh.visible = false;
				_releaseToRefresh.visible = true;
				_loadingNewRecords.visible = false;
				_loadingOldRecords.visible = false;
				this.paddingTop = 0;
				this.paddingBottom = 0;
			}
			else if(_status==LOADING_STATUS)
			{
				trace("PullToRefreshList.changeStatus: LOADING_STATUS");
				_pullDownToRefresh.visible = false;
				_releaseToRefresh.visible = false;
				_loadingNewRecords.visible = true;
				_loadingOldRecords.visible = false;
				this.paddingTop = _loadingNewRecords.height + (_refreshPadding * 2);
				this.paddingBottom = 0;
				this.addEventListener(FeathersEventType.SCROLL_COMPLETE, scrollCompleteHandler);
			}
			else if(_status == LOADING_OLD_STATUS)
			{
				trace("PullToRefreshList.changeStatus: LOADING_OLD_STATUS");
				_pullDownToRefresh.visible = false;
				_releaseToRefresh.visible = false;
				_loadingNewRecords.visible = false;
				_loadingOldRecords.visible = false;
//				this.paddingTop = 0;
//				this.paddingBottom = _loadingOldRecords.height + _refreshPadding * 2;
				this.addEventListener(FeathersEventType.SCROLL_COMPLETE, loadOld_scrollCompleteHandler);
			}
		}
		private function createPullDownToRefresh():Sprite{
			var tmp:Sprite = new Sprite();
			var icon:BitmapData = (new DEFAULT_PULL_DOWN_TO_REFRESH_ICON()).bitmapData;
			var img:Image = new Image(Texture.fromBitmapData(icon));
			tmp.addChild(img);

			var lab:Label = new Label();
			lab.x = 50;
			lab.text = "Pull Down to refresh";
			lab.styleNameList.add(ChattingCat.LABEL_GRAY_SUB_INFOMATION);
			tmp.addChild(lab);

			lab.invalidate();
			tmp.visible = false;

			return tmp;
		}
		private function createReleaseToRefresh():Sprite
		{
			var tmp:Sprite = new Sprite();

			var icon:BitmapData = (new DEFAULT_RELEASE_TO_REFRESH_ICON()).bitmapData;
			var img:Image = new Image(Texture.fromBitmapData(icon));
			tmp.addChild(img);

			var lab:Label = new Label();
			lab.x = 50;
			lab.text = "Release to refresh...";
			lab.styleNameList.add(ChattingCat.LABEL_GRAY_SUB_INFOMATION);
			tmp.addChild(lab);
			tmp.visible = false;

			return tmp;
		}
		private function createLoadingNewRecords():Sprite
		{
			var tmp:Sprite = new Sprite();
			var loading:MovieClip = new MovieClip(loadingTexture, 24);
			loading.scaleX = loading.scaleY = _baseScale;
			tmp.addChild(loading);
			loading.color = 0xFF707070;
			Starling.juggler.add(loading);

			var lab:Label = new Label();
//			lab.x = 50;
			lab.text = "Loading ...";
			lab.styleNameList.add(ChattingCat.LABEL_GRAY_SUB_INFOMATION);

			tmp.addChild(lab);
			tmp.visible = false;

			lab.x = loading.width + _refreshPadding;
			lab.validate();
			lab.y = (loading.height - lab.height) >> 1;


			return tmp;
		}
		private function createLoadingOldRecords():Sprite
		{
			var tmp:Sprite = new Sprite();
			var loading:MovieClip = new MovieClip(loadingTexture, 24);
			loading.scaleX = loading.scaleY = _baseScale;
			tmp.addChild(loading);
			loading.color = 0xFF707070;
			Starling.juggler.add(loading);

			var lab:Label = new Label();
//			lab.x = 50;
			lab.text = "Loading ...";
			lab.styleNameList.add(ChattingCat.LABEL_GRAY_SUB_INFOMATION);
			tmp.addChild(lab);

			lab.x = loading.width + _refreshPadding;
			lab.validate();
			lab.y = (loading.height - lab.height) >> 1;

			tmp.visible = false;

			return tmp;
		}

		public function get refreshPadding():int
		{
			return _refreshPadding;
		}

		public function set refreshPadding(value:int):void
		{
			_refreshPadding = value;
		}

		public function get baseScale():Number
		{
			return _baseScale;
		}

		public function set baseScale(value:Number):void
		{
			if(_baseScale == value) return;
			_baseScale = value;
		}

		public function get loadingTexture():Vector.<Texture>
		{
			return _loadingTexture;
		}

		public function set loadingTexture(value:Vector.<Texture>):void
		{
			if(_loadingTexture == value) return;
			_loadingTexture = value;
		}
	}
}