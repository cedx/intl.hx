package intl;

/** Tests the features of the `TimeZone` class. **/
@:asserts final class TimeZoneTest {

	/** Creates a new test. **/
	public function new() {}

	#if (java || php)
	/** Tests the `rawOffset` property. **/
	@:variant("Africa/Cairo", 7_200_000)
	@:variant("America/New_York", -18_000_000)
	@:variant("Asia/Tokyo", 32_400_000)
	@:variant("Europe/Paris", 3_600_000)
	@:variant("Pacific/Honolulu", -36_000_000)
	public function rawOffset(input: String, output: Int)
		return assert(new TimeZone(input).rawOffset == output);

	/** Tests the `useDaylightTime` property. **/
	@:variant("Africa/Cairo", Sys.systemName() != "Windows")
	@:variant("America/New_York", true)
	@:variant("Asia/Tokyo", false)
	@:variant("Europe/Paris", true)
	@:variant("Pacific/Honolulu", false)
	public function useDaylightTime(input: String, output: Bool)
		return assert(new TimeZone(input).useDaylightTime == output);

	/** Tests the `getDisplayName()` method. **/
	@:variant("Africa/Cairo", "Eastern European Standard Time", #if java "EET" #else "GMT+2" #end)
	@:variant("America/New_York", "Eastern Standard Time", "EST")
	@:variant("Asia/Tokyo", "Japan Standard Time", #if java "JST" #else "GMT+9" #end)
	@:variant("Europe/Paris", "Central European Standard Time", #if java "CET" #else "GMT+1" #end)
	@:variant("Pacific/Honolulu", "Hawaii-Aleutian Standard Time", "HST")
	public function getDisplayName(input: String, long: String, short: String) {
		final timeZone = new TimeZone(input);
		asserts.assert(timeZone.getDisplayName("en-US", {style: Long}) == long);
		asserts.assert(timeZone.getDisplayName("en-US", {style: Short}) == short);
		return asserts.done();
	}
	#end
}
