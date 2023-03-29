package intl;

#if java
import java.util.TimeZone as JavaTimeZone;
#elseif php
import php.IntlTimeZone;
#end

/** The underlying native time zone. **/
private typedef NativeTimeZone = #if java JavaTimeZone #elseif js String #else IntlTimeZone #end;

/** Represents a time zone offset, and also figures out daylight savings. **/
abstract TimeZone(NativeTimeZone) from NativeTimeZone to NativeTimeZone {

	#if (java || php)
	/** The default locale. **/
	public static var defaultTimeZone(get, #if java set #else never #end): TimeZone;
		static inline function get_defaultTimeZone()
			return #if java JavaTimeZone.getDefault() #else IntlTimeZone.createDefault() #end;
		#if java static function set_defaultTimeZone(value: TimeZone) {
			JavaTimeZone.setDefault(value);
			return value;
		} #end

	/** The localized display name for this time zone. **/
	public var displayName(get, never): String;
		inline function get_displayName() return getDisplayName(Locale.defaultLocale);

	/** The amount of time to be added to local standard time to get local wall clock time. **/
	public var dstSavings(get, never): Int;
		inline function get_dstSavings() return this.getDSTSavings();

	/** The identifier of this time zone. **/
	public var id(get, never): String;
		inline function get_id() return toString();

	/** The amount of time in milliseconds to add to UTC to get standard time in this time zone. **/
	public var rawOffset(get, never): Int;
		inline function get_rawOffset() return this.getRawOffset();

	/** Value indicating whether this time zone uses Daylight Saving Time. **/
	public var useDaylightTime(get, never): Bool;
		inline function get_useDaylightTime() return this.useDaylightTime();
	#end

	/** Creates a new time zone. **/
	public inline function new(id: String)
		this = #if java JavaTimeZone.getTimeZone(id) #elseif js id #else IntlTimeZone.createTimeZone(id) #end;

	#if (java || php)
	/** Returns an appropriately localized display name for the specified `locale`. **/
	public function getDisplayName(locale: String, ?options: TimeZoneOptions): String {
		if (options == null) options = {};
		final daylight = options.daylight != null ? options.daylight : false;
		final style = options.style != null ? options.style : Long;
		return #if java this.getDisplayName(daylight, style, new Locale(locale)) #else this.getDisplayName(daylight, style, locale) #end;
	}
	#end

	/** Returns a string representation of this object. **/
	@:to public inline function toString()
		return #if java this.getID() #elseif js this #else this.getID() #end;
}

/** Defines the options of a `TimeZone` instance. **/
typedef TimeZoneOptions = {

	/** The date style. **/
	var ?daylight: Bool;

	/** The time style. **/
	var ?style: TimeZoneStyle;
}

/** Specifies the formatting style of a time zone. **/
enum abstract TimeZoneStyle(Int) to Int {

	/** Short style. **/
	var Short = #if java 0 #else 1 #end;

	/** Long style. **/
	var Long = #if java 1 #else 2 #end;
}
