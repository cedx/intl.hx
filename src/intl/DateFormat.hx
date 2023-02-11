package intl;

#if java
import java.text.DateFormat as NativeDateFormat;
import java.util.Date as NativeDate;
import java.util.Locale;
#elseif js
import js.lib.Date as NativeDate;
import js.lib.intl.DateTimeFormat as NativeDateFormat;
#elseif php
import php.DateTime as NativeDate;
import php.IntlDateFormatter as NativeDateFormat;
#else
#error "This compilation target is not supported."
#end

/** Formats dates in a locale-dependent manner. **/
abstract DateFormat(NativeDateFormat) to NativeDateFormat {

	/** Creates a new date/time format. **/
	public function new(locale: String, options: DateFormatOptions) {
		#if java
			final locale = Locale.forLanguageTag(locale);
			switch options {
				case {dateStyle: dateStyle, timeStyle: null} if (dateStyle != null): this = NativeDateFormat.getDateInstance(dateStyle, locale);
				case {dateStyle: null, timeStyle: timeStyle} if (timeStyle != null): this = NativeDateFormat.getTimeInstance(timeStyle, locale);
				default: this = NativeDateFormat.getDateTimeInstance(options.dateStyle, options.timeStyle, locale);
			}
		#elseif js
			this = new NativeDateFormat(locale, cast options);
		#else
			final dateStyle = options.dateStyle != null ? options.dateStyle : NativeDateFormat.NONE;
			final timeStyle = options.timeStyle != null ? options.timeStyle : NativeDateFormat.NONE;
			this = new NativeDateFormat(locale, dateStyle, timeStyle);
		#end
	}

	/** Formats the specified `date`. **/
	public function format(date: Date): String {
		#if java
			return this.format(new NativeDate(date.getTime()));
		#elseif js
			return this.format(NativeDate.fromHaxeDate(date));
		#else
			final timestamp = date.getTime() / 1000;
			return this.format(new NativeDate('@$timestamp'));
		#end
	}
}

/** Defines the options of a `DateFormat` instance. **/
typedef DateFormatOptions = {

	/** The date style. **/
	var ?dateStyle: DateTimeStyle;

	/** The time style. **/
	var ?timeStyle: DateTimeStyle;
}

/** Provides static extensions for dates. **/
abstract class DateFormatTools {

	/** Converts the specified `date` to a locale-dependent string. **/
	public static inline function toLocaleString(date: Date, locale: String, options: DateFormatOptions)
		return #if js NativeDate.fromHaxeDate(date).toLocaleString(locale, cast options) #else new DateFormat(locale, options).format(date) #end;
}

/** Specifies the formatting style of a date or time. **/
enum abstract DateTimeStyle(#if js String #else Int #end) to #if js String #else Int #end {

	/** Full style. **/
	var Full = #if js "full" #else 0 #end;

	/** Long style. **/
	var Long = #if js "long" #else 1 #end;

	/** Medium style. **/
	var Medium = #if js "medium" #else 2 #end;

	/** Short style. **/
	var Short = #if js "short" #else 3 #end;
}
