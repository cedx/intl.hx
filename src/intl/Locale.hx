package intl;

#if js
import js.lib.intl.DisplayNames;
#end

/** The underlying native locale. **/
private typedef NativeLocale = #if java java.util.Locale #elseif js js.lib.intl.Locale #else String #end;

/** Represents a Unicode identifier used to get language, culture, or regionally-specific behavior. **/
@:jsonParse(json -> new intl.Locale(json))
@:jsonStringify(locale -> locale.toString())
abstract Locale(NativeLocale) #if (java || js) from NativeLocale to NativeLocale #end {

	#if (java || php)
	/** The default locale. **/
	public static var defaultLocale(get, set): Locale;
		static inline function get_defaultLocale()
			return #if java NativeLocale.getDefault() #else php.Locale.getDefault() #end;
		static function set_defaultLocale(value: Locale) {
			#if java NativeLocale.setDefault(value) #else php.Locale.setDefault(value) #end;
			return value;
		}
	#end

	/** The localized display name for the language of this locale. **/
	public var displayLanguage(get, never): String;
		inline function get_displayLanguage() return getDisplayLanguage(language);

	/** The localized display name for the region of this locale. **/
	public var displayRegion(get, never): String;
		inline function get_displayRegion() return getDisplayRegion(region);

	/** The language code. **/
	public var language(get, never): String;
		inline function get_language()
			return #if java this.getLanguage() #elseif js this.language #else php.Locale.getPrimaryLanguage(this) #end;

	/** The country/region code. **/
	public var region(get, never): String;
		inline function get_region()
			return #if java this.getCountry() #elseif js this.region #else php.Locale.getRegion(this) #end;

	/** Creates a new locale from the specified language `tag`. **/
	public inline function new(tag: String)
		this = #if java NativeLocale.forLanguageTag(tag) #elseif js new NativeLocale(tag) #else tag #end;

	/** Returns an appropriately localized display name for the specified `language`. **/
	public function getDisplayLanguage(language: String): String return
		#if java NativeLocale.forLanguageTag('$language-$region').getDisplayLanguage(this)
		#elseif js new DisplayNames(toString(), cast {type: Language}).of(language)
		#else php.Locale.getDisplayLanguage('$language-$region', this) #end;

	/** Returns an appropriately localized display name for the specified `region`. **/
	public function getDisplayRegion(region: String): String return
		#if java NativeLocale.forLanguageTag('$language-$region').getDisplayCountry(this)
		#elseif js new DisplayNames(toString(), cast {type: Region}).of(region)
		#else php.Locale.getDisplayRegion('$language-$region', this) #end;

	/** Creates a new locale from the specified string. **/
	@:from static inline function ofString(value: String): Locale
		return new Locale(value);

	/** Returns a string representation of this object. **/
	@:to public inline function toString(): String
		return #if java this.toLanguageTag() #elseif js this.toString() #else this #end;
}
