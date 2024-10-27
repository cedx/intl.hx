package intl;

#if js
import js.lib.intl.Collator.Sensitivity;
#end

/** The underlying native collator. **/
private typedef NativeCollator = #if java java.text.Collator #elseif js js.lib.intl.Collator #else php.Collator #end;

/** Provides string comparison capability with support for appropriate locale-sensitive sort orderings. **/
@:forward(compare)
abstract Collator(NativeCollator) from NativeCollator to NativeCollator {

	/** Creates a new date format. **/
	public #if js inline #end function new(locale: Locale, ?options: CollatorOptions) {
		#if java
			this = NativeCollator.getInstance(locale);
			this.setStrength(options?.strength ?? Identical);
		#elseif js
			this = new NativeCollator(locale, {sensitivity: options?.strength ?? Identical});
		#else
			this = new NativeCollator(locale);
			this.setStrength(options?.strength ?? Identical);
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

	/** When all other levels are equal, the `Identical` level is used to break the tie. **/
	var Identical = #if java 3 #elseif js Variant #else 15 #end;
}
