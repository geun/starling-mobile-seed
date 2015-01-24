package app
{
	import flash.display.Stage;
	import flash.filesystem.File;

	import nellson.starling.texture.TextureLoader;

	import org.osflash.signals.Signal;

	import starling.display.MovieClip;

	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{

		[Embed(source="../../assets/images/background.jpg")]
		public static var backgroundPng:Class;

		[Embed(source="../../assets/images/logo.png")]
		public static var logoPng:Class;

		[Embed(source="../../assets/images/logo-white.png")]
		public static var logoWhitePng:Class;


		[Embed(source="../../assets/images/pullToRefresh/spinner.xml", mimeType="application/octet-stream")]
		private static var LoadingAtlasXML:Class;

		[Embed(source="../../assets/images/pullToRefresh/spinner.png")]
		private static var LoadingAtlasTexture:Class;


		public static var initialized:Boolean = false;
		public static var initializeComplete:Signal;

		private static var icons:TextureAtlas;

		public static const White:String = "White";

		public static var loadingMovieClipTexture:Vector.<Texture>;

		public static function init(stage:Stage, scale:Number):void
		{

			if(!initialized)
			{
				trace("Assets.init");
				initializeComplete = new Signal();

				var isRetina:Boolean = true;
//				var newScale:Number = isRetina ? 1.0 : .5;
				var appPath:File = File.applicationDirectory.resolvePath('assets/icons');

				function onLoadCompleteHandler(atlas:TextureAtlas):void
				{
					trace("Atlas is loaded!" + atlas);
					icons = atlas;
					initialized = true;
					initializeComplete.dispatch();

				}
				TextureLoader.load(appPath.url, onLoadCompleteHandler, scale);

				var texture:Texture = Texture.fromBitmap(new LoadingAtlasTexture());
				var xml:XML = XML(new LoadingAtlasXML());
				var atlas:TextureAtlas = new TextureAtlas(texture, xml);
				loadingMovieClipTexture = atlas.getTextures("spine");
//				 = new MovieClip(textures, 12);
			}
		}

		public static function getIconfromDAtlas(name:String):Texture
		{
			return icons.getTexture(name);
		}
	}
}
