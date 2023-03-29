package intl;

/** Tests the features of the `TimeZone` class. **/
@:asserts final class TimeZoneTest {

	/** Creates a new test. **/
	public function new() {}

	#if (java || php)
	/** Tests the `rawOffset` property. **/
	@:variant("Africa/Cairo", 7200000)
	@:variant("America/New_York", -18000000)
	@:variant("Asia/Tokyo", 32400000)
	@:variant("Europe/Paris", 3600000)
	public function testRawOffset(input: String, output: Int)
		return assert(new TimeZone(input).rawOffset == output);

	/** Tests the `useDaylightTime` property. **/
	@:variant("Africa/Cairo", false)
	@:variant("America/New_York", true)
	@:variant("Asia/Tokyo", false)
	@:variant("Europe/Paris", true)
	public function testUseDaylightTime(input: String, output: Bool)
		return assert(new TimeZone(input).useDaylightTime == output);

	/** Tests the `getDisplayName()` method. **/
	@:variant("Africa/Cairo", "Eastern European Standard Time", #if java "EET" #else "GMT+2" #end)
	@:variant("America/New_York", "Eastern Standard Time", "EST")
	@:variant("Asia/Tokyo", "Japan Standard Time", #if java "JST" #else "GMT+9" #end)
	@:variant("Europe/Paris", "Central European Standard Time", #if java "CET" #else "GMT+1" #end)
	public function testGetDisplayName(input: String, long: String, short: String) {
		final timeZone = new TimeZone(input);
		asserts.assert(timeZone.getDisplayName("en-US", {style: Long}) == long);
		asserts.assert(timeZone.getDisplayName("en-US", {style: Short}) == short);
		return asserts.done();
	}
	#end

	/** Tests the `toString()` method. **/
	@:variant("Africa/Cairo")
	@:variant("America/New_York")
	@:variant("Asia/Tokyo")
	@:variant("Europe/Paris")
	public function testToString(value: String)
		return assert(new TimeZone(value).toString() == value);
}
