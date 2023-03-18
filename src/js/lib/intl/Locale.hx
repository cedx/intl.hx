package js.lib.intl;

/** Represents a Unicode identifier used to get language, culture, or regionally-specific behavior. **/
@:native("Intl.Locale")
extern class Locale {

	/** The language code. **/
	final language: String;

	/** The country/region code. **/
	final region: String;

	/** Creates a new locale. **/
	function new(tag: String);

	/** Returns a string representation of this object. **/
	function toString(): String;
}
