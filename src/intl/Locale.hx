package intl;

#if java
import java.util.Locale as JavaLocale;
#elseif js
import js.Syntax;
import js.lib.intl.Locale as JsLocale;
#else
import php.Locale as PhpLocale;
#end

/** Represents a Unicode identifier used to get language, culture, or regionally-specific behavior. **/
abstract Locale(NativeLocale) from NativeLocale to NativeLocale {

	#if (java || php)
	/** The default locale. **/
	public static var defaultLocale(get, set): Locale;
		static function get_defaultLocale()
			return #if php PhpLocale.getDefault() #else JavaLocale.getDefault() #end;
		static function set_defaultLocale(value: Locale) {
			#if php PhpLocale.setDefault(value) #else JavaLocale.setDefault(value) #end;
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
		function get_language() return
			#if java this.getLanguage()
			#elseif js this.language
			#else PhpLocale.getPrimaryLanguage(this) #end;

	/** The country/region code. **/
	public var region(get, never): String;
		function get_region() return
			#if java this.getCountry()
			#elseif js this.region
			#else PhpLocale.getRegion(this) #end;

	/** Creates a new locale. **/
	public function new(tag: String)
		this = #if java JavaLocale.forLanguageTag(tag) #elseif js new JsLocale(tag) #else tag #end;

	/** Returns an appropriately localized display name for the specified `language`. **/
	public function getDisplayLanguage(language: String) return
		#if java JavaLocale.forLanguageTag('$language-$region').getDisplayLanguage(this)
		#elseif js Syntax.construct("Intl.DisplayNames", this, {type: "language"}).of(language)
		#else PhpLocale.getDisplayLanguage('$language-$region', this) #end;

	/** Returns an appropriately localized display name for the specified `region`. **/
	public function getDisplayRegion(region: String) return
		#if java JavaLocale.forLanguageTag('$language-$region').getDisplayCountry(this)
		#elseif js Syntax.construct("Intl.DisplayNames", this, {type: "region"}).of(region)
		#else PhpLocale.getDisplayRegion('$language-$region', this) #end;

	/** Returns a string representation of this object. **/
	@:to public inline function toString() return
		#if java this.toLanguageTag()
		#elseif js this.toString()
		#else this #end;
}

/** The underlying native date format. **/
private typedef NativeLocale = #if java JavaLocale #elseif js JsLocale #else String #end;
