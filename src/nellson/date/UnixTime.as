package nellson.date
{
	public class UnixTime
	{
		
		public static function convert(date:Date):int
		{
			return Math.round(date.getTime()/1000);
		}
		
		public static function now():int
		{
			return convert(new Date())
		}
	}
}