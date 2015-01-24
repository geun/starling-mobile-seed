package nellson.ui.feathers
{
	import feathers.core.FeathersControl;

	import flash.display.BitmapData;

	import flash.display.Shape;

	import flash.display.Sprite;
	import flash.html.script.Package;

	import starling.animation.Tween;

	import starling.core.Starling;

	import starling.display.Image;
	import starling.events.Event;

	import starling.textures.Texture;
	import starling.utils.deg2rad;
	import starling.utils.rad2deg;

	public class IOSSpiner extends FeathersControl
	{
		private var slices:int;
		private var radius:int;
		private var _spinnerSkin:Image;

		private var _baseScale:Number = 1.0;

		public function IOSSpiner()
		{
			super();
		}

		override protected function initialize():void
		{
			super.initialize();
			//		http://sewonist.com/?p=3600
			this.slices = 12 * _baseScale;
			this.radius = 6 * _baseScale;

			spinnerSkin = this.makeSpinner();

			if(spinnerSkin)
			{
				var tween:Tween = new Tween(_spinnerSkin, 0.15);
				tween.repeatCount = 0;
				tween.animate("rotation", deg2rad(((_spinnerSkin.rotation) + (360 / slices)) % 360));
//				tween.animate("rotation", deg2rad(180));
				Starling.juggler.add(tween);
			}
		}


		private function onAddedToStageHandler(e:Event):void
		{
			trace("IOSSpiner.onAddedToStageHandler");
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStageHandler);


		}

		private function onRemoveFromStageHandler(e:Event):void
		{

		}

		override protected function draw():void
		{
			super.draw();

			const layoutInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_LAYOUT);
			const sizeInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_SIZE);

			if( layoutInvalid || sizeInvalid)
			{
				this.autoSizeIfNeeded();
				this.invalidLayout();
			}
		}

		protected function autoSizeIfNeeded():Boolean
		{

			const needsWidth:Boolean = isNaN(this.explicitWidth);
			const needsHeight:Boolean = isNaN(this.explicitHeight);

			if(!needsWidth && !needsHeight) return false;

			var newWidth:Number = this.explicitWidth;
			if(needsWidth)
			{
				if(_spinnerSkin)
				{
					newWidth = _spinnerSkin.width;
				}
			}

			var newHeight:Number = this.explicitHeight;
			if(needsHeight)
			{
				if(_spinnerSkin)
				{
					newHeight = _spinnerSkin.height;
				}
			}

			return this.setSizeInternal(newWidth, newHeight, false);
		}

		private function makeSpinner():Image
		{
			var i:int = slices;
			var degrees:int = 360 / slices;
			var slider:flash.display.Sprite = new flash.display.Sprite;
			while (i--)
			{
				var slice:Shape = getSlice();
				slice.alpha = Math.max(0.2, 1 - (0.1 * i));
				var radianAngle:Number = (degrees * i) * Math.PI / 180;
				slice.rotation = -degrees * i;
				slice.x = (Math.sin(radianAngle) * radius)+radius*2;
				slice.y = (Math.cos(radianAngle) * radius)+radius*2;

				slider.addChild(slice);
			}

			var bitamp:BitmapData = new BitmapData(slider.width, slider.height, true, 0);
			bitamp.draw(slider);

			var texture:Texture = Texture.fromBitmapData(bitamp, false, false);
			var spinner:Image = new Image(texture);
			spinner.pivotX = spinner.width >> 1;
			spinner.pivotY = spinner.height >> 1;

			return spinner;
		}

		private function getSlice():Shape
		{
			var slice:Shape = new Shape();
//			slice.graphics.beginFill(0x222222);
			slice.graphics.beginFill(0xffffff);
			slice.graphics.drawRoundRect(-1 * _baseScale, 0, 2 * _baseScale, radius, radius*2, radius*2);
			slice.graphics.endFill();

			return slice;
		}

		public function get spinnerSkin():Image
		{
			return _spinnerSkin;
		}

		public function set spinnerSkin(value:Image):void
		{
			if(_spinnerSkin == value)
			{
				return;
			}

			if(_spinnerSkin)
			{
				removeChild(_spinnerSkin);
			}

			_spinnerSkin = value;

			if(this._spinnerSkin && this._spinnerSkin.parent != this)
			{
				_spinnerSkin.visible = true;
				_spinnerSkin.touchable = false;
				addChild(_spinnerSkin);
			}
		}
		
		private function invalidLayout():void
		{

		}
	}
}
