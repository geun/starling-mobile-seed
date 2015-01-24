package nellson.layout
{
	public class GoldenRatio
	{
		public static function golden(value:Number):Number
		{
			if(value == 0)
			{
				return 1
			}
			return 1.0 + 1.0 / golden(value-1);
		}
		
		
		public static function getGoldenSize(size:int):Object
		{
			var result:Object = {}
			var big:int = Math.ceil(size/1.618);
			result.big = big
			result.small = int(size-big);
			return result;
			
		}
	}
}