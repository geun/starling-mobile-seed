package nellson.starling.texture
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class TextureUtils
	{
		public function TextureUtils()
		{
			
			
		}
		
		public static function createTextureAtalsFromFont(fontName:String, format:TextFormat, chars:String, horizontalPadding:int = 0, verticalPadding:int = 0, filters:Array = null, forceMod2:Boolean = false ):BitmapFont
		{
			
			var text:TextField = new TextField();
			text.embedFonts = true;
			text.defaultTextFormat = format;

			text.multiline = false;
			text.autoSize = TextFieldAutoSize.LEFT;
			
			if(filters != null) text.filters = filters;
			
			var bitmaps:Vector.<Bitmap> = new Vector.<Bitmap>();
			
			var matrix:Matrix = new Matrix();
			matrix.translate(horizontalPadding, verticalPadding);
			
			for (var i:int = 0; i < chars.length; i++) 
			{
				text.text = chars.charAt(i);
				
				var width:int = (text.width%2 != 0 && forceMod2) ? text.width+1:text.width;
				var height:int = (text.height%2 != 0 && forceMod2) ? text.height+1:text.height;
				var bitmapData:BitmapData = new BitmapData(width+horizontalPadding *2, height + verticalPadding *2, true, 0x0);
				bitmapData.draw(text, matrix);
				var bitmap:Bitmap = new Bitmap(bitmapData);
				bitmap.name = chars.charCodeAt(i).toString();
				bitmaps.push(bitmap);
			}
			
			
			var textureAtals:BitmapFont = AtlasBuilder.buildBitmapFont(format.font, int(format.size), bitmaps, 1, 2, 1024,1024);
			return textureAtals;
			
			
		}
	}
}