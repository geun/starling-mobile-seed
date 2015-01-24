package nellson.utils
{
	public class StringUtil
	{
		public function StringUtil()
		{
		}

		public static function truncate(source:String, len:int = 30):String
		{
			var truncatedString:String = source;

			if(truncatedString.length > len)
			{
				truncatedString.slice(0, len);
				truncatedString += "...";
			}
			return truncatedString;
		}
	}
}
