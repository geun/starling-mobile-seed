package nellson.date
{
	public class TimeAgo
	{
		public static function fromNow(time:Number):String {
			
			var totalSeconds:Number = new Date().time/1000 - time;
			var seconds:int = int(totalSeconds / 1000)
			var minutes:int = int(seconds * 60)
			var hour:int = int(minutes / 60)
			if (hour) {
				return hour + ' hour' + (hour > 1 ? 's' : '') + ' ago'
			} else if (minutes) {
				return minutes + ' minute' + (minutes > 1 ? 's' : '') + ' ago'
			} else if (seconds) {
				return seconds + ' second' + (seconds > 1 ? 's' : '') + ' ago'
			} else {
				return 'just now'
			}
			return null;
		}
		
		public static function getTimeStringFromDate(date:Date):String
		{
			var totalSeconds:Number = (new Date().time - date.time) / 1000;
			var totalMinutes:Number = totalSeconds / 60;
			var totalHours:Number = totalMinutes / 60;
			var totalDays:Number = totalHours / 24;
			
			if(totalDays >= 1){
				return Math.floor(totalDays) + " days ago";
			}else if(totalHours >= 2){
				return Math.floor(totalHours) + " hours ago";
			}else if(totalMinutes >= 1){
				return Math.floor(totalMinutes) + " minutes ago";
			}else if(totalSeconds >= 1){
				return Math.floor(totalSeconds) + " seconds ago";
			}
			
			return "just now";
			
		}
		
		public static function getTimeStringFromSec(time:uint):String{
			var totalSeconds:Number = new Date().time/1000 - time;
			var totalMinutes:Number = totalSeconds / 60;
			var totalHours:Number = totalMinutes / 60;
			var totalDays:Number = totalHours / 24;
			
			if(totalDays >= 2){
				return Math.floor(totalDays) + " days ago";
			}else if(totalHours >= 2){
				return Math.floor(totalHours) + " hours and "+Math.floor(totalMinutes) +" minutes ago";
			}else if(totalMinutes >= 1){
				return Math.floor(totalMinutes) + " minutes ago";
			}else if(totalSeconds >= 1){
				return Math.floor(totalSeconds) + " seconds ago";
			}
			
			return "1 second ago";
		}
		
		public static function getTimeStringFromStamp(string:String):String{
			var time:Number = Date.parse(string);
			var totalSeconds:Number = new Date().time/1000 - time;
			var totalMinutes:Number = totalSeconds / 60;
			var totalHours:Number = totalMinutes / 60;
			var totalDays:Number = totalHours / 24;
			
			if(totalDays >= 2){
				return Math.floor(totalDays) + " days ago";
			}else if(totalHours >= 2){
				return Math.floor(totalHours) + " hours and "+Math.floor(totalMinutes) +" minutes ago";
			}else if(totalMinutes >= 1){
				return Math.floor(totalMinutes) + " minutes ago";
			}else if(totalSeconds >= 1){
				return Math.floor(totalSeconds) + " seconds ago";
			}
			
			return "1 second ago";
			
			
		}
	}
}
