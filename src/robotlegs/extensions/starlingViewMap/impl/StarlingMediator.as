package robotlegs.extensions.starlingViewMap.impl {
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.extensions.localEventMap.api.IEventMap;
	import robotlegs.bender.extensions.matching.instanceOfType;
	import robotlegs.bender.extensions.mediatorMap.api.IMediator;
	import robotlegs.extensions.starlingViewMap.api.IStarlingViewBase;
	
	import starling.display.DisplayObject;

	/**
	 * @author jamieowen
	 */
	public class StarlingMediator implements IMediator
	{
		[Inject]
		public var eventMap:IEventMap;

		[Inject]
		public var eventDispatcher:IEventDispatcher;

		private var _viewComponent:DisplayObject;

		public function set viewComponent(view:DisplayObject):void
		{
			_viewComponent = view;
		}
		
		public function get viewComponent():DisplayObject
		{
			return _viewComponent;
		}
		
		public function initialize() : void
		{
			if(instanceOfType(IStarlingViewBase).matches(viewComponent))
			{
				IStarlingViewBase(_viewComponent).setup();
			}
		}

		public function destroy() : void
		{
			eventMap.unmapListeners();
		}

		protected function addContextListener(eventString:String, listener:Function, eventClass:Class = null):void
		{
			eventMap.mapListener(eventDispatcher, eventString, listener, eventClass);
		}

		protected function removeContextListener(eventString:String, listener:Function, eventClass:Class = null):void
		{
			eventMap.unmapListener(eventDispatcher, eventString, listener, eventClass);
		}

		protected function dispatch(event:Event):void
		{
			if (eventDispatcher.hasEventListener(event.type))
				eventDispatcher.dispatchEvent(event);
		}
	}
}
