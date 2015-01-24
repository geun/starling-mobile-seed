package nellson.starling.texture {
	import flash.display.BitmapData;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	
	public class TextureFactory {
		
		private static var instance:TextureFactory;
		private var _textureDictionary:Dictionary;
		
		public function get textureDictionary():Dictionary
		{
			return _textureDictionary;
		}
		
		public function set textureDictionary(value:Dictionary):void
		{
			_textureDictionary = value;
		}
		
		public static function getInstance():TextureFactory {
			if (instance == null) {
				instance = new TextureFactory(new SingletonBlocker());
			}
			return instance;
		}
		
		public function TextureFactory(p_key:SingletonBlocker):void {
			// this shouldn't be necessary unless they fake out the compiler:
			if (p_key == null) {
				throw new Error("Error: Instantiation failed: Use TextureLoader.getInstance() instead of new.");
			}
		}
		
		public function getFromColor(name:String, width:Number, height:Number, color:uint=0xffffffff,optimizeForRenderToTexture:Boolean=false,scale:Number=-1, format:String="bgra"):Texture
		{
			
			if (textureDictionary == null) textureDictionary = new Dictionary();
			
			if (textureDictionary[name] != null) {
				return textureDictionary[name];
			} 
			else
			{
				var texture:Texture = Texture.fromColor( width, height, color, optimizeForRenderToTexture, scale, format);
				textureDictionary[name] = texture;
				return texture;
			}
			
			return null;
		}
		
		public function getBitmapTexture(name:String, ARG_bmp:Class):Texture {
			
			if (textureDictionary == null) textureDictionary = new Dictionary();
			
			if (textureDictionary[name] != null) {
				return textureDictionary[name];
			} else {
				var bmp:BitmapData = new ARG_bmp();
				var texture:Texture = Texture.fromBitmapData(new ARG_bmp());
				// dispose the bitmap data after it has been applied to a texture
				bmp.dispose();
				bmp = null;
				// assign the texture to the dictionary
				textureDictionary[name] = texture;
				return texture;
			}
			
			return null;
		}
		
		public function clearTexture(ARG_name:String):void {
			if (textureDictionary[ARG_name] != null) {
				textureDictionary[ARG_name].dispose();
				delete textureDictionary[ARG_name];
			}
		}
	}
}
// the following code is also in the SingletonDemo.as file
// this class is only available to SingletonDemo
// (despite the internal access designation)
internal class SingletonBlocker {}