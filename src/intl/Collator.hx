package intl;

#if java
import java.text.Collator as JavaCollator;
#elseif js
import js.lib.intl.Collator as JsCollator;
import js.lib.intl.Collator.Sensitivity;
#else
import php.Collator as PhpCollator;
#end

/** The underlying native collator. **/
private typedef NativeCollator = #if java JavaCollator #elseif js JsCollator #else PhpCollator #end;

/** Provides string comparison capability with support for appropriate locale-sensitive sort orderings. **/
@:forward(compare)
abstract Collator(NativeCollator) from NativeCollator to NativeCollator {

	/** Creates a new date format. **/
	public #if js inline #end function new(locale: String, options: CollatorOptions) {
		#if java
			this = JavaCollator.getInstance(new Locale(locale));
			this.setStrength(options.strength != null ? options.strength : Identical);
		#elseif js
			this = new JsCollator(locale, {sensitivity: options.strength != null ? options.strength : Identical});
		#else
			this = new PhpCollator(locale);
			this.setStrength(options.strength != null ? options.strength : Identical);
		#end
	}
}

/** Defines the options of a `Collator` instance. **/
typedef CollatorOptions = {

	/** The collation strength. **/
	var ?strength: CollatorStrength;
}

/** Specifies the strength of a collator. **/
enum abstract CollatorStrength(#if js Sensitivity #else Int #end) to #if js Sensitivity #else Int #end {

	/** Denotes differences between base characters. **/
	var Primary = #if js Base #else 0 #end;

	/** Accents in the characters are considered secondary differences. **/
	var Secondary = #if js Accent #else 1 #end;

	/** Upper and lower case differences in characters are distinguished. **/
	var Tertiary = #if js Case #else 2 #end;

	/** When all other levels are equal, the `Identical` level is used as a tiebreaker. **/
	var Identical = #if java 3 #elseif js Variant #else 15 #end;
}
