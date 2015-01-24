package nellson.utils
{
	public class ColorUtil
	{
		public function ColorUtil()
		{
		}
		
		
		
		public static function RGBtoHSV(red:Number, green:Number, blue:Number):Object
		{
			var min:Number, max:Number, s:Number, v:Number, h:Number = 0;
			
			max = Math.max(red, Math.max(green, blue));
			min = Math.min(red, Math.min(green, blue));
			
			if (max == 0)
			{
				return { h: 0, s: 0, v: 0 };
			}
			
			v = max;
			s = (max - min) / max;
			
			h = RGBToHue(red, green, blue);
			
			return { h: h, s: s, v: v };
		}
		
		private static function RGBToHue(red:Number, green:Number, blue:Number):uint
		{
			var f:Number, min:Number, mid:Number, max:Number, n:Number;
			
			max = Math.max(red, Math.max(green, blue));
			min = Math.min(red, Math.min(green, blue));
			
			// achromatic case
			if (max - min == 0)
			{
				return 0;
			}
			
			mid = RangeUtil.center(red, green, blue);
			
			// using this loop to avoid super-ugly nested ifs
			while (true)
			{
				if (red == max)
				{
					if (blue == min)
						n = 0;
					else
						n = 5;
					break;
				}
				
				if (green == max)
				{
					if (blue == min)
						n = 1;
					else
						n = 2;
					break;
				}
				
				if (red == min)
					n = 3;
				else
					n = 4;
				break;
			}
			
			if ((n % 2) == 0)
			{
				f = mid - min;
			}
			else
			{
				f = max - mid;
			}
			f = f / (max - min);
			
			return 60 * (n + f);
		}
		
		
		public static function HSVtoRGB(hue:Number, saturation:Number, value:Number):Object
		{
			var min:Number = (1 - saturation) * value;
			
			return HueToRGB(min, value, hue);
		}
		
		/**
		 * Convert hue to RGB values using a linear transformation.
		 * @param min   of R,G,B.
		 * @param max   of R,G,B.
		 * @param hue   value angle hue.
		 * @return              Object with R,G,B properties on 0-1 scale.
		 */
		private static function HueToRGB(min:Number, max:Number, hue:Number):Object
		{
			const HUE_MAX:uint = 360;
			
			var mu:Number, md:Number, F:Number, n:Number;
			while (hue < 0)
			{
				hue += HUE_MAX;
			}
			n = Math.floor(hue / 60);
			F = (hue - n * 60) / 60;
			n %= 6;
			
			mu = min + ((max - min) * F);
			md = max - ((max - min) * F);
			
			switch (n)
			{
				case 0:
					return { r: max, g: mu, b: min };
				case 1:
					return { r: md, g: max, b: min };
				case 2:
					return { r: min, g: max, b: mu };
				case 3:
					return { r: min, g: md, b: max };
				case 4:
					return { r: mu, g: min, b: max };
				case 5:
					return { r: max, g: min, b: md };
			}
			return null;
		}
		
		
		public static function getRGB(color:uint):Object
		{
			var c:Object = {};
			c.r = color >> 16 & 0xFF;
			c.g = color >> 8 & 0xFF;
			c.b = color & 0xFF;
			return c;
		}
		
		
	}
}