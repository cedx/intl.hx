package intl;

#if java
import java.text.DateFormat as NativeDateFormat;
import java.util.Date as JavaDate;
import java.util.TimeZone;
#elseif js
import js.Lib;
import js.lib.Date as JsDate;
import js.lib.intl.DateTimeFormat as NativeDateFormat;
import js.lib.intl.DateTimeFormat.DateTimeFormatOptions;
#else
import php.DateTime;
import php.IntlDateFormatter as NativeDateFormat;
#end

using DateTools;

/** Formats dates in a locale-dependent manner. **/
abstract DateFormat(NativeDateFormat) from NativeDateFormat to NativeDateFormat {

	/** Creates a new date format. **/
	public #if js inline #end function new(locale: Locale, ?options: DateFormatOptions) {
		#if java
			this = switch options {
				case {dateStyle: dateStyle, timeStyle: null} if (dateStyle != null):
					NativeDateFormat.getDateInstance(dateStyle, locale);
				case {dateStyle: null, timeStyle: timeStyle} if (timeStyle != null):
					NativeDateFormat.getTimeInstance(timeStyle, locale);
				case _:
					final dateStyle = options?.dateStyle ?? NativeDateFormat.DEFAULT;
					final timeStyle = options?.timeStyle ?? NativeDateFormat.DEFAULT;
					NativeDateFormat.getDateTimeInstance(dateStyle, timeStyle, locale);
			}

			if (options?.timeZone != null) this.setTimeZone(TimeZone.getTimeZone(options.timeZone));
		#elseif js
			this = new NativeDateFormat(locale, options ?? Lib.undefined);
		#else
			final dateStyle = options?.dateStyle ?? NativeDateFormat.NONE;
			final timeStyle = options?.timeStyle ?? NativeDateFormat.NONE;
			this = new NativeDateFormat(locale, dateStyle, timeStyle, options?.timeZone);
		#end
	}

	/** Formats the specified `date`. **/
	public inline function format(date: Date): String return
		#if java this.format(new JavaDate(date.getTime()))
		#elseif js this.format(JsDate.fromHaxeDate(date))
		#else this.format(new DateTime('@${Std.int(date.getTime() / 1.seconds())}')) #end;
}

/** Defines the options of a `DateFormat` instance. **/
typedef DateFormatOptions = #if js DateTimeFormatOptions & #end {

	/** The date style. **/
	var ?dateStyle: DateFormatStyle;

	/** The time style. **/
	var ?timeStyle: DateFormatStyle;

	#if !js
	/** The time zone. **/
	var ?timeZone: String;
	#end
}

/** Specifies the formatting style of a date or time. **/
enum abstract DateFormatStyle(#if js String #else Int #end) to #if js String #else Int #end {

	/** Full style. **/
	var Full = #if js "full" #else 0 #end;

	/** Long style. **/
	var Long = #if js "long" #else 1 #end;

	/** Medium style. **/
	var Medium = #if js "medium" #else 2 #end;

	/** Short style. **/
	var Short = #if js "short" #else 3 #end;
}

/** Provides static extensions for dates. **/
abstract class DateFormatTools {

	/** Converts the specified `date` to a locale-dependent string. **/
	public static #if js inline #end function toLocaleString(date: Date, locale: Locale, ?options: DateFormatOptions): String return
		#if js JsDate.fromHaxeDate(date).toLocaleString(locale, cast options ?? Lib.undefined)
		#else new DateFormat(locale, options).format(date) #end;
}
