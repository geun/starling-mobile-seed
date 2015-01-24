package robotlegs.extensions.starlingViewMap.impl
{
	import org.osflash.signals.Signal;
	
	import robotlegs.extensions.starlingViewMap.api.IStarlingViewBase;
	
	import starling.display.Sprite;
	
	public class StarlingViewBase extends Sprite implements IStarlingViewBase
	{
		
		public var onEnterCompleted:Signal;
		public var onExitCompleted:Signal;
		public function StarlingViewBase()
		{
			super();
			
			onEnterCompleted = new Signal();
			onExitCompleted = new Signal();
			
			onEnterCompleted.add(enterTransitionsComplete);
			onExitCompleted.add(exitTranstionsComplete);
		}


		public function setup():void
		{
			//Override
		}

		public function invalidLayout():void
		{
			//Override 	
		}
		
		public function destory():void
		{
			//Override
		}
		
		
		public function enterTransitions():void
		{
			//override
			onEnterCompleted.dispatch();
		}
		
		public function enterTransitionsComplete():void
		{
			//override
		}
		
		public function exitTranstions():void
		{
			
			//override
			onExitCompleted.dispatch();
		}
		
		public function exitTranstionsComplete():void
		{
			//override
			this.visible = false;
		}
		
		public function onEnterView():void
		{
			enterTransitions();
		}
		
		public function onExitView():void
		{
			exitTranstions();
			//override
		}
		
		
		
		
	}
}