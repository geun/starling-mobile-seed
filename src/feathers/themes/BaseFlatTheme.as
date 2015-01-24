/*
Copyright (c) 2014 FlashDaily.net

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/
package feathers.themes
{
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontPosture;
	import flash.text.engine.FontWeight;
	import flash.text.engine.RenderingMode;
	
	import starling.textures.TextureSmoothing;
	
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.Callout;
	import feathers.controls.Check;
	import feathers.controls.Drawers;
	import feathers.controls.GroupedList;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.NumericStepper;
	import feathers.controls.PageIndicator;
	import feathers.controls.Panel;
	import feathers.controls.PanelScreen;
	import feathers.controls.PickerList;
	import feathers.controls.ProgressBar;
	import feathers.controls.Radio;
	import feathers.controls.ScrollContainer;
	import feathers.controls.ScrollText;
	import feathers.controls.Scroller;
	import feathers.controls.SimpleScrollBar;
	import feathers.controls.Slider;
	import feathers.controls.TabBar;
	import feathers.controls.TextArea;
	import feathers.controls.TextInput;
	import feathers.controls.ToggleButton;
	import feathers.controls.ToggleSwitch;
	import feathers.controls.popups.CalloutPopUpContentManager;
	import feathers.controls.popups.VerticalCenteredPopUpContentManager;
	import feathers.controls.renderers.BaseDefaultItemRenderer;
	import feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.text.StageTextTextEditor;
	import feathers.controls.text.TextBlockTextEditor;
	import feathers.controls.text.TextBlockTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.PopUpManager;
	import feathers.display.Scale3Image;
	import feathers.display.Scale9Image;
	import feathers.display.TiledImage;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.skins.SmartDisplayObjectStateValueSelector;
	import feathers.skins.StandardIcons;
	import feathers.system.DeviceCapabilities;
	import feathers.textures.Scale3Textures;
	import feathers.textures.Scale9Textures;
	import feathers.controls.SpinnerList;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.textures.SubTexture;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class BaseFlatTheme extends StyleNameFunctionTheme
	{
		
		private var FONT_NAME:String;
		private var FONT_NAME_BOLD:String;
		
		protected static const PRIMARY_BACKGROUND_COLOR:Number = 0xffffff;
		protected static const LIGHT_TEXT_COLOR:Number= 0xffffff;
		protected static const DARK_TEXT_COLOR:Number = 0x576473;
		protected static const SELECTED_TEXT_COLOR:Number = 0xffffff;
		protected static const DISABLED_TEXT_COLOR:Number = 0xabb1b9;
		protected static const DARK_DISABLED_TEXT_COLOR:Number = 0xabb1b9; 
		protected static const LIST_BACKGROUND_COLOR:Number = 0xf4f4f4;
		protected static const TAB_DISABLED_BACKGROUND_COLOR:Number = PRIMARY_BACKGROUND_COLOR;
		protected static const GROUPED_LIST_HEADER_BACKGROUND_COLOR:Number = 0x2c3e50;
		protected static const GROUPED_LIST_FOOTER_BACKGROUND_COLOR:Number = 0x2c3e50;
		protected static const MODAL_OVERLAY_COLOR:Number = 0xffffff;
		protected static const MODAL_OVERLAY_ALPHA:Number = 1;				
		
		protected static const TAB_BACKGROUND_COLOR:uint = 0x46607b;
		protected static const DRAWER_OVERLAY_COLOR:uint = 0xffffff;
		protected static const DRAWER_OVERLAY_ALPHA:Number = 0.7;
		
		
		/**
		 * The screen density of an iPhone with Retina display. The textures
		 * used by this theme are designed for this density and scale for other
		 * densities.
		 */
		protected static const ORIGINAL_DPI_IPHONE_RETINA:int = 326;
		
		/**
		 * The screen density of an iPad with Retina display. The textures used
		 * by this theme are designed for this density and scale for other
		 * densities.
		 */
		protected static const ORIGINAL_DPI_IPAD_RETINA:int =264;
		
		protected static const BUTTON_SCALE9_GRID:Rectangle = new Rectangle(8, 8, 184, 84);		
		protected static const BUTTON_SELECTED_SCALE9_GRID:Rectangle = BUTTON_SCALE9_GRID;
		protected static const POPUP_SCALE9_GRID:Rectangle = new Rectangle(24, 24, 150, 150);
		
		protected static const BACK_BUTTON_SCALE3_REGION1:Number = 64;
		protected static const BACK_BUTTON_SCALE3_REGION2:Number = 94;
		
		protected static const FORWARD_BUTTON_SCALE3_REGION1:Number = 8;
		protected static const FORWARD_BUTTON_SCALE3_REGION2:Number = 102;
		
		protected static const ITEM_RENDERER_SCALE9_GRID:Rectangle = new Rectangle(24, 24, 546, 38);
		protected static const INSET_ITEM_RENDERER_FIRST_SCALE9_GRID:Rectangle = new Rectangle(13, 13, 3, 70);
		protected static const INSET_ITEM_RENDERER_LAST_SCALE9_GRID:Rectangle = new Rectangle(13, 0, 3, 75);
		protected static const INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID:Rectangle = new Rectangle(13, 13, 3, 62);
		protected static const TAB_SCALE9_GRID:Rectangle = new Rectangle(16, 16, 56, 30);
		protected static const SCROLL_BAR_THUMB_REGION1:int = 10;
		protected static const SCROLL_BAR_THUMB_REGION2:int = 28;
		
		protected static const SPINNER_LIST_SELECTION_OVERLAY_SCALE9_GRID:Rectangle = new Rectangle(8, 8, 184, 84);//new Rectangle(11, 11, 2, 2);
		
		/**
		 * @private
		 * The theme's custom style name for item renderers in a PickerList.
		 */
		protected static const THEME_NAME_PICKER_LIST_ITEM_RENDERER:String = "flat-theme-mobile--picker-list-item-renderer";
		
		/**
		 * @private
		 * The theme's custom style name for item renderers in a SpinnerList.
		 */
		protected static const THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER:String = "flat-theme-mobile-spinner-list-item-renderer";
		
		/**
		 * @private
		 * The theme's custom style name for buttons in an Alert's button group.
		 */
		protected static const THEME_NAME_ALERT_BUTTON_GROUP_BUTTON:String = "flat-theme-mobile--alert-button-group-button";
		
		/**
		 * @private
		 * The theme's custom style name for the thumb of a horizontal SimpleScrollBar.
		 */
		protected static const THEME_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB:String = "flat-theme-mobile--horizontal-simple-scroll-bar-thumb";
		
		/**
		 * @private
		 * The theme's custom style name for the thumb of a vertical SimpleScrollBar.
		 */
		protected static const THEME_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB:String = "flat-theme-mobile--vertical-simple-scroll-bar-thumb";
		
		/**
		 * @private
		 * The theme's custom style name for the minimum track of a horizontal slider.
		 */
		protected static const THEME_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK:String = "flat-theme-mobile--horizontal-slider-minimum-track";
		
		/**
		 * @private
		 * The theme's custom style name for the maximum track of a horizontal slider.
		 */
		protected static const THEME_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK:String = "flat-theme-mobile--horizontal-slider-maximum-track";
		
		/**
		 * @private
		 * The theme's custom style name for the minimum track of a vertical slider.
		 */
		protected static const THEME_NAME_VERTICAL_SLIDER_MINIMUM_TRACK:String = "flat-theme-mobile--vertical-slider-minimum-track";
		
		/**
		 * @private
		 * The theme's custom style name for the maximum track of a vertical slider.
		 */
		protected static const THEME_NAME_VERTICAL_SLIDER_MAXIMUM_TRACK:String = "flat-theme-mobile--vertical-slider-maximum-track";
		
		/**
		 * The default global text renderer factory for this theme creates a
		 * TextBlockTextRenderer.
		 */
		protected static function textRendererFactory():TextBlockTextRenderer
		{
			return new TextBlockTextRenderer();
		}
		
		/**
		 * The default global text editor factory for this theme creates a
		 * StageTextTextEditor.
		 */
		protected static function textEditorFactory():StageTextTextEditor
		{
			return new StageTextTextEditor();
		}
		
		/**
		 * The text editor factory for a NumericStepper creates a
		 * TextBlockTextEditor.
		 */
		protected static function stepperTextEditorFactory():TextBlockTextEditor
		{
			//we're only using this text editor in the NumericStepper because
			//isEditable is false on the TextInput. this text editor is not
			//suitable for mobile use if the TextInput needs to be editable
			//because it can't use the soft keyboard or other mobile-friendly UI
			return new TextBlockTextEditor();
		}
		
		/**
		 * This theme's scroll bar type is SimpleScrollBar.
		 */
		protected static function scrollBarFactory():SimpleScrollBar
		{
			return new SimpleScrollBar();
		}
		
		protected static function popUpOverlayFactory():DisplayObject
		{
			var quad:Quad = new Quad(100, 100, MODAL_OVERLAY_COLOR);
			quad.alpha = MODAL_OVERLAY_ALPHA;
			return quad;
		}
		
		
		/**
		 * SmartDisplayObjectValueSelectors will use ImageLoader instead of
		 * Image so that we can use extra features like pixel snapping.
		 */
		protected static function textureValueTypeHandler(value:Texture, oldDisplayObject:DisplayObject = null):DisplayObject
		{
			var displayObject:ImageLoader = oldDisplayObject as ImageLoader;
			if(!displayObject)
			{
				displayObject = new ImageLoader();
			}
			displayObject.source = value;
			return displayObject;
		}
		
		/**
		 * Constructor.
		 *
		 * @param scaleToDPI Determines if the theme's skins will be scaled based on the screen density and content scale factor.
		 */
		public function BaseFlatTheme(scaleToDPI:Boolean = true, fontNameRegular:String = "", fontNameBold:String = "")
		{
			FONT_NAME = fontNameRegular;
			FONT_NAME_BOLD = fontNameBold;
			
			this._scaleToDPI = scaleToDPI;
		}
		
		/**
		 * @private
		 */
		protected var _originalDPI:int;
		
		/**
		 * The original screen density used for scaling.
		 */
		public function get originalDPI():int
		{
			return this._originalDPI;
		}
		
		/**
		 * @private
		 */
		protected var _scaleToDPI:Boolean;
		
		/**
		 * Indicates if the theme scales skins to match the screen density of
		 * the device.
		 */
		public function get scaleToDPI():Boolean
		{
			return this._scaleToDPI;
		}
		
		/**
		 * Skins are scaled by a value based on the screen density on the
		 * content scale factor.
		 */
		protected var scale:Number = 1;
		
		/**
		 * A smaller font size for details.
		 */
		protected var smallFontSize:int;
		
		/**
		 * A normal font size.
		 */
		protected var regularFontSize:int;
		
		/**
		 * A larger font size for headers.
		 */
		protected var largeFontSize:int;
		
		/**
		 * An extra large font size.
		 */
		protected var extraLargeFontSize:int;
		
		/**
		 * The size, in pixels, of major regions in the grid. Used for sizing
		 * containers and larger UI controls.
		 */
		protected var gridSize:int;
		
		/**
		 * The size, in pixels, of minor regions in the grid. Used for larger
		 * padding and gaps.
		 */
		protected var gutterSize:int;
		
		/**
		 * The size, in pixels, of smaller padding and gaps within the major
		 * regions in the grid.
		 */
		protected var smallGutterSize:int;
		
		/**
		 * The width, in pixels, of UI controls that span across multiple grid regions.
		 */
		protected var wideControlSize:int;
		
		/**
		 * The size, in pixels, of a typical UI control.
		 */
		protected var controlSize:int;
		
		/**
		 * The size, in pixels, of smaller UI controls.
		 */
		protected var smallControlSize:int;
		
		protected var popUpFillSize:int;
		protected var calloutBackgroundMinSize:int;
		protected var scrollBarGutterSize:int;
		
		/**
		 * The FTE FontDescription used for text of a normal weight.
		 */
		protected var regularFontDescription:FontDescription;
		
		/**
		 * The FTE FontDescription used for text of a bold weight.
		 */
		protected var boldFontDescription:FontDescription;
		
		/**
		 * ScrollText uses TextField instead of FTE, so it has a separate TextFormat.
		 */
		protected var scrollTextTextFormat:TextFormat;
		
		/**
		 * ScrollText uses TextField instead of FTE, so it has a separate disabled TextFormat.
		 */
		protected var scrollTextDisabledTextFormat:TextFormat;
		
		/**
		 * An ElementFormat used for Header components.
		 */
		protected var headerElementFormat:ElementFormat;
		protected var alertHeaderElementFormat:ElementFormat;
		
		/**
		 * An ElementFormat with a dark tint meant for UI controls.
		 */
		protected var darkUIElementFormat:ElementFormat;
		
		/**
		 * An ElementFormat with a light tint meant for UI controls.
		 */
		protected var lightUIElementFormat:ElementFormat;
		
		/**
		 * An ElementFormat with a highlighted tint meant for selected UI controls.
		 */
		protected var selectedUIElementFormat:ElementFormat;
		
		/**
		 * An ElementFormat with a light tint meant for disabled UI controls.
		 */
		protected var lightUIDisabledElementFormat:ElementFormat;
		
		/**
		 * An ElementFormat with a dark tint meant for disabled UI controls.
		 */
		protected var darkUIDisabledElementFormat:ElementFormat;
		
		/**
		 * An ElementFormat with a dark tint meant for larger UI controls.
		 */
		protected var largeUIDarkElementFormat:ElementFormat;
		
		/**
		 * An ElementFormat with a light tint meant for larger UI controls.
		 */
		protected var largeUILightElementFormat:ElementFormat;
		
		/**
		 * An ElementFormat with a highlighted tint meant for larger UI controls.
		 */
		protected var largeUISelectedElementFormat:ElementFormat;
		
		/**
		 * An ElementFormat with a dark tint meant for larger disabled UI controls.
		 */
		protected var largeUIDarkDisabledElementFormat:ElementFormat;
		
		/**
		 * An ElementFormat with a light tint meant for larger disabled UI controls.
		 */
		protected var largeUILightDisabledElementFormat:ElementFormat;
		
		/**
		 * An ElementFormat with a dark tint meant for larger text.
		 */
		protected var largeDarkElementFormat:ElementFormat;
		
		/**
		 * An ElementFormat with a light tint meant for larger text.
		 */
		protected var largeLightElementFormat:ElementFormat;
		
		/**
		 * An ElementFormat meant for larger disabled text.
		 */
		protected var largeDisabledElementFormat:ElementFormat;
		
		/**
		 * An ElementFormat with a dark tint meant for regular text.
		 */
		protected var darkElementFormat:ElementFormat;
		
		/**
		 * An ElementFormat with a light tint meant for regular text.
		 */
		protected var lightElementFormat:ElementFormat;
		
		/**
		 * An ElementFormat meant for regular, disabled text.
		 */
		protected var disabledElementFormat:ElementFormat;
		
		/**
		 * An ElementFormat with a light tint meant for smaller text.
		 */
		protected var smallLightElementFormat:ElementFormat;
		
		protected var smallDarkElementFormat:ElementFormat;
		
		/**
		 * An ElementFormat meant for smaller, disabled text.
		 */
		protected var smallDisabledElementFormat:ElementFormat;
		
		/**
		 * The texture atlas that contains skins for this theme. This base class
		 * does not initialize this member variable. Subclasses are expected to
		 * load the assets somehow and set the <code>atlas</code> member
		 * variable before calling <code>initialize()</code>.
		 */
		protected var atlas:TextureAtlas;
		
		protected var headerBackgroundSkinTexture:Texture;
		protected var backgroundSkinTextures:Scale9Textures;
		protected var backgroundInsetSkinTextures:Scale9Textures;
		protected var backgroundDisabledSkinTextures:Scale9Textures;
		protected var backgroundFocusedSkinTextures:Scale9Textures;
		protected var buttonUpSkinTextures:Scale9Textures;
		protected var buttonDownSkinTextures:Scale9Textures;
		protected var buttonDisabledSkinTextures:Scale9Textures;
		protected var buttonSelectedUpSkinTextures:Scale9Textures;
		protected var buttonSelectedDisabledSkinTextures:Scale9Textures;
		protected var buttonCallToActionUpSkinTextures:Scale9Textures;
		protected var buttonCallToActionDownSkinTextures:Scale9Textures;
		protected var buttonDangerUpSkinTextures:Scale9Textures;
		protected var buttonDangerDownSkinTextures:Scale9Textures;
		protected var buttonBackUpSkinTextures:Scale3Textures;
		protected var buttonBackDownSkinTextures:Scale3Textures;
		protected var buttonBackDisabledSkinTextures:Scale3Textures;
		protected var buttonForwardUpSkinTextures:Scale3Textures;
		protected var buttonForwardDownSkinTextures:Scale3Textures;
		protected var buttonForwardDisabledSkinTextures:Scale3Textures;
		protected var pickerListButtonIconTexture:Texture;
		protected var pickerListButtonIconDisabledTexture:Texture;
		protected var tabDownSkinTextures:Scale9Textures;
		protected var tabDownDisabledSkinTextures:Scale9Textures;
		protected var tabSelectedSkinTextures:Scale9Textures;
		protected var tabSelectedDisabledSkinTextures:Scale9Textures;
		protected var pickerListItemSelectedIconTexture:Texture;
		protected var radioUpIconTexture:Texture;
		protected var radioDownIconTexture:Texture;
		protected var radioDisabledIconTexture:Texture;
		protected var radioSelectedUpIconTexture:Texture;
		protected var radioSelectedDownIconTexture:Texture;
		protected var radioSelectedDisabledIconTexture:Texture;
		protected var checkUpIconTexture:Texture;
		protected var checkDownIconTexture:Texture;
		protected var checkDisabledIconTexture:Texture;
		protected var checkSelectedUpIconTexture:Texture;
		protected var checkSelectedDownIconTexture:Texture;
		protected var checkSelectedDisabledIconTexture:Texture;
		protected var pageIndicatorNormalSkinTexture:Texture;
		protected var pageIndicatorSelectedSkinTexture:Texture;
		protected var itemRendererUpSkinTextures:Scale9Textures;
		protected var itemRendererSelectedSkinTextures:Scale9Textures;
		protected var insetItemRendererFirstUpSkinTextures:Scale9Textures;
		protected var insetItemRendererFirstSelectedSkinTextures:Scale9Textures;
		protected var insetItemRendererLastUpSkinTextures:Scale9Textures;
		protected var insetItemRendererLastSelectedSkinTextures:Scale9Textures;
		protected var insetItemRendererSingleUpSkinTextures:Scale9Textures;
		protected var insetItemRendererSingleSelectedSkinTextures:Scale9Textures;
		protected var backgroundPopUpSkinTextures:Scale9Textures;
		protected var calloutTopArrowSkinTexture:Texture;
		protected var calloutRightArrowSkinTexture:Texture;
		protected var calloutBottomArrowSkinTexture:Texture;
		protected var calloutLeftArrowSkinTexture:Texture;
		protected var verticalScrollBarThumbSkinTextures:Scale3Textures;
		protected var horizontalScrollBarThumbSkinTextures:Scale3Textures;
		protected var searchIconTexture:Texture;
		protected var searchIconDisabledTexture:Texture;
		
		protected var buttonRedLightUpSkinTextures:Scale9Textures;
		protected var buttonRedLightDownSkinTextures:Scale9Textures;
		
		protected var spinnerListSelectionOverlaySkinTextures:Scale9Textures;
		
		private var bg_null:Scale9Textures;
		private var bg_popup:Scale9Textures;
		
		private var btn_blue_second:Scale9Textures;
		
		private var skin_text_input:Scale9Textures;
		private var skin_text_input_focus:Scale9Textures;		
		
		
		/**
		 * Disposes the atlas before calling super.dispose()
		 */
		override public function dispose():void
		{
			if(this.atlas)
			{
				this.atlas.dispose();
				this.atlas = null;
			}
			
			//don't forget to call super.dispose()!
			super.dispose();
		}
		
		/**
		 * Initializes the theme. Expected to be called by subclasses after the
		 * assets have been loaded and the skin texture atlas has been created.
		 */
		protected function initialize():void
		{
			this.initializeScale();
			this.initializeDimensions();
			this.initializeFonts();
			this.initializeTextures();
			this.initializeGlobals();
			this.initializeStage();
			this.initializeStyleProviders();
		}
		
		/**
		 * Sets the stage background color.
		 */
		protected function initializeStage():void
		{
			Starling.current.stage.color = PRIMARY_BACKGROUND_COLOR;
			Starling.current.nativeStage.color = PRIMARY_BACKGROUND_COLOR;
		}
		
		/**
		 * Initializes global variables (not including global style providers).
		 */
		protected function initializeGlobals():void
		{
			FeathersControl.defaultTextRendererFactory = textRendererFactory;
			FeathersControl.defaultTextEditorFactory = textEditorFactory;
			
			PopUpManager.overlayFactory = popUpOverlayFactory;
			Callout.stagePadding = this.smallGutterSize;
		}
		
		/**
		 * Initializes the scale value based on the screen density and content
		 * scale factor.
		 */
		protected function initializeScale():void
		{
			var scaledDPI:int = DeviceCapabilities.dpi / Starling.contentScaleFactor;
			this._originalDPI = scaledDPI;
			if(this._scaleToDPI)
			{
				if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
				{
					this._originalDPI = ORIGINAL_DPI_IPAD_RETINA;
				}
				else
				{
					this._originalDPI = ORIGINAL_DPI_IPHONE_RETINA;
				}
			}
			this.scale = scaledDPI / this._originalDPI;
		}
		
		/**
		 * Initializes common values used for setting the dimensions of components.
		 */
		protected function initializeDimensions():void
		{
			this.gridSize = Math.round(88 * this.scale);
			this.smallGutterSize = Math.round(11 * this.scale);
			this.gutterSize = Math.round(22 * this.scale);
			this.controlSize = Math.round(58 * this.scale);
			this.smallControlSize = Math.round(22 * this.scale);
			this.popUpFillSize = Math.round(552 * this.scale);
			this.calloutBackgroundMinSize = Math.round(11 * this.scale);
			this.scrollBarGutterSize = Math.round(4 * this.scale);
			this.wideControlSize = this.gridSize * 3 + this.gutterSize * 2;
		}
		
		/**
		 * Initializes font sizes and formats.
		 */
		protected function initializeFonts():void
		{
			this.smallFontSize = Math.round(18 * this.scale);
			this.regularFontSize = Math.round(24 * this.scale);
			this.largeFontSize = Math.round(28 * this.scale);
			this.extraLargeFontSize = Math.round(36 * this.scale);
			
			//these are for components that don't use FTE
			this.scrollTextTextFormat = new TextFormat("_sans", this.regularFontSize, DARK_TEXT_COLOR);
			this.scrollTextDisabledTextFormat = new TextFormat("_sans", this.regularFontSize, DISABLED_TEXT_COLOR);
			
			this.regularFontDescription = new FontDescription(FONT_NAME, FontWeight.NORMAL, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE);
			this.boldFontDescription = new FontDescription(FONT_NAME_BOLD, FontWeight.BOLD, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE);
			
			this.alertHeaderElementFormat = new ElementFormat(this.boldFontDescription, this.extraLargeFontSize, DARK_TEXT_COLOR);
			this.headerElementFormat = new ElementFormat(this.boldFontDescription, this.extraLargeFontSize, LIGHT_TEXT_COLOR);
			
			this.darkUIElementFormat = new ElementFormat(this.boldFontDescription, this.regularFontSize, DARK_TEXT_COLOR);
			this.lightUIElementFormat = new ElementFormat(this.boldFontDescription, this.regularFontSize, LIGHT_TEXT_COLOR);
			this.selectedUIElementFormat = new ElementFormat(this.boldFontDescription, this.regularFontSize, SELECTED_TEXT_COLOR);
			this.lightUIDisabledElementFormat = new ElementFormat(this.boldFontDescription, this.regularFontSize, DISABLED_TEXT_COLOR);
			this.darkUIDisabledElementFormat = new ElementFormat(this.boldFontDescription, this.regularFontSize, DARK_DISABLED_TEXT_COLOR);
			
			this.largeUIDarkElementFormat = new ElementFormat(this.boldFontDescription, this.largeFontSize, DARK_TEXT_COLOR);
			this.largeUILightElementFormat = new ElementFormat(this.boldFontDescription, this.largeFontSize, LIGHT_TEXT_COLOR);
			this.largeUISelectedElementFormat = new ElementFormat(this.boldFontDescription, this.largeFontSize, SELECTED_TEXT_COLOR);
			this.largeUIDarkDisabledElementFormat = new ElementFormat(this.boldFontDescription, this.largeFontSize, DARK_DISABLED_TEXT_COLOR);
			this.largeUILightDisabledElementFormat = new ElementFormat(this.boldFontDescription, this.largeFontSize, DISABLED_TEXT_COLOR);
			
			this.darkElementFormat = new ElementFormat(this.regularFontDescription, this.regularFontSize, DARK_TEXT_COLOR);
			this.lightElementFormat = new ElementFormat(this.regularFontDescription, this.regularFontSize, LIGHT_TEXT_COLOR);
			this.disabledElementFormat = new ElementFormat(this.regularFontDescription, this.regularFontSize, DISABLED_TEXT_COLOR);
			
			this.smallLightElementFormat = new ElementFormat(this.regularFontDescription, this.smallFontSize, LIGHT_TEXT_COLOR);
			this.smallDarkElementFormat = new ElementFormat(this.regularFontDescription, this.smallFontSize, DARK_TEXT_COLOR);
			
			this.smallDisabledElementFormat = new ElementFormat(this.regularFontDescription, this.smallFontSize, DISABLED_TEXT_COLOR);
			
			this.largeDarkElementFormat = new ElementFormat(this.regularFontDescription, this.largeFontSize, DARK_TEXT_COLOR);
			this.largeLightElementFormat = new ElementFormat(this.regularFontDescription, this.largeFontSize, LIGHT_TEXT_COLOR);
			this.largeDisabledElementFormat = new ElementFormat(this.regularFontDescription, this.largeFontSize, DISABLED_TEXT_COLOR);
			
			//////////////////////
			
		}
		
		
		/**
		 * Initializes the textures by extracting them from the atlas and
		 * setting up any scaling grids that are needed.
		 */
		protected function initializeTextures():void
		{
			
			var rect_bg:Rectangle = new Rectangle(8, 8, 70, 10);
			bg_null = new Scale9Textures(this.atlas.getTexture("null_bg"), new Rectangle(0,0,1,1)); 
			bg_popup = new Scale9Textures(this.atlas.getTexture("background-popup-skin"), POPUP_SCALE9_GRID); 
			skin_text_input = new Scale9Textures(this.atlas.getTexture("textinput-up"), BUTTON_SCALE9_GRID);
			skin_text_input_focus = new Scale9Textures(this.atlas.getTexture("textinput-focus"), BUTTON_SCALE9_GRID);
			btn_blue_second = new Scale9Textures(this.atlas.getTexture("button-blue-second"), BUTTON_SCALE9_GRID);
			
			this.buttonRedLightUpSkinTextures = new Scale9Textures(this.atlas.getTexture("button-redlight-up-skin"), BUTTON_SCALE9_GRID);
			this.buttonRedLightDownSkinTextures = new Scale9Textures(this.atlas.getTexture("button-redlight-down-skin"), BUTTON_SCALE9_GRID);
			
			this.buttonUpSkinTextures = new Scale9Textures(this.atlas.getTexture("button-up-skin"), BUTTON_SCALE9_GRID);
			this.buttonDownSkinTextures = new Scale9Textures(this.atlas.getTexture("button-down-skin"), BUTTON_SCALE9_GRID);
			this.buttonDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("button-disabled-skin"), BUTTON_SCALE9_GRID);
			this.buttonSelectedUpSkinTextures = new Scale9Textures(this.atlas.getTexture("button-selected-up-skin"), BUTTON_SELECTED_SCALE9_GRID);
			this.buttonSelectedDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("button-selected-disabled-skin"), BUTTON_SELECTED_SCALE9_GRID);
			this.buttonCallToActionUpSkinTextures = new Scale9Textures(this.atlas.getTexture("button-call-to-action-up-skin"), BUTTON_SCALE9_GRID);
			this.buttonCallToActionDownSkinTextures = new Scale9Textures(this.atlas.getTexture("button-call-to-action-down-skin"), BUTTON_SCALE9_GRID);
			this.buttonDangerUpSkinTextures = new Scale9Textures(this.atlas.getTexture("button-danger-up-skin"), BUTTON_SCALE9_GRID);
			this.buttonDangerDownSkinTextures = new Scale9Textures(this.atlas.getTexture("button-danger-down-skin"), BUTTON_SCALE9_GRID);
			this.buttonBackUpSkinTextures = new Scale3Textures(this.atlas.getTexture("button-back-up-skin"), BACK_BUTTON_SCALE3_REGION1, BACK_BUTTON_SCALE3_REGION2);
			this.buttonBackDownSkinTextures = new Scale3Textures(this.atlas.getTexture("button-back-down-skin"), BACK_BUTTON_SCALE3_REGION1, BACK_BUTTON_SCALE3_REGION2);
			this.buttonBackDisabledSkinTextures = new Scale3Textures(this.atlas.getTexture("button-back-disabled-skin"), BACK_BUTTON_SCALE3_REGION1, BACK_BUTTON_SCALE3_REGION2);
			this.buttonForwardUpSkinTextures = new Scale3Textures(this.atlas.getTexture("button-forward-up-skin"), FORWARD_BUTTON_SCALE3_REGION1, FORWARD_BUTTON_SCALE3_REGION2);
			this.buttonForwardDownSkinTextures = new Scale3Textures(this.atlas.getTexture("button-forward-down-skin"), FORWARD_BUTTON_SCALE3_REGION1, FORWARD_BUTTON_SCALE3_REGION2);
			this.buttonForwardDisabledSkinTextures = new Scale3Textures(this.atlas.getTexture("button-forward-disabled-skin"), FORWARD_BUTTON_SCALE3_REGION1, FORWARD_BUTTON_SCALE3_REGION2);
			
			this.tabDownSkinTextures = new Scale9Textures(this.atlas.getTexture("tab-down-skin"), TAB_SCALE9_GRID);
			this.tabDownDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("tab-down-disabled"), TAB_SCALE9_GRID);
			
			this.tabSelectedSkinTextures = new Scale9Textures(this.atlas.getTexture("tab-selected-skin"), TAB_SCALE9_GRID);
			this.tabSelectedDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("tab-selected-disabled-skin"), TAB_SCALE9_GRID);
			
			this.pickerListButtonIconTexture = this.atlas.getTexture("picker-list-icon");
			this.pickerListButtonIconDisabledTexture = this.atlas.getTexture("picker-list-icon-disabled");
			this.pickerListItemSelectedIconTexture = this.atlas.getTexture("picker-list-item-selected-icon");
			
			this.pageIndicatorSelectedSkinTexture = this.atlas.getTexture("page-indicator-selected-skin");
			this.pageIndicatorNormalSkinTexture = this.atlas.getTexture("page-indicator-normal-skin");
			
			this.searchIconTexture = this.atlas.getTexture("search-icon");
			this.searchIconDisabledTexture = this.atlas.getTexture("search-icon-disabled");
			
			this.itemRendererUpSkinTextures = new Scale9Textures(this.atlas.getTexture("list-item-up-skin"), ITEM_RENDERER_SCALE9_GRID);
			this.itemRendererSelectedSkinTextures = new Scale9Textures(this.atlas.getTexture("list-item-selected-skin"), ITEM_RENDERER_SCALE9_GRID);
			this.insetItemRendererFirstUpSkinTextures = new Scale9Textures(this.atlas.getTexture("list-inset-item-first-up-skin"), INSET_ITEM_RENDERER_FIRST_SCALE9_GRID);
			this.insetItemRendererFirstSelectedSkinTextures = new Scale9Textures(this.atlas.getTexture("list-inset-item-first-selected-skin"), INSET_ITEM_RENDERER_FIRST_SCALE9_GRID);
			this.insetItemRendererLastUpSkinTextures = new Scale9Textures(this.atlas.getTexture("list-inset-item-last-up-skin"), INSET_ITEM_RENDERER_LAST_SCALE9_GRID);
			this.insetItemRendererLastSelectedSkinTextures = new Scale9Textures(this.atlas.getTexture("list-inset-item-last-selected-skin"), INSET_ITEM_RENDERER_LAST_SCALE9_GRID);
			this.insetItemRendererSingleUpSkinTextures = new Scale9Textures(this.atlas.getTexture("list-inset-item-single-up-skin"), INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID);
			this.insetItemRendererSingleSelectedSkinTextures = new Scale9Textures(this.atlas.getTexture("list-inset-item-single-selected-skin"), INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID);
			
			this.headerBackgroundSkinTexture = this.atlas.getTexture("header-background-skin");
			
			this.calloutTopArrowSkinTexture = this.atlas.getTexture("callout-arrow-top-skin");
			this.calloutRightArrowSkinTexture = this.atlas.getTexture("callout-arrow-right-skin");
			this.calloutBottomArrowSkinTexture = this.atlas.getTexture("callout-arrow-bottom-skin");
			this.calloutLeftArrowSkinTexture = this.atlas.getTexture("callout-arrow-left-skin");
			
			this.horizontalScrollBarThumbSkinTextures = new Scale3Textures(this.atlas.getTexture("horizontal-scroll-bar-thumb-skin"), SCROLL_BAR_THUMB_REGION1, SCROLL_BAR_THUMB_REGION2, Scale3Textures.DIRECTION_HORIZONTAL);
			this.verticalScrollBarThumbSkinTextures = new Scale3Textures(this.atlas.getTexture("vertical-scroll-bar-thumb-skin"), SCROLL_BAR_THUMB_REGION1, SCROLL_BAR_THUMB_REGION2, Scale3Textures.DIRECTION_VERTICAL);
			
			StandardIcons.listDrillDownAccessoryTexture = this.atlas.getTexture("list-accessory-drill-down-icon");
			
			this.spinnerListSelectionOverlaySkinTextures = new Scale9Textures(this.atlas.getTexture("textinput-focus"), SPINNER_LIST_SELECTION_OVERLAY_SCALE9_GRID);
			
		}
		
		/**
		 * Sets global style providers for all components.
		 */
		protected function initializeStyleProviders():void
		{
			//alert
			this.getStyleProviderForClass(Alert).defaultStyleFunction = this.setAlertStyles;
			this.getStyleProviderForClass(ButtonGroup).setFunctionForStyleName(Alert.DEFAULT_CHILD_NAME_BUTTON_GROUP, this.setAlertButtonGroupStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_NAME_ALERT_BUTTON_GROUP_BUTTON, this.setAlertButtonGroupButtonStyles);
			this.getStyleProviderForClass(Header).setFunctionForStyleName(Alert.DEFAULT_CHILD_NAME_HEADER, this.setHeaderWithoutBackgroundStyles);
			this.getStyleProviderForClass(TextBlockTextRenderer).setFunctionForStyleName(Alert.DEFAULT_CHILD_NAME_MESSAGE, this.setAlertMessageTextRendererStyles);
			
			//button
			this.getStyleProviderForClass(Button).defaultStyleFunction = this.setButtonStyles;
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Button.ALTERNATE_NAME_CALL_TO_ACTION_BUTTON, this.setCallToActionButtonStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Button.ALTERNATE_NAME_QUIET_BUTTON, this.setQuietButtonStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Button.ALTERNATE_NAME_DANGER_BUTTON, this.setDangerButtonStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Button.ALTERNATE_NAME_BACK_BUTTON, this.setBackButtonStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Button.ALTERNATE_NAME_FORWARD_BUTTON, this.setForwardButtonStyles);
			
			//button group
			this.getStyleProviderForClass(ButtonGroup).defaultStyleFunction = this.setButtonGroupStyles;
			this.getStyleProviderForClass(Button).setFunctionForStyleName(ButtonGroup.DEFAULT_CHILD_NAME_BUTTON, this.setButtonGroupButtonStyles);
			this.getStyleProviderForClass(ToggleButton).setFunctionForStyleName(ButtonGroup.DEFAULT_CHILD_NAME_BUTTON, this.setButtonGroupButtonStyles);
			
			//callout
			this.getStyleProviderForClass(Callout).defaultStyleFunction = this.setCalloutStyles;
			
			//check
			this.getStyleProviderForClass(Check).defaultStyleFunction = this.setCheckStyles;
			
			//drawers
			this.getStyleProviderForClass(Drawers).defaultStyleFunction = this.setDrawersStyles;
			
			//grouped list (see also: item renderers)
			this.getStyleProviderForClass(GroupedList).defaultStyleFunction = this.setGroupedListStyles;
			this.getStyleProviderForClass(GroupedList).setFunctionForStyleName(GroupedList.ALTERNATE_NAME_INSET_GROUPED_LIST, this.setInsetGroupedListStyles);
			
			//header
			this.getStyleProviderForClass(Header).defaultStyleFunction = this.setHeaderStyles;
			
			//header and footer renderers for grouped list
			this.getStyleProviderForClass(DefaultGroupedListHeaderOrFooterRenderer).defaultStyleFunction = this.setGroupedListHeaderRendererStyles;
			this.getStyleProviderForClass(DefaultGroupedListHeaderOrFooterRenderer).setFunctionForStyleName(GroupedList.DEFAULT_CHILD_NAME_FOOTER_RENDERER, this.setGroupedListFooterRendererStyles);
			this.getStyleProviderForClass(DefaultGroupedListHeaderOrFooterRenderer).setFunctionForStyleName(GroupedList.ALTERNATE_CHILD_NAME_INSET_HEADER_RENDERER, this.setInsetGroupedListHeaderRendererStyles);
			this.getStyleProviderForClass(DefaultGroupedListHeaderOrFooterRenderer).setFunctionForStyleName(GroupedList.ALTERNATE_CHILD_NAME_INSET_FOOTER_RENDERER, this.setInsetGroupedListFooterRendererStyles);
			
			//item renderers for lists
			this.getStyleProviderForClass(DefaultGroupedListItemRenderer).defaultStyleFunction = this.setItemRendererStyles;
			this.getStyleProviderForClass(DefaultListItemRenderer).defaultStyleFunction = this.setItemRendererStyles;
			//the picker list has a custom item renderer name defined by the theme
			this.getStyleProviderForClass(DefaultListItemRenderer).setFunctionForStyleName(THEME_NAME_PICKER_LIST_ITEM_RENDERER, this.setPickerListItemRendererStyles);
			this.getStyleProviderForClass(TextBlockTextRenderer).setFunctionForStyleName(BaseDefaultItemRenderer.DEFAULT_CHILD_NAME_ACCESSORY_LABEL, this.setItemRendererAccessoryLabelRendererStyles);
			this.getStyleProviderForClass(TextBlockTextRenderer).setFunctionForStyleName(BaseDefaultItemRenderer.DEFAULT_CHILD_NAME_ICON_LABEL, this.setItemRendererIconLabelStyles);
			
			//the spinner list has a custom item renderer name defined by the theme
			this.getStyleProviderForClass(DefaultListItemRenderer).setFunctionForStyleName(THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER, this.setSpinnerListItemRendererStyles);
			
			this.getStyleProviderForClass(DefaultGroupedListItemRenderer).setFunctionForStyleName(GroupedList.ALTERNATE_CHILD_NAME_INSET_ITEM_RENDERER, this.setInsetGroupedListMiddleItemRendererStyles);
			this.getStyleProviderForClass(DefaultGroupedListItemRenderer).setFunctionForStyleName(GroupedList.ALTERNATE_CHILD_NAME_INSET_FIRST_ITEM_RENDERER, this.setInsetGroupedListFirstItemRendererStyles);
			this.getStyleProviderForClass(DefaultGroupedListItemRenderer).setFunctionForStyleName(GroupedList.ALTERNATE_CHILD_NAME_INSET_LAST_ITEM_RENDERER, this.setInsetGroupedListLastItemRendererStyles);
			this.getStyleProviderForClass(DefaultGroupedListItemRenderer).setFunctionForStyleName(GroupedList.ALTERNATE_CHILD_NAME_INSET_SINGLE_ITEM_RENDERER, this.setInsetGroupedListSingleItemRendererStyles);
			
			//labels
			this.getStyleProviderForClass(Label).defaultStyleFunction = this.setLabelStyles;
			this.getStyleProviderForClass(Label).setFunctionForStyleName(Label.ALTERNATE_NAME_HEADING, this.setHeadingLabelStyles);
			this.getStyleProviderForClass(Label).setFunctionForStyleName(Label.ALTERNATE_NAME_DETAIL, this.setDetailLabelStyles);
			
			//list (see also: item renderers)
			this.getStyleProviderForClass(List).defaultStyleFunction = this.setListStyles;
			
			//numeric stepper
			this.getStyleProviderForClass(NumericStepper).defaultStyleFunction = this.setNumericStepperStyles;
			this.getStyleProviderForClass(TextInput).setFunctionForStyleName(NumericStepper.DEFAULT_CHILD_NAME_TEXT_INPUT, this.setNumericStepperTextInputStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(NumericStepper.DEFAULT_CHILD_NAME_DECREMENT_BUTTON, this.setNumericStepperButtonStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(NumericStepper.DEFAULT_CHILD_NAME_INCREMENT_BUTTON, this.setNumericStepperButtonStyles);
			
			//page indicator
			this.getStyleProviderForClass(PageIndicator).defaultStyleFunction = this.setPageIndicatorStyles;
			
			//panel
			this.getStyleProviderForClass(Panel).defaultStyleFunction = this.setPanelStyles;
			this.getStyleProviderForClass(Header).setFunctionForStyleName(Panel.DEFAULT_CHILD_NAME_HEADER, this.setHeaderWithoutBackgroundStyles);
			
			//panel screen
			this.getStyleProviderForClass(Header).setFunctionForStyleName(PanelScreen.DEFAULT_CHILD_NAME_HEADER, this.setPanelScreenHeaderStyles);
			
			//picker list (see also: list and item renderers)
			this.getStyleProviderForClass(PickerList).defaultStyleFunction = this.setPickerListStyles;
			this.getStyleProviderForClass(Button).setFunctionForStyleName(PickerList.DEFAULT_CHILD_NAME_BUTTON, this.setPickerListButtonStyles);
			this.getStyleProviderForClass(ToggleButton).setFunctionForStyleName(PickerList.DEFAULT_CHILD_NAME_BUTTON, this.setPickerListButtonStyles);
			
			//progress bar
			this.getStyleProviderForClass(ProgressBar).defaultStyleFunction = this.setProgressBarStyles;
			
			//radio
			this.getStyleProviderForClass(Radio).defaultStyleFunction = this.setRadioStyles;
			
			//scroll container
			this.getStyleProviderForClass(ScrollContainer).defaultStyleFunction = this.setScrollContainerStyles;
			this.getStyleProviderForClass(ScrollContainer).setFunctionForStyleName(ScrollContainer.ALTERNATE_NAME_TOOLBAR, this.setToolbarScrollContainerStyles);
			
			//scroll text
			this.getStyleProviderForClass(ScrollText).defaultStyleFunction = this.setScrollTextStyles;
			
			//simple scroll bar
			this.getStyleProviderForClass(SimpleScrollBar).defaultStyleFunction = this.setSimpleScrollBarStyles;
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB, this.setHorizontalSimpleScrollBarThumbStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB, this.setVerticalSimpleScrollBarThumbStyles);
			
			//slider
			this.getStyleProviderForClass(Slider).defaultStyleFunction = this.setSliderStyles;
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Slider.DEFAULT_CHILD_NAME_THUMB, this.setSimpleButtonStylesRed);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK, this.setHorizontalSliderMinimumTrackStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK, this.setHorizontalSliderMaximumTrackStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_NAME_VERTICAL_SLIDER_MINIMUM_TRACK, this.setVerticalSliderMinimumTrackStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_NAME_VERTICAL_SLIDER_MAXIMUM_TRACK, this.setVerticalSliderMaximumTrackStyles);
			
			//spinner list
			this.getStyleProviderForClass(SpinnerList).defaultStyleFunction = this.setSpinnerListStyles;
			
			//tab bar
			this.getStyleProviderForClass(TabBar).defaultStyleFunction = this.setTabBarStyles;
			this.getStyleProviderForClass(ToggleButton).setFunctionForStyleName(TabBar.DEFAULT_CHILD_NAME_TAB, this.setTabStyles);
			
			//text input
			this.getStyleProviderForClass(TextInput).defaultStyleFunction = this.setTextInputStyles;
			this.getStyleProviderForClass(TextInput).setFunctionForStyleName(TextInput.ALTERNATE_NAME_SEARCH_TEXT_INPUT, this.setSearchTextInputStyles);
			
			//text area
			this.getStyleProviderForClass(TextArea).defaultStyleFunction = this.setTextAreaStyles;
			
			//toggle button
			this.getStyleProviderForClass(ToggleButton).defaultStyleFunction = this.setButtonStyles;
			this.getStyleProviderForClass(ToggleButton).setFunctionForStyleName(Button.ALTERNATE_NAME_QUIET_BUTTON, this.setQuietButtonStyles);
			
			//toggle switch
			this.getStyleProviderForClass(ToggleSwitch).defaultStyleFunction = this.setToggleSwitchStyles;
			this.getStyleProviderForClass(Button).setFunctionForStyleName(ToggleSwitch.DEFAULT_CHILD_NAME_THUMB, this.setSimpleButtonStylesSmall);
			this.getStyleProviderForClass(ToggleButton).setFunctionForStyleName(ToggleSwitch.DEFAULT_CHILD_NAME_THUMB, this.setSimpleButtonStylesSmall);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(ToggleSwitch.DEFAULT_CHILD_NAME_ON_TRACK, this.setToggleSwitchTrackStyles);
			//we don't need a style function for the off track in this theme
			//the toggle switch layout uses a single track
		}
		
		protected function pageIndicatorNormalSymbolFactory():DisplayObject
		{
			const symbol:ImageLoader = new ImageLoader();
			symbol.source = this.pageIndicatorNormalSkinTexture;
			symbol.textureScale = this.scale*0.7;
			return symbol;
		}
		
		protected function pageIndicatorSelectedSymbolFactory():DisplayObject
		{
			const symbol:ImageLoader = new ImageLoader();
			symbol.source = this.pageIndicatorSelectedSkinTexture;
			symbol.textureScale = this.scale*0.7;
			return symbol;
		}
		
		protected function imageLoaderFactory():ImageLoader
		{
			const image:ImageLoader = new ImageLoader();
			image.textureScale = this.scale;//*0.7;
			return image;
		}
		
		protected function imageLoaderFactory_noSmoothing():ImageLoader
		{
			const image:ImageLoader = new ImageLoader();
			image.textureScale = this.scale;//*0.7;
			image.smoothing = TextureSmoothing.NONE;
			return image;
		}
		
		
		protected function imageLoaderFactory2():ImageLoader
		{
			const image:ImageLoader = new ImageLoader();
			image.textureScale = this.scale;
			return image;
		}		
		
		//-------------------------
		// Shared
		//-------------------------
		
		protected function setScrollerStyles(scroller:Scroller):void
		{
			scroller.horizontalScrollBarFactory = scrollBarFactory;
			scroller.verticalScrollBarFactory = scrollBarFactory;
		}
		
		protected function setSimpleButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonUpSkinTextures;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
				{
					width: this.controlSize,
						height: this.controlSize,
						textureScale: this.scale
				};
			button.stateToSkinFunction = skinSelector.updateValue;
			button.hasLabelTextRenderer = false;
			
			button.minWidth = button.minHeight = this.controlSize;
			button.minTouchWidth = button.minTouchHeight = this.gridSize;
		}
		
		protected function setSimpleButtonStylesSmall(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = btn_blue_second;
			skinSelector.setValueForState(btn_blue_second, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
				{
					width: 42,
						height: 42,
						textureScale: this.scale
				};
			button.stateToSkinFunction = skinSelector.updateValue;
			button.hasLabelTextRenderer = false;
			
			button.minWidth = button.minHeight = 42;
			button.minTouchWidth = button.minTouchHeight = 42;			
			
			//button.minWidth = button.minHeight = this.controlSize;
			//button.minTouchWidth = button.minTouchHeight = this.gridSize;
		}
		
		
		protected function setSimpleButtonStylesRed(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonRedLightUpSkinTextures;
			skinSelector.setValueForState(this.buttonRedLightDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
				{
					width: this.controlSize,
						height: this.controlSize,
						textureScale: this.scale
				};
			button.stateToSkinFunction = skinSelector.updateValue;
			button.hasLabelTextRenderer = false;
			
			button.minWidth = button.minHeight = this.controlSize;
			button.minTouchWidth = button.minTouchHeight = this.gridSize;
		}		
		
		//-------------------------
		// Alert
		//-------------------------
		
		protected function setAlertStyles(alert:Alert):void
		{
			this.setScrollerStyles(alert);
			
			const backgroundSkin:Scale9Image = new Scale9Image(bg_popup, this.scale);
			alert.backgroundSkin = backgroundSkin;
			
			alert.paddingTop = 7;
			alert.paddingRight = 35 * this.scale;
			alert.paddingLeft = 35 * this.scale;
			alert.paddingBottom = 0 * this.scale;
			
			alert.buttonGroupProperties.padding = 18;
			
			alert.maxWidth = this.popUpFillSize;
			alert.maxHeight = this.popUpFillSize;		
			
			alert.width = this.popUpFillSize;
			alert.height = 378 * this.scale;
		}
		
		//see Panel section for Header styles
		
		protected function setAlertButtonGroupStyles(group:ButtonGroup):void
		{
			group.direction = ButtonGroup.DIRECTION_HORIZONTAL;
			group.horizontalAlign = ButtonGroup.HORIZONTAL_ALIGN_CENTER;
			group.verticalAlign = ButtonGroup.VERTICAL_ALIGN_JUSTIFY;
			group.distributeButtonSizes = false;
			group.gap = this.smallGutterSize;
			group.padding = this.smallGutterSize;
			group.customButtonName = THEME_NAME_ALERT_BUTTON_GROUP_BUTTON;
		}
		
		protected function setAlertButtonGroupButtonStyles(button:Button):void
		{
			this.setButtonStyles(button);
			button.minWidth = 2 * this.controlSize;
		}
		
		protected function setAlertMessageTextRendererStyles(renderer:TextBlockTextRenderer):void
		{
			renderer.wordWrap = true;
			renderer.elementFormat = this.darkElementFormat;
		}
		
		//-------------------------
		// Button
		//-------------------------
		
		protected function setBaseButtonStyles(button:Button):void
		{
			button.defaultLabelProperties.elementFormat = this.lightUIElementFormat;
			button.disabledLabelProperties.elementFormat = this.lightUIDisabledElementFormat;
			if(button is ToggleButton)
			{
				//for convenience, this function can style both a regular button
				//and a toggle button
				ToggleButton(button).selectedDisabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;
			}
			
			button.paddingTop = this.smallGutterSize;
			button.paddingBottom = this.smallGutterSize;
			button.paddingLeft = this.gutterSize;
			button.paddingRight = this.gutterSize;
			button.gap = this.smallGutterSize;
			button.minGap = this.smallGutterSize;
			button.minWidth = button.minHeight = this.controlSize;
			button.minTouchWidth = this.gridSize;
			button.minTouchHeight = this.gridSize;
		}
		
		protected function setButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonUpSkinTextures;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
			if(button is ToggleButton)
			{
				//for convenience, this function can style both a regular button
				//and a toggle button
				skinSelector.defaultSelectedValue = this.buttonSelectedUpSkinTextures;
				skinSelector.setValueForState(this.buttonSelectedDisabledSkinTextures, Button.STATE_DISABLED, true);
			}
			skinSelector.displayObjectProperties =
				{
					width: this.controlSize,
						height: this.controlSize,
						textureScale: this.scale
				};
			button.stateToSkinFunction = skinSelector.updateValue;
			this.setBaseButtonStyles(button);
		}
		
		protected function setCallToActionButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonCallToActionUpSkinTextures;
			skinSelector.setValueForState(this.buttonCallToActionDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
				{
					width: this.controlSize,
						height: this.controlSize,
						textureScale: this.scale
				};
			button.stateToSkinFunction = skinSelector.updateValue;
			this.setBaseButtonStyles(button);
		}
		
		protected function setQuietButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = null;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			if(button is ToggleButton)
			{
				//for convenience, this function can style both a regular button
				//and a toggle button
				skinSelector.defaultSelectedValue = this.buttonSelectedUpSkinTextures;
			}
			skinSelector.displayObjectProperties =
				{
					width: this.controlSize,
						height: this.controlSize,
						textureScale: this.scale
				};
			button.stateToSkinFunction = skinSelector.updateValue;
			
			button.defaultLabelProperties.elementFormat = this.lightUIElementFormat;
			button.downLabelProperties.elementFormat = this.lightUIElementFormat;
			button.disabledLabelProperties.elementFormat = this.lightUIDisabledElementFormat;
			if(button is ToggleButton)
			{
				var toggleButton:ToggleButton = ToggleButton(button);
				toggleButton.defaultSelectedLabelProperties.elementFormat = this.darkUIElementFormat;
				toggleButton.selectedDisabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;
			}
			
			button.paddingTop = button.paddingBottom = this.smallGutterSize;
			button.paddingLeft = button.paddingRight = this.gutterSize;
			button.gap = this.smallGutterSize;
			button.minGap = this.smallGutterSize;
			button.minWidth = button.minHeight = this.controlSize;
			button.minTouchWidth = button.minTouchHeight = this.gridSize;
		}
		
		protected function setDangerButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonDangerUpSkinTextures;
			skinSelector.setValueForState(this.buttonDangerDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
				{
					width: this.controlSize,
						height: this.controlSize,
						textureScale: this.scale
				};
			button.stateToSkinFunction = skinSelector.updateValue;
			this.setBaseButtonStyles(button);
		}
		
		protected function setBackButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonBackUpSkinTextures;
			skinSelector.setValueForState(this.buttonBackDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonBackDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
				{
					width: this.controlSize,
						height: this.controlSize,
						textureScale: this.scale
				};
			button.stateToSkinFunction = skinSelector.updateValue;
			this.setBaseButtonStyles(button);
			button.paddingLeft = 10 + this.gutterSize + this.smallGutterSize;
		}
		
		protected function setForwardButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonForwardUpSkinTextures;
			skinSelector.setValueForState(this.buttonForwardDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonForwardDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
				{
					width: this.controlSize,
						height: this.controlSize,
						textureScale: this.scale
				};
			button.stateToSkinFunction = skinSelector.updateValue;
			this.setBaseButtonStyles(button);
			button.paddingRight = 10 + this.gutterSize + this.smallGutterSize;
		}
		
		//-------------------------
		// ButtonGroup
		//-------------------------
		
		protected function setButtonGroupStyles(group:ButtonGroup):void
		{
			group.minWidth = this.popUpFillSize;
			group.gap = this.smallGutterSize;
		}
		
		protected function setButtonGroupButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonUpSkinTextures;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
			if(button is ToggleButton)
			{
				//for convenience, this function can style both a regular button
				//and a toggle button
				skinSelector.defaultSelectedValue = this.buttonSelectedUpSkinTextures;
				skinSelector.setValueForState(this.buttonSelectedDisabledSkinTextures, Button.STATE_DISABLED, true);
			}
			skinSelector.displayObjectProperties =
				{
					width: 60,
					height: 60,
					textureScale: this.scale
				};
			button.stateToSkinFunction = skinSelector.updateValue;
			
			button.defaultLabelProperties.elementFormat = this.lightUIElementFormat;
			button.disabledLabelProperties.elementFormat = this.lightUIDisabledElementFormat;
			if(button is ToggleButton)
			{
				ToggleButton(button).selectedDisabledLabelProperties.elementFormat = this.lightUIDisabledElementFormat;
			}
			
		}
		
		//-------------------------
		// Callout
		//-------------------------
		
		protected function setCalloutStyles(callout:Callout):void
		{
			var backgroundSkin:Scale9Image = new Scale9Image(bg_popup, this.scale);
			backgroundSkin.width = this.calloutBackgroundMinSize;
			backgroundSkin.height = this.calloutBackgroundMinSize;
			callout.backgroundSkin = backgroundSkin;
			
			var topArrowSkin:Image = new Image(this.calloutTopArrowSkinTexture);
			topArrowSkin.scaleX = topArrowSkin.scaleY = this.scale;
			callout.topArrowSkin = topArrowSkin;
			
			var rightArrowSkin:Image = new Image(this.calloutRightArrowSkinTexture);
			rightArrowSkin.scaleX = rightArrowSkin.scaleY = this.scale;
			callout.rightArrowSkin = rightArrowSkin;
			
			var bottomArrowSkin:Image = new Image(this.calloutBottomArrowSkinTexture);
			bottomArrowSkin.scaleX = bottomArrowSkin.scaleY = this.scale;
			callout.bottomArrowSkin = bottomArrowSkin;
			
			var leftArrowSkin:Image = new Image(this.calloutLeftArrowSkinTexture);
			leftArrowSkin.scaleX = leftArrowSkin.scaleY = this.scale;
			callout.leftArrowSkin = leftArrowSkin;
			
			callout.paddingTop = callout.paddingBottom = 22 * this.scale;
			callout.paddingLeft = callout.paddingRight = 22 * this.scale;
			
		}
		
		//-------------------------
		// Check
		//-------------------------
		
		protected function setCheckStyles(check:Check):void
		{
			
			var iconSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			
			var btn_check_off:Scale9Textures = new Scale9Textures(this.atlas.getTexture("check-bg-off"), new Rectangle(6, 6, 24, 23)); 
			var btn_check_on:Scale9Textures = new Scale9Textures(this.atlas.getTexture("check-bg-on"), new Rectangle(6, 6, 24, 23)); 
			var btn_check_dis_on:Scale9Textures = new Scale9Textures(this.atlas.getTexture("check-bg-dis"), new Rectangle(6, 6, 24, 23)); 
			var btn_check_dis_off:Scale9Textures = new Scale9Textures(this.atlas.getTexture("check-bg-off-dis"), new Rectangle(6, 6, 24, 23)); 
			
			iconSelector.defaultValue = btn_check_off;
			iconSelector.defaultSelectedValue = btn_check_on;			
			
			iconSelector.setValueForState(btn_check_off, Button.STATE_DOWN, false);
			iconSelector.setValueForState(btn_check_dis_off, Button.STATE_DISABLED, false);
			iconSelector.setValueForState(btn_check_on, Button.STATE_DOWN, true);
			iconSelector.setValueForState(btn_check_dis_on, Button.STATE_DISABLED, true);
			iconSelector.displayObjectProperties =
				{
					scaleX: this.scale,
						scaleY: this.scale
				};
			check.stateToIconFunction = iconSelector.updateValue;
			
			check.defaultLabelProperties.elementFormat = this.darkUIElementFormat;
			check.disabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;
			check.selectedDisabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;
			
			check.gap = this.smallGutterSize;
			check.minWidth = this.controlSize;
			check.minHeight = this.controlSize;
			check.minTouchWidth = this.gridSize;
			check.minTouchHeight = this.gridSize;
		}
		
		//-------------------------
		// Drawers
		//-------------------------
		
		protected function setDrawersStyles(drawers:Drawers):void
		{
			var overlaySkin:Quad = new Quad(10, 10, DRAWER_OVERLAY_COLOR);
			overlaySkin.alpha = DRAWER_OVERLAY_ALPHA;
			drawers.overlaySkin = overlaySkin;
		}
		
		//-------------------------
		// GroupedList
		//-------------------------
		
		protected function setGroupedListStyles(list:GroupedList):void
		{
			this.setScrollerStyles(list);
			var backgroundSkin:Quad = new Quad(this.gridSize, this.gridSize, LIST_BACKGROUND_COLOR);
			list.backgroundSkin = backgroundSkin;
		}
		
		//see List section for item renderer styles
		
		protected function setGroupedListHeaderRendererStyles(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
		{
			renderer.backgroundSkin = new Quad(1, 1, GROUPED_LIST_HEADER_BACKGROUND_COLOR);
			
			renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_LEFT;
			renderer.contentLabelProperties.elementFormat = this.lightUIElementFormat;
			renderer.contentLabelProperties.disabledElementFormat = this.lightUIDisabledElementFormat;
			renderer.paddingTop = this.smallGutterSize;
			renderer.paddingBottom = this.smallGutterSize;
			renderer.paddingLeft = this.smallGutterSize + this.gutterSize;
			renderer.paddingRight = this.gutterSize;
			
			renderer.contentLoaderFactory = this.imageLoaderFactory;
		}
		
		protected function setGroupedListFooterRendererStyles(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
		{
			renderer.backgroundSkin = new Quad(1, 1, GROUPED_LIST_FOOTER_BACKGROUND_COLOR);
			
			renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_CENTER;
			renderer.contentLabelProperties.elementFormat = this.lightElementFormat;
			renderer.contentLabelProperties.disabledElementFormat = this.disabledElementFormat;
			renderer.paddingTop = renderer.paddingBottom = this.smallGutterSize;
			renderer.paddingLeft = this.smallGutterSize + this.gutterSize;
			renderer.paddingRight = this.gutterSize;
			
			renderer.contentLoaderFactory = this.imageLoaderFactory;
		}
		
		protected function setInsetGroupedListStyles(list:GroupedList):void
		{
			list.itemRendererName = GroupedList.ALTERNATE_CHILD_NAME_INSET_ITEM_RENDERER;
			list.firstItemRendererName = GroupedList.ALTERNATE_CHILD_NAME_INSET_FIRST_ITEM_RENDERER;
			list.lastItemRendererName = GroupedList.ALTERNATE_CHILD_NAME_INSET_LAST_ITEM_RENDERER;
			list.singleItemRendererName = GroupedList.ALTERNATE_CHILD_NAME_INSET_SINGLE_ITEM_RENDERER;
			list.headerRendererName = GroupedList.ALTERNATE_CHILD_NAME_INSET_HEADER_RENDERER;
			list.footerRendererName = GroupedList.ALTERNATE_CHILD_NAME_INSET_FOOTER_RENDERER;
			
			var layout:VerticalLayout = new VerticalLayout();
			layout.useVirtualLayout = true;
			layout.padding = this.smallGutterSize;
			layout.gap = 0;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_TOP;
			list.layout = layout;
		}
		
		protected function setInsetGroupedListItemRendererStyles(renderer:DefaultGroupedListItemRenderer, defaultSkinTextures:Scale9Textures, selectedAndDownSkinTextures:Scale9Textures):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = defaultSkinTextures;
			skinSelector.defaultSelectedValue = selectedAndDownSkinTextures;
			skinSelector.setValueForState(selectedAndDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.displayObjectProperties =
				{
					width: this.gridSize,
						height: this.gridSize,
						textureScale: this.scale
				};
			renderer.stateToSkinFunction = skinSelector.updateValue;
			
			renderer.defaultLabelProperties.elementFormat = this.largeDarkElementFormat;
			renderer.downLabelProperties.elementFormat = this.largeLightElementFormat;
			renderer.defaultSelectedLabelProperties.elementFormat = this.largeLightElementFormat;
			renderer.disabledLabelProperties.elementFormat = this.largeDisabledElementFormat;
			
			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingTop = this.smallGutterSize;
			renderer.paddingBottom = this.smallGutterSize;
			renderer.paddingLeft = this.gutterSize + this.smallGutterSize;
			renderer.paddingRight = this.gutterSize;
			renderer.gap = this.gutterSize;
			renderer.minGap = this.gutterSize;
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.minAccessoryGap = this.gutterSize;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.minWidth = renderer.minHeight = this.gridSize;
			renderer.minTouchWidth = renderer.minTouchHeight = this.gridSize;
			
			renderer.accessoryLoaderFactory = this.imageLoaderFactory;
			renderer.iconLoaderFactory = this.imageLoaderFactory;
		}
		
		protected function setInsetGroupedListMiddleItemRendererStyles(renderer:DefaultGroupedListItemRenderer):void
		{
			this.setInsetGroupedListItemRendererStyles(renderer, this.itemRendererUpSkinTextures, this.itemRendererSelectedSkinTextures);
		}
		
		protected function setInsetGroupedListFirstItemRendererStyles(renderer:DefaultGroupedListItemRenderer):void
		{
			this.setInsetGroupedListItemRendererStyles(renderer, this.insetItemRendererFirstUpSkinTextures, this.insetItemRendererFirstSelectedSkinTextures);
		}
		
		protected function setInsetGroupedListLastItemRendererStyles(renderer:DefaultGroupedListItemRenderer):void
		{
			this.setInsetGroupedListItemRendererStyles(renderer, this.insetItemRendererLastUpSkinTextures, this.insetItemRendererLastSelectedSkinTextures);
		}
		
		protected function setInsetGroupedListSingleItemRendererStyles(renderer:DefaultGroupedListItemRenderer):void
		{
			this.setInsetGroupedListItemRendererStyles(renderer, this.insetItemRendererSingleUpSkinTextures, this.insetItemRendererSingleSelectedSkinTextures);
		}
		
		protected function setInsetGroupedListHeaderRendererStyles(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
		{
			var defaultSkin:Quad = new Quad(1, 1, 0xff00ff);
			defaultSkin.alpha = 0;
			renderer.backgroundSkin = defaultSkin;
			
			renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_LEFT;
			renderer.contentLabelProperties.elementFormat = this.lightUIElementFormat;
			renderer.contentLabelProperties.disabledElementFormat = this.lightUIDisabledElementFormat;
			renderer.paddingTop = this.smallGutterSize;
			renderer.paddingBottom = this.smallGutterSize;
			renderer.paddingLeft = this.gutterSize + this.smallGutterSize;
			renderer.paddingRight = this.gutterSize;
			renderer.minWidth = this.controlSize;
			renderer.minHeight = this.controlSize;
			
			renderer.contentLoaderFactory = this.imageLoaderFactory;
		}
		
		protected function setInsetGroupedListFooterRendererStyles(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
		{
			var defaultSkin:Quad = new Quad(1, 1, 0xff00ff);
			defaultSkin.alpha = 0;
			renderer.backgroundSkin = defaultSkin;
			
			renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_CENTER;
			renderer.contentLabelProperties.elementFormat = this.lightElementFormat;
			renderer.contentLabelProperties.disabledElementFormat = this.disabledElementFormat;
			renderer.paddingTop = this.smallGutterSize;
			renderer.paddingBottom = this.smallGutterSize;
			renderer.paddingLeft = this.gutterSize + this.smallGutterSize;
			renderer.paddingRight = this.gutterSize;
			renderer.minWidth = this.controlSize;
			renderer.minHeight = this.controlSize;
			
			renderer.contentLoaderFactory = this.imageLoaderFactory;
		}
		
		//-------------------------
		// Header
		//-------------------------
		
		protected function setHeaderStyles(header:Header):void
		{
			header.minWidth = this.gridSize;
			header.minHeight = this.gridSize;
			header.padding = this.smallGutterSize;
			header.gap = this.smallGutterSize;
			header.titleGap = this.smallGutterSize;
			
			var backgroundSkin:TiledImage = new TiledImage(this.headerBackgroundSkinTexture, this.scale);
			backgroundSkin.smoothing = TextureSmoothing.NONE;
			backgroundSkin.width = this.gridSize;
			backgroundSkin.height = this.gridSize;
			header.backgroundSkin = new Quad( 10, 10, 0x2c3e50 ); 
			header.titleProperties.elementFormat = this.headerElementFormat;
		}
		
		//-------------------------
		// Label
		//-------------------------
		
		protected function setLabelStyles(label:Label):void
		{
			label.textRendererProperties.elementFormat = this.darkElementFormat;
			label.textRendererProperties.disabledElementFormat = this.disabledElementFormat;
		}
		
		protected function setHeadingLabelStyles(label:Label):void
		{
			label.textRendererProperties.elementFormat = this.largeDarkElementFormat;
			label.textRendererProperties.disabledElementFormat = this.largeDisabledElementFormat;
		}
		
		protected function setDetailLabelStyles(label:Label):void
		{
			label.textRendererProperties.elementFormat = this.smallDarkElementFormat;
			label.textRendererProperties.disabledElementFormat = this.smallDisabledElementFormat;
		}
		
		//-------------------------
		// List
		//-------------------------
		
		protected function setListStyles(list:List):void
		{
			this.setScrollerStyles(list);
			var backgroundSkin:Quad = new Quad(this.gridSize, this.gridSize, LIST_BACKGROUND_COLOR);
			list.backgroundSkin = backgroundSkin;
		}
		
		protected function setItemRendererStyles(renderer:BaseDefaultItemRenderer):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.itemRendererUpSkinTextures;
			skinSelector.defaultSelectedValue = this.itemRendererSelectedSkinTextures;
			skinSelector.setValueForState(this.itemRendererSelectedSkinTextures, Button.STATE_DOWN, false);
			skinSelector.displayObjectProperties =
				{
					width: this.gridSize,
						height: this.gridSize,
						textureScale: this.scale
				};
			renderer.stateToSkinFunction = skinSelector.updateValue;
			
			renderer.defaultLabelProperties.elementFormat = this.largeDarkElementFormat;
			renderer.downLabelProperties.elementFormat = this.largeLightElementFormat;
			renderer.defaultSelectedLabelProperties.elementFormat = this.largeLightElementFormat;
			renderer.disabledLabelProperties.elementFormat = this.largeDisabledElementFormat;
			
			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingTop = this.smallGutterSize;
			renderer.paddingBottom = this.smallGutterSize;
			renderer.paddingLeft = this.gutterSize + this.smallGutterSize;
			renderer.paddingRight = this.gutterSize;
			renderer.gap = this.gutterSize;
			renderer.minGap = this.gutterSize;
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.minAccessoryGap = this.gutterSize;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.minWidth = this.gridSize;
			renderer.minHeight = this.gridSize;
			renderer.minTouchWidth = this.gridSize;
			renderer.minTouchHeight = this.gridSize;
			
			renderer.accessoryLoaderFactory = this.imageLoaderFactory2;
			renderer.iconLoaderFactory = this.imageLoaderFactory;
		}
		
		protected function setItemRendererAccessoryLabelRendererStyles(renderer:TextBlockTextRenderer):void
		{
			renderer.elementFormat = this.lightElementFormat;
		}
		
		protected function setItemRendererIconLabelStyles(renderer:TextBlockTextRenderer):void
		{
			renderer.elementFormat = this.lightElementFormat;
		}
		
		//-------------------------
		// NumericStepper
		//-------------------------
		
		protected function setNumericStepperStyles(stepper:NumericStepper):void
		{
			stepper.buttonLayoutMode = NumericStepper.BUTTON_LAYOUT_MODE_SPLIT_HORIZONTAL;
			stepper.incrementButtonLabel = "+";
			stepper.decrementButtonLabel = "-";
		}
		
		protected function setNumericStepperTextInputStyles(input:TextInput):void
		{
			var backgroundSkin:Scale9Image = new Scale9Image(bg_null, this.scale);
			backgroundSkin.width = this.controlSize;
			backgroundSkin.height = this.controlSize;
			input.backgroundSkin = backgroundSkin;
			
			var backgroundDisabledSkin:Scale9Image = new Scale9Image(bg_null, this.scale);
			backgroundDisabledSkin.width = this.controlSize;
			backgroundDisabledSkin.height = this.controlSize;
			input.backgroundDisabledSkin = backgroundDisabledSkin;
			
			var backgroundFocusedSkin:Scale9Image = new Scale9Image(bg_null, this.scale);
			backgroundFocusedSkin.width = this.controlSize;
			backgroundFocusedSkin.height = this.controlSize;
			input.backgroundFocusedSkin = backgroundFocusedSkin;
			
			input.minWidth = input.minHeight = this.controlSize;
			input.minTouchWidth = input.minTouchHeight = this.gridSize;
			input.gap = this.smallGutterSize;
			input.padding = this.smallGutterSize;
			input.isEditable = false;
			input.textEditorFactory = stepperTextEditorFactory;
			input.textEditorProperties.elementFormat = this.darkUIElementFormat;
			input.textEditorProperties.disabledElementFormat = this.darkUIDisabledElementFormat;
			input.textEditorProperties.textAlign = TextBlockTextEditor.TEXT_ALIGN_CENTER;
		}
		
		protected function setNumericStepperButtonStyles(button:Button):void
		{
			this.setButtonStyles(button);
			button.keepDownStateOnRollOut = true;
		}
		
		//-------------------------
		// PageIndicator
		//-------------------------
		
		protected function setPageIndicatorStyles(pageIndicator:PageIndicator):void
		{
			pageIndicator.normalSymbolFactory = this.pageIndicatorNormalSymbolFactory;
			pageIndicator.selectedSymbolFactory = this.pageIndicatorSelectedSymbolFactory;
			pageIndicator.gap = this.smallGutterSize;
			pageIndicator.padding = this.smallGutterSize;
			pageIndicator.minTouchWidth = this.smallControlSize * 2
			pageIndicator.minTouchHeight = this.smallControlSize * 2;
		}
		
		//-------------------------
		// Panel
		//-------------------------
		
		protected function setPanelStyles(panel:Panel):void
		{
			this.setScrollerStyles(panel);
			
			panel.backgroundSkin = new Scale9Image(bg_popup, this.scale);
			
			panel.paddingTop = 0;
			panel.paddingRight = this.smallGutterSize;
			panel.paddingBottom = this.smallGutterSize;
			panel.paddingLeft = this.smallGutterSize;
		}
		
		protected function setHeaderWithoutBackgroundStyles(header:Header):void
		{
			header.minWidth = this.gridSize;
			header.minHeight = this.gridSize;
			header.padding = this.smallGutterSize;
			header.gap = this.smallGutterSize;
			header.titleGap = this.smallGutterSize;
			
			header.titleProperties.elementFormat = this.alertHeaderElementFormat;
		}
		
		//-------------------------
		// PanelScreen
		//-------------------------
		
		protected function setPanelScreenHeaderStyles(header:Header):void
		{
			this.setHeaderStyles(header);
			header.useExtraPaddingForOSStatusBar = true;
		}
		
		//-------------------------
		// PickerList
		//-------------------------
		
		protected function setPickerListStyles(list:PickerList):void
		{
			if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
			{
				list.popUpContentManager = new CalloutPopUpContentManager();
			}
			else
			{
				var centerStage:VerticalCenteredPopUpContentManager = new VerticalCenteredPopUpContentManager();
				centerStage.marginTop = centerStage.marginRight = centerStage.marginBottom =
					centerStage.marginLeft = this.gutterSize;
				list.popUpContentManager = centerStage;
			}
			
			var layout:VerticalLayout = new VerticalLayout();
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_BOTTOM;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
			layout.useVirtualLayout = true;
			layout.gap = 0;
			layout.padding = 0;
			list.listProperties.layout = layout;
			list.listProperties.verticalScrollPolicy = List.SCROLL_POLICY_ON;
			
			if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
			{
				list.listProperties.minWidth = this.popUpFillSize;
				list.listProperties.maxHeight = this.popUpFillSize;
			}
			else
			{
				var backgroundSkin:Scale9Image = new Scale9Image(bg_null, this.scale);
				backgroundSkin.width = this.gridSize;
				backgroundSkin.height = this.gridSize;
				list.listProperties.backgroundSkin = backgroundSkin;
				list.listProperties.padding = this.smallGutterSize;
			}
			
			list.listProperties.itemRendererName = THEME_NAME_PICKER_LIST_ITEM_RENDERER;
		}
		
		protected function setPickerListButtonStyles(button:Button):void
		{
			this.setButtonStyles(button);
			
			var iconSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			iconSelector.setValueTypeHandler(SubTexture, textureValueTypeHandler);
			iconSelector.defaultValue = this.pickerListButtonIconTexture;
			iconSelector.setValueForState(this.pickerListButtonIconDisabledTexture, Button.STATE_DISABLED, false);
			iconSelector.displayObjectProperties =
				{
					textureScale: this.scale,
						snapToPixels: true
				}
			button.stateToIconFunction = iconSelector.updateValue;
			
			button.gap = Number.POSITIVE_INFINITY;
			button.minGap = this.gutterSize;
			button.iconPosition = Button.ICON_POSITION_RIGHT;
		}
		
		protected function setPickerListItemRendererStyles(renderer:BaseDefaultItemRenderer):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.itemRendererUpSkinTextures;
			skinSelector.setValueForState(this.itemRendererSelectedSkinTextures, Button.STATE_DOWN, false);
			skinSelector.displayObjectProperties =
				{
					width: this.gridSize,
						height: this.gridSize,
						textureScale: this.scale
				};
			renderer.stateToSkinFunction = skinSelector.updateValue;
			
			var defaultSelectedIcon:Image = new Image(this.pickerListItemSelectedIconTexture);
			defaultSelectedIcon.scaleX = defaultSelectedIcon.scaleY = this.scale;
			renderer.defaultSelectedIcon = defaultSelectedIcon;
			
			var defaultIcon:Quad = new Quad(defaultSelectedIcon.width, defaultSelectedIcon.height, 0xff00ff);
			defaultIcon.alpha = 0;
			renderer.defaultIcon = defaultIcon;
			
			renderer.defaultLabelProperties.elementFormat = this.largeDarkElementFormat;
			renderer.downLabelProperties.elementFormat = this.largeLightElementFormat;
			renderer.disabledLabelProperties.elementFormat = this.largeDisabledElementFormat;
			
			renderer.itemHasIcon = false;
			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingTop = this.smallGutterSize;
			renderer.paddingBottom = this.smallGutterSize;
			renderer.paddingLeft = this.gutterSize + this.smallGutterSize;
			renderer.paddingRight = this.smallGutterSize;
			renderer.gap = Number.POSITIVE_INFINITY;
			renderer.minGap = this.gutterSize;
			renderer.iconPosition = Button.ICON_POSITION_RIGHT;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.minAccessoryGap = this.gutterSize;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.minWidth = this.gridSize;
			renderer.minHeight = this.gridSize;
			renderer.minTouchWidth = this.gridSize;
			renderer.minTouchHeight = this.gridSize;
		}
		
		//-------------------------
		// ProgressBar
		//-------------------------
		
		protected function setProgressBarStyles(progress:ProgressBar):void
		{
			var backgroundSkin:Scale3Image = new Scale3Image(new Scale3Textures(this.atlas.getTexture("preloader_bg"), 0,128), this.scale);
			
			if(progress.direction == ProgressBar.DIRECTION_VERTICAL)
			{
				backgroundSkin.width = this.smallControlSize;
				backgroundSkin.height = this.wideControlSize;
			}
			else
			{
				backgroundSkin.width = this.wideControlSize;
				backgroundSkin.height = this.smallControlSize;
			}
			progress.backgroundSkin = backgroundSkin;
			
			var backgroundDisabledSkin:Scale3Image = new Scale3Image(new Scale3Textures(this.atlas.getTexture("preloader_bg_dis"), 0,128), this.scale);
			
			if(progress.direction == ProgressBar.DIRECTION_VERTICAL)
			{
				backgroundDisabledSkin.width = this.smallControlSize;
				backgroundDisabledSkin.height = this.wideControlSize;
			}
			else
			{
				backgroundDisabledSkin.width = this.wideControlSize;
				backgroundDisabledSkin.height = this.smallControlSize;
			}
			progress.backgroundDisabledSkin = backgroundDisabledSkin;
			
			var fillSkin:Scale3Image = new Scale3Image(new Scale3Textures(this.atlas.getTexture("preloader_fill"), 0,128), this.scale);
			
			if(progress.direction == ProgressBar.DIRECTION_VERTICAL)
			{
				fillSkin.width = this.smallControlSize;
				fillSkin.height = this.smallControlSize;
			}
			else
			{
				fillSkin.width = this.smallControlSize;
				fillSkin.height = this.smallControlSize;
			}
			progress.fillSkin = fillSkin;
			
			var fillDisabledSkin:Scale3Image = new Scale3Image(new Scale3Textures(this.atlas.getTexture("preloader_fill_dis"), 0,128), this.scale);
			if(progress.direction == ProgressBar.DIRECTION_VERTICAL)
			{
				fillDisabledSkin.width = this.smallControlSize;
				fillDisabledSkin.height = this.smallControlSize;
			}
			else
			{
				fillDisabledSkin.width = this.smallControlSize;
				fillDisabledSkin.height = this.smallControlSize;
			}
			progress.fillDisabledSkin = fillDisabledSkin;
		}
		
		//-------------------------
		// Radio
		//-------------------------
		
		protected function setRadioStyles(radio:Radio):void
		{
			
			var btn_radio_off:Scale9Textures = new Scale9Textures(this.atlas.getTexture("radio-bg-off"), new Rectangle(6, 6, 24, 23)); 
			var btn_radio_on:Scale9Textures = new Scale9Textures(this.atlas.getTexture("radio-bg-on"), new Rectangle(6, 6, 24, 23)); 
			var btn_radio_dis:Scale9Textures = new Scale9Textures(this.atlas.getTexture("radio-bg-dis"), new Rectangle(6, 6, 24, 23)); 
			var btn_radio_off_dis:Scale9Textures = new Scale9Textures(this.atlas.getTexture("radio-bg-off-dis"), new Rectangle(6, 6, 24, 23)); 
			
			var iconSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			iconSelector.defaultValue = btn_radio_off;
			iconSelector.defaultSelectedValue = btn_radio_on;
			
			iconSelector.setValueForState(btn_radio_off, Button.STATE_DOWN, false);
			iconSelector.setValueForState(btn_radio_off_dis, Button.STATE_DISABLED, false);
			iconSelector.setValueForState(btn_radio_on, Button.STATE_DOWN, true);
			iconSelector.setValueForState(btn_radio_dis, Button.STATE_DISABLED, true);
			
			iconSelector.displayObjectProperties =
				{
					scaleX: this.scale,
						scaleY: this.scale
				};
			radio.stateToIconFunction = iconSelector.updateValue;
			
			radio.defaultLabelProperties.elementFormat = this.darkUIElementFormat;
			radio.disabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;
			radio.selectedDisabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;
			
			radio.gap = this.smallGutterSize;
			radio.minWidth = this.controlSize;
			radio.minHeight = this.controlSize;
			radio.minTouchWidth = this.gridSize;
			radio.minTouchHeight = this.gridSize;
		}
		
		//-------------------------
		// ScrollContainer
		//-------------------------
		
		protected function setScrollContainerStyles(container:ScrollContainer):void
		{
			this.setScrollerStyles(container);
		}
		
		protected function setToolbarScrollContainerStyles(container:ScrollContainer):void
		{
			this.setScrollerStyles(container);
			if(!container.layout)
			{
				var layout:HorizontalLayout = new HorizontalLayout();
				layout.padding = this.smallGutterSize;
				layout.gap = this.smallGutterSize;
				container.layout = layout;
			}
			container.minWidth = this.gridSize;
			container.minHeight = this.gridSize;
			
			var backgroundSkin:TiledImage = new TiledImage(this.headerBackgroundSkinTexture, this.scale);
			backgroundSkin.width = backgroundSkin.height = this.gridSize;
			container.backgroundSkin = backgroundSkin;
		}
		
		//-------------------------
		// ScrollText
		//-------------------------
		
		protected function setScrollTextStyles(text:ScrollText):void
		{
			this.setScrollerStyles(text);
			
			text.textFormat = this.scrollTextTextFormat;
			text.disabledTextFormat = this.scrollTextDisabledTextFormat;
			text.padding = this.gutterSize;
			text.paddingRight = this.gutterSize + this.smallGutterSize;
		}
		
		//-------------------------
		// SimpleScrollBar
		//-------------------------
		
		protected function setSimpleScrollBarStyles(scrollBar:SimpleScrollBar):void
		{
			if(scrollBar.direction == SimpleScrollBar.DIRECTION_HORIZONTAL)
			{
				scrollBar.paddingRight = this.scrollBarGutterSize;
				scrollBar.paddingBottom = this.scrollBarGutterSize;
				scrollBar.paddingLeft = this.scrollBarGutterSize;
				scrollBar.customThumbName = THEME_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB;
			}
			else
			{
				scrollBar.paddingTop = this.scrollBarGutterSize;
				scrollBar.paddingRight = this.scrollBarGutterSize;
				scrollBar.paddingBottom = this.scrollBarGutterSize;
				scrollBar.customThumbName = THEME_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB;
			}
		}
		
		protected function setHorizontalSimpleScrollBarThumbStyles(thumb:Button):void
		{
			var defaultSkin:Scale3Image = new Scale3Image(this.horizontalScrollBarThumbSkinTextures, this.scale * 0.7);
			defaultSkin.width = this.smallGutterSize;
			thumb.defaultSkin = defaultSkin;
			thumb.hasLabelTextRenderer = false;
		}
		
		protected function setVerticalSimpleScrollBarThumbStyles(thumb:Button):void
		{
			var defaultSkin:Scale3Image = new Scale3Image(this.verticalScrollBarThumbSkinTextures, this.scale * 0.7);
			defaultSkin.height = this.smallGutterSize;
			thumb.defaultSkin = defaultSkin;
			thumb.hasLabelTextRenderer = false;
		}
		
		//-------------------------
		// Slider
		//-------------------------
		
		protected function setSliderStyles(slider:Slider):void
		{
			slider.trackLayoutMode = Slider.TRACK_LAYOUT_MODE_MIN_MAX;
			if(slider.direction == Slider.DIRECTION_VERTICAL)
			{
				slider.customMinimumTrackName = THEME_NAME_VERTICAL_SLIDER_MINIMUM_TRACK;
				slider.customMaximumTrackName = THEME_NAME_VERTICAL_SLIDER_MAXIMUM_TRACK;
			}
			else
			{
				slider.customMinimumTrackName = THEME_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK;
				slider.customMaximumTrackName = THEME_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK;
			}
		}
		
		protected function setHorizontalSliderMinimumTrackStyles(track:Button):void
		{			
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			var rect:Rectangle = new Rectangle(18, 18, 142, 14);
			skinSelector.defaultValue = new Scale9Textures(this.atlas.getTexture("slider_left"), rect); 
			skinSelector.setValueForState(new Scale9Textures(this.atlas.getTexture("slider_left"), rect), Button.STATE_DOWN, false);
			skinSelector.setValueForState(new Scale9Textures(this.atlas.getTexture("slider_left_dis"), rect), Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
				{
					textureScale: this.scale
				};
			skinSelector.displayObjectProperties.width = this.wideControlSize;
			skinSelector.displayObjectProperties.height = this.controlSize;
			track.stateToSkinFunction = skinSelector.updateValue;
			track.hasLabelTextRenderer = false;
		}
		
		protected function setHorizontalSliderMaximumTrackStyles(track:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			var rect:Rectangle = new Rectangle(18, 18, 142, 14);
			skinSelector.defaultValue = new Scale9Textures(this.atlas.getTexture("slider_right"), rect); 
			skinSelector.setValueForState(new Scale9Textures(this.atlas.getTexture("slider_right"), rect), Button.STATE_DOWN, false);
			skinSelector.setValueForState(new Scale9Textures(this.atlas.getTexture("slider_right_dis"), rect), Button.STATE_DISABLED, false);
			
			skinSelector.displayObjectProperties =
				{
					textureScale: this.scale
				};
			skinSelector.displayObjectProperties.width = this.wideControlSize;
			skinSelector.displayObjectProperties.height = this.controlSize;
			track.stateToSkinFunction = skinSelector.updateValue;
			track.hasLabelTextRenderer = false;
		}
		
		protected function setVerticalSliderMinimumTrackStyles(track:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			var rect:Rectangle = new Rectangle(18, 18, 14, 142);
			skinSelector.defaultValue = new Scale9Textures(this.atlas.getTexture("v_slider_left"), rect); 
			skinSelector.setValueForState(new Scale9Textures(this.atlas.getTexture("v_slider_left"), rect), Button.STATE_DOWN, false);
			skinSelector.setValueForState(new Scale9Textures(this.atlas.getTexture("v_slider_left_dis"), rect), Button.STATE_DISABLED, false);
			
			skinSelector.displayObjectProperties =
				{
					textureScale: this.scale
				};
			skinSelector.displayObjectProperties.width = this.controlSize;
			skinSelector.displayObjectProperties.height = this.wideControlSize;
			track.stateToSkinFunction = skinSelector.updateValue;
			track.hasLabelTextRenderer = false;
		}
		
		protected function setVerticalSliderMaximumTrackStyles(track:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			var rect:Rectangle = new Rectangle(18, 18, 14, 142);
			skinSelector.defaultValue = new Scale9Textures(this.atlas.getTexture("v_slider_right"), rect);
			skinSelector.setValueForState(new Scale9Textures(this.atlas.getTexture("v_slider_right"), rect), Button.STATE_DOWN, false);
			skinSelector.setValueForState(new Scale9Textures(this.atlas.getTexture("v_slider_right_dis"), rect), Button.STATE_DISABLED, false);
			
			skinSelector.displayObjectProperties =
				{
					textureScale: this.scale
				};
			skinSelector.displayObjectProperties.width = this.controlSize;
			skinSelector.displayObjectProperties.height = this.wideControlSize;
			track.stateToSkinFunction = skinSelector.updateValue;
			track.hasLabelTextRenderer = false;
		}
		
		//-------------------------
		// SpinnerList
		//-------------------------
		
		protected function setSpinnerListStyles(list:SpinnerList):void
		{
			this.setListStyles(list);
			list.customItemRendererStyleName = THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER;
			
			list.selectionOverlaySkin = new Scale9Image(this.spinnerListSelectionOverlaySkinTextures, this.scale);
		}
		
		protected function setSpinnerListItemRendererStyles(renderer:DefaultListItemRenderer):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.itemRendererUpSkinTextures;
			skinSelector.displayObjectProperties =
				{
					width: this.gridSize,
						height: this.gridSize,
						textureScale: this.scale
				};
			renderer.stateToSkinFunction = skinSelector.updateValue;
			
			renderer.defaultLabelProperties.elementFormat = this.largeDarkElementFormat;
			renderer.disabledLabelProperties.elementFormat = this.largeDisabledElementFormat;
			
			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingTop = this.smallGutterSize;
			renderer.paddingBottom = this.smallGutterSize;
			renderer.paddingLeft = this.gutterSize;
			renderer.paddingRight = this.gutterSize;
			renderer.gap = this.gutterSize;
			renderer.minGap = this.gutterSize;
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.minAccessoryGap = this.gutterSize;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.minWidth = this.gridSize;
			renderer.minHeight = this.gridSize;
			renderer.minTouchWidth = this.gridSize;
			renderer.minTouchHeight = this.gridSize;
			
			renderer.accessoryLoaderFactory = this.imageLoaderFactory_noSmoothing;
			renderer.iconLoaderFactory = this.imageLoaderFactory_noSmoothing;
		}
		
		//-------------------------
		// TabBar
		//-------------------------
		
		protected function setTabBarStyles(tabBar:TabBar):void
		{
			tabBar.distributeTabSizes = true;
		}
		
		protected function setTabStyles(tab:ToggleButton):void
		{
			var defaultSkin:Quad = new Quad(this.gridSize, this.gridSize, TAB_BACKGROUND_COLOR);
			tab.defaultSkin = defaultSkin;
			
			var downSkin:Scale9Image = new Scale9Image(this.tabDownSkinTextures, this.scale);
			tab.downSkin = downSkin;
			
			var defaultSelectedSkin:Scale9Image = new Scale9Image(this.tabSelectedSkinTextures, this.scale);
			tab.defaultSelectedSkin = defaultSelectedSkin;
			
			var disabledSkin:Quad = new Quad(this.gridSize, this.gridSize, TAB_DISABLED_BACKGROUND_COLOR);
			tab.disabledSkin = disabledSkin;
			
			var selectedDisabledSkin:Scale9Image = new Scale9Image(this.tabSelectedDisabledSkinTextures, this.scale);
			tab.selectedDisabledSkin = selectedDisabledSkin;
			
			tab.defaultLabelProperties.elementFormat = this.lightUIElementFormat;
			tab.defaultSelectedLabelProperties.elementFormat = this.lightUIElementFormat;
			tab.disabledLabelProperties.elementFormat = this.lightUIDisabledElementFormat;
			tab.selectedDisabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;
			
			tab.paddingTop = this.smallGutterSize;
			tab.paddingBottom = this.smallGutterSize;
			tab.paddingLeft = this.gutterSize;
			tab.paddingRight = this.gutterSize;
			tab.gap = this.smallGutterSize;
			tab.minGap = this.smallGutterSize;
			tab.minWidth = tab.minHeight = this.gridSize;
			tab.minTouchWidth = tab.minTouchHeight = this.gridSize;
		}
		
		//-------------------------
		// TextArea
		//-------------------------
		
		protected function setTextAreaStyles(textArea:TextArea):void
		{
			this.setScrollerStyles(textArea);
			
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = skin_text_input;
			skinSelector.setValueForState(skin_text_input, TextArea.STATE_DISABLED);
			skinSelector.setValueForState(skin_text_input_focus, TextArea.STATE_FOCUSED);
			skinSelector.displayObjectProperties =
			{
			width: this.wideControlSize,
			height: this.controlSize * 4,
			textureScale: this.scale
			};
			textArea.stateToSkinFunction = skinSelector.updateValue;
			
			textArea.textEditorProperties.textFormat = this.scrollTextTextFormat;

			textArea.paddingTop = 10;
			textArea.paddingBottom = 10;
			textArea.paddingRight = 10;
			textArea.paddingLeft = 10;
			
			textArea.interactionMode = ScrollContainer.INTERACTION_MODE_MOUSE;
			textArea.scrollBarDisplayMode = ScrollContainer.SCROLL_BAR_DISPLAY_MODE_FIXED;
			
		}
		
		//-------------------------
		// TextInput
		//-------------------------
		
		protected function setBaseTextInputStyles(input:TextInput):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();			
			skinSelector.defaultValue = skin_text_input;
			skinSelector.setValueForState(skin_text_input, TextInput.STATE_DISABLED);
			skinSelector.setValueForState(skin_text_input_focus, TextInput.STATE_FOCUSED);
			skinSelector.displayObjectProperties =
				{
					width: this.wideControlSize,
						height: this.controlSize,
						textureScale: this.scale
				};
			input.stateToSkinFunction = skinSelector.updateValue;
			
			input.minWidth = this.controlSize;
			input.minHeight = this.controlSize;
			input.minTouchWidth = this.gridSize;
			input.minTouchHeight = this.gridSize;
			input.gap = this.smallGutterSize;
			input.padding = this.smallGutterSize;
			
			input.textEditorProperties.fontFamily = "Helvetica";
			input.textEditorProperties.fontSize = this.regularFontSize;
			input.textEditorProperties.color = DARK_TEXT_COLOR;
			input.textEditorProperties.disabledColor = DISABLED_TEXT_COLOR;
			
			input.promptProperties.elementFormat = this.darkElementFormat;
			input.promptProperties.disabledElementFormat = this.disabledElementFormat;
		}
		
		protected function setTextInputStyles(input:TextInput):void
		{
			this.setBaseTextInputStyles(input);
		}
		
		protected function setSearchTextInputStyles(input:TextInput):void
		{
			this.setBaseTextInputStyles(input);
			
			var iconSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			iconSelector.setValueTypeHandler(SubTexture, textureValueTypeHandler);
			iconSelector.defaultValue = this.searchIconTexture;
			iconSelector.setValueForState(this.searchIconDisabledTexture, TextInput.STATE_DISABLED, false);
			iconSelector.displayObjectProperties =
				{
					textureScale: this.scale,
						snapToPixels: true
				}
			input.stateToIconFunction = iconSelector.updateValue;
		}
		
		//-------------------------
		// ToggleSwitch
		//-------------------------
		
		protected function setToggleSwitchStyles(toggle:ToggleSwitch):void
		{
			toggle.trackLayoutMode = ToggleSwitch.TRACK_LAYOUT_MODE_SINGLE;
			
			toggle.defaultLabelProperties.elementFormat = this.lightUIElementFormat;
			toggle.onLabelProperties.elementFormat = this.selectedUIElementFormat;
			toggle.disabledLabelProperties.elementFormat = this.lightUIDisabledElementFormat;
			
			toggle.paddingLeft = 10;
			toggle.paddingRight = 10;
			
		}
		
		//see Shared section for thumb styles
		
		protected function setToggleSwitchTrackStyles(track:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonCallToActionUpSkinTextures; //this.backgroundSkinTextures;
			skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
				{
					width: Math.round(this.controlSize * 2),
						height: this.controlSize,
						textureScale: this.scale
				};
			track.stateToSkinFunction = skinSelector.updateValue;
			track.hasLabelTextRenderer = false;
		}
		
	}
}