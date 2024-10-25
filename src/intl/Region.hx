package intl;

using StringTools;

/** Represents a country/region. **/
@:jsonParse(json -> new intl.Region(json))
@:jsonStringify(region -> region.toString())
abstract Region(String) {

	#if (java || php)
	/** The list of all regions. **/
	public static var all(get, never): Array<Region>;
		static function get_all() {
			#if java
				final codes = java.Lib.array(java.util.Locale.getISOCountries());
			#else
				final codes = [];
				for (locale in php.Lib.toHaxeArray(php.ResourceBundle.getLocales(""))) if (~/_[A-Z]{2}$/.match(locale)) {
					final code = locale.split("_").pop();
					if (!codes.contains(code)) codes.push(code);
				}
			#end

			codes.sort(Reflect.compare);
			return codes.map(Region.new);
		}
	#end

	/** The ISO 3166-1 alpha-2 code. **/
	public var code(get, never): String;
		inline function get_code() return this;

	#if (java || php)
	/** The localized display name for this region. **/
	public var displayName(get, never): String;
		inline function get_displayName() return getDisplayName(Locale.defaultLocale);
	#end

	/** The emoji flag corresponding to this region. **/
	public var emojiFlag(get, never): String;
		function get_emojiFlag() return [for (charCode in this) charCode + 127_397].map(String.fromCharCode).join("");

	/** Creates a new region from the specified ISO 3166-1 alpha-2 `code`. **/
	public inline function new(code: String)
		this = code.toUpperCase();

	/** Returns an appropriately localized display name for the specified `locale`. **/
	public inline function getDisplayName(locale: Locale): String
		return locale.getDisplayRegion(this);

	/** Creates a new region from the specified string. **/
	@:from static inline function ofString(value: String): Region
		return new Region(value);

	/** Returns a string representation of this object. **/
	@:to public inline function toString(): String
		return code;
}
