package intl;

import intl.NumberFormat.NumberStyle;
using StringTools;
using intl.NumberFormat.NumberFormatTools;

/** Tests the features of the `NumberFormat` class. **/
@:asserts final class NumberFormatTest {

	/** Creates a new test. **/
	public function new() {}

	/** Tests the `format()` method. **/
	@:variant(123, intl.NumberFormat.NumberStyle.Currency, "123,00 €")
	@:variant(456.789, intl.NumberFormat.NumberStyle.Decimal, "456,789")
	@:variant(0.55, intl.NumberFormat.NumberStyle.Percent, "55 %")
	public function testFormat(input: Float, style: NumberStyle, output: String) {
		asserts.assert(normalize(new NumberFormat("fr-FR", style, "EUR").format(input)) == output);
		asserts.assert(normalize(input.toLocaleString("fr-FR", style, "EUR")) == output);
		return asserts.done();
	}

	/** Normalizes the white spaces of the specified localized number. **/
	function normalize(localizedNumber: String) return ~/\s/.replace(localizedNumber, " ");
}
