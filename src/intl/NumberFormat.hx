package intl;

import haxe.exceptions.ArgumentException;

#if java
import java.text.NumberFormat as JavaNumberFormat;
import java.util.Currency as JavaCurrency;
#elseif js
import js.Lib;
import js.Syntax;
import js.lib.intl.NumberFormat as JsNumberFormat;
import js.lib.intl.NumberFormat.NumberFormatStyle;
#else
import php.NumberFormatter;
#end

/** Formats numbers in a locale-dependent manner. **/
abstract NumberFormat(#if php NumberFormatOptions #else NativeNumberFormat #end) #if !php from NativeNumberFormat #end {

	/** Creates a new number format. **/
	public function new(locale: String, ?style: NumberStyle, ?currency: String) {
		if (style == null) style = Decimal;
		if (style == Currency && currency == null) throw new ArgumentException("currency", "The currency code is required.");

		#if java
			final locale = new Locale(locale);
			switch style {
				case Currency: this = JavaNumberFormat.getCurrencyInstance(locale); this.setCurrency(JavaCurrency.getInstance(currency));
				case Percent: this = JavaNumberFormat.getPercentInstance(locale);
				default: this = JavaNumberFormat.getNumberInstance(locale);
			}
		#elseif js
			this = new JsNumberFormat(locale, {currency: currency != null ? currency : Lib.undefined, style: style});
		#else
			this = {currency: currency, formatter: new NumberFormatter(locale, style)};
		#end
	}

	/** Formats the specified `number`. **/
	public function format(number: Float) return
		#if php this.currency != null ? this.formatCurrency(number, this.currency) : this.format(number)
		#else this.format(number) #end;

	/** Returns the native number format. **/
	@:to inline function toNative() return #if php this.formatter #else this #end;
}

#if php
/** Defines the options of a `NumberFormat` instance. **/
typedef NumberFormatOptions = {

	/** The currency code. **/
	var ?currency: String;

	/** The native number format. **/
	var formatter: NativeNumberFormat;
};
#end

/** Provides static extensions for numbers. **/
abstract class NumberFormatTools {

	/** Converts the specified `number` to a locale-dependent string. **/
	public static inline function toLocaleString(number: Float, locale: String, ?style: NumberStyle, ?currency: String) return
		#if js Syntax.code("{0}.toLocaleString({currency: {1}, style: {2}})", number, currency != null ? currency : Lib.undefined, style)
		#else new NumberFormat(locale, style, currency).format(number) #end;
}

/** Specifies the formatting style of a number. **/
#if js
typedef NumberStyle = NumberFormatStyle;
#else
enum abstract NumberStyle(Int) to Int {

	/** Decimal style. **/
	var Decimal = 1;

	/** Currency style. **/
	var Currency;

	/** Percent style. **/
	var Percent;
}
#end

/** The underlying native number format. **/
private typedef NativeNumberFormat = #if java JavaNumberFormat #elseif js JsNumberFormat #else NumberFormatter #end;
