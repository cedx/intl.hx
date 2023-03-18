package java.text;

import java.util.Locale;

/** Provides string comparison capability with support for appropriate locale-sensitive sort orderings. **/
extern class Collator {

	/** Gets the collator for the specified `locale`. **/
	static function getInstance(locale: Locale): Collator;

	/** Compares two strings according to the sort order of this collator. **/
	function compare(source: String, target: String): Int;

	/** Sets the collation strength. **/
	function setStrength(value: Int): Void;
}
