package intl;

import intl.DateFormat.DateFormatOptions;
using intl.DateFormat.DateFormatTools;

/** Tests the features of the `DateFormat` class. **/
@:asserts final class DateFormatTest {

	/** Creates a new test. **/
	public function new() {}

	/** Tests the `format()` method. **/
	@:variant("2020-07-15 12:30:00", {dateStyle: intl.DateFormat.DateFormatStyle.Short}, "15/07/2020")
	@:variant("2020-07-15 12:30:00", {dateStyle: intl.DateFormat.DateFormatStyle.Medium}, "15 juil. 2020")
	@:variant("2020-07-15 12:30:00", {dateStyle: intl.DateFormat.DateFormatStyle.Long}, "15 juillet 2020")
	@:variant("2020-07-15 12:30:00", {dateStyle: intl.DateFormat.DateFormatStyle.Full}, "mercredi 15 juillet 2020")
	@:variant("2020-07-15 12:30:00", {timeStyle: intl.DateFormat.DateFormatStyle.Short}, "12:30")
	@:variant("2020-07-15 12:30:00", {timeStyle: intl.DateFormat.DateFormatStyle.Medium}, "12:30:00")
	public function format(input: String, style: DateFormatOptions, output: String) {
		final date = Date.fromString(input);
		asserts.assert(new DateFormat("fr-FR", style).format(date) == output);
		asserts.assert(date.toLocaleString("fr-FR", style) == output);
		return asserts.done();
	}
}
