package intl;

#if java
import java.text.NumberFormat as NativeNumberFormat;
import java.util.Currency as JavaCurrency;
#elseif js
import js.Lib;
import js.Syntax;
import js.lib.intl.NumberFormat as NativeNumberFormat;
import js.lib.intl.NumberFormat.NumberFormatOptions as JsNumberFormatOptions;
#else
import php.NumberFormatter as NativeNumberFormat;
#end

/** Formats numbers in a locale-dependent manner. **/
abstract NumberFormat(#if php NumberFormatObject #else NativeNumberFormat #end) #if (java || js) from NativeNumberFormat to NativeNumberFormat #end {

	/** Creates a new number format. **/
	public #if js inline #end function new(locale: Locale, ?options: NumberFormatOptions) {
		#if java
			switch options?.style {
				case Currency: this = NativeNumberFormat.getCurrencyInstance(locale); this.setCurrency(JavaCurrency.getInstance(options.currency));
				case Percent: this = NativeNumberFormat.getPercentInstance(locale);
				case _: this = NativeNumberFormat.getNumberInstance(locale);
			}
		#elseif js
			this = new NativeNumberFormat(locale, options ?? Lib.undefined);
		#else
			this = {
				currency: options?.style == Currency ? options.currency : null,
				formatter: new NativeNumberFormat(locale, options?.style ?? Decimal)
			};
		#end
	}

	/** Formats the specified `number`. **/
	public #if !php inline #end function format(number: Float): String return
		#if php this.currency != null ? this.formatter.formatCurrency(number, this.currency) : this.formatter.format(number)
		#else this.format(number) #end;

	#if php
	/** Converts this object to a native number formatter. **/
	@:to public inline function toNumberFormatter(): NativeNumberFormat
		return this.formatter;
	#end
}

#if php
/** Defines the underlying type of a `NumberFormat` instance. **/
private typedef NumberFormatObject = {

	/** The currency code. **/
	var ?currency: String;

	/** The native number format. **/
	var formatter: NativeNumberFormat;
};
#end

/** Defines the options of a `NumberFormat` instance. **/
typedef NumberFormatOptions = #if js JsNumberFormatOptions & #end {

	/** The currency code. **/
	var ?currency: String;

	#if !js
	/** The formatting style. **/
	var ?style: NumberFormatStyle;
	#end

	#if js
	/** The unit to use in `NumberFormatStyle.Unit` formatting. **/
	var ?unit: SimpleUnit;

	/** The unit formatting style to use in `NumberFormatStyle.Unit` formatting. **/
	var ?unitDisplay: NumberFormatUnitDisplay;
	#end
}

/** Provides static extensions for numbers. **/
abstract class NumberFormatTools {

	/** Converts the specified `number` to a locale-dependent string. **/
	public static #if js inline #end function toLocaleString(number: Float, locale: Locale, ?options: NumberFormatOptions): String return
		#if js Syntax.code("{0}.toLocaleString({1}, {2})", number, locale, options ?? Lib.undefined)
		#else new NumberFormat(locale, options).format(number) #end;
}

/** Specifies the formatting style of a number. **/
enum abstract NumberFormatStyle(#if js String #else Int #end) to #if js String #else Int #end {

	/** Plain number formatting. **/
	var Decimal = #if js "decimal" #else 1 #end;

	/** Currency formatting. **/
	var Currency = #if js "currency" #else 2 #end;

	/** Percent formatting. **/
	var Percent = #if js "percent" #else 3 #end;

	#if js
	/** Unit formatting. **/
	var Unit = "unit";
	#end
}

/** Defines the unit formatting style. **/
enum abstract NumberFormatUnitDisplay(String) to String {

	/** Long formatting. **/
	var Long = "long";

	/** Narrow formatting. **/
	var Narrow = "narrow";

	/** Short formatting. **/
	var Short = "short";
}
