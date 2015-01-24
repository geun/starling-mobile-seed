package app
{
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;

	import flash.geom.Rectangle;

	import nellson.starling.texture.TextureFactory;

	import starling.textures.Texture;

	public class Factory
	{
		public function Factory()
		{
		}

		public static function createBackgroundImage(colorName:String, color:uint):Scale9Image
		{
			var scale9Texture:Scale9Textures = createBackgroundTexture(colorName, color);
			var background:Scale9Image = new Scale9Image(scale9Texture, 1);

			return background;

		}

		public static function createBackgroundTexture(name:String, color:uint):Scale9Textures
		{
			var texture:Texture = TextureFactory.getInstance().getFromColor(name, 20,20, color);
			var textureRect:Rectangle = new Rectangle(5,5,10,10);
			var scale9Texture:Scale9Textures = new Scale9Textures(texture,textureRect);

			return scale9Texture;
		}


	}
}
